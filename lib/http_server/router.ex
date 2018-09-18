defmodule HttpServer.Router do
  @public_dir "vendor/cob_spec/public"

  def route(conn = %{ method: "GET", path: path }) do
    @public_dir <> path
    |> File.read
    |> handle_file(conn)
  end

  def route(conn = %{ method: "PATCH", path: path }) do
    @public_dir <> path
    |> File.write(conn.req_body)

    %{ conn | status: 204 }
  end

  defp handle_file({:ok, resp_body}, conn) do
    %{ conn | resp_body: resp_body, status: 200 }
  end

  defp handle_file({:error, :enoent}, conn) do
    %{ conn | resp_body: "File not found", status: 404 }
  end

end
