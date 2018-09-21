defmodule HttpServer.Controllers.Put do
  @public_dir "vendor/cob_spec/public"

  def put(conn = %{ path: path }) do
    @public_dir <> path
    |> File.read
    |> handle_file(conn)
  end

  defp handle_file({:ok, _content}, conn = %{ path: path, req_body: req_body }) do
    @public_dir <> path
    |> File.write(req_body)

    %{ conn | status: 200 }
  end

  defp handle_file({:error, :enoent}, conn = %{ path: path, req_body: req_body }) do
    @public_dir <> path
    |> File.write(req_body)

    %{ conn | status: 201 }
  end
end
