defmodule HttpServer.Controllers.Head do
  @public_dir "vendor/cob_spec/public"

  def head(conn = %{ path: "/" }) do
    %{ conn | status: 200 }
  end

  def head(conn = %{ path: path }) do
    @public_dir <> path
    |> File.read
    |> handle_file(conn)
  end

  defp handle_file({:ok, resp_body}, conn) do
    %{ conn | resp_body: resp_body, status: 200 }
  end

  defp handle_file({:error, :enoent}, conn) do
    %{ conn | resp_body: "File not found", status: 404 }
  end
end
