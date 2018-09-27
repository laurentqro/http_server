defmodule HttpServer.Controllers.Get do
  @public_dir "vendor/cob_spec/public"

  def get(conn = %{ path: path }) do
    @public_dir <> path
    |> File.read
    |> handle_file(conn)
  end

  defp handle_file({:ok, resp_body}, conn) do
    %{ conn | resp_body: resp_body, status: 200, content_type: "image/jpeg" }
  end

  defp handle_file({:error, :enoent}, conn) do
    %{ conn | resp_body: "File not found", status: 404 }
  end

  defp handle_file({:error, :eisdir}, conn = %{ path: path }) do
    {:ok, files } = @public_dir <> path |> File.ls
    resp_body = files |> Enum.map(&to_link/1) |> Enum.join(" ")

    %{ conn | resp_body: resp_body, status: 200 }
  end

  defp to_link(file) do
    ~s(<a href="/#{file}">#{file}</a>)
  end
end
