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

  def route(conn = %{ method: "PUT", path: path }) do
    @public_dir <> path
    |> File.read
    |> handle_file(conn)
  end

  def route(conn = %{ method: "DELETE", path: path }) do
    IO.puts "DELETE at #{path}"
    @public_dir <> path
    |> File.rm

    %{ conn | status: 200 }
  end

  def route(conn = %{ method: "HEAD" }) do
    %{ conn | status: 200 }
  end

  defp handle_file({:ok, resp_body}, conn = %{ method: "GET" }) do
    %{ conn | resp_body: resp_body, status: 200 }
  end

  defp handle_file({:error, :enoent}, conn = %{ method: "GET" }) do
    %{ conn | resp_body: "File not found", status: 404 }
  end

  defp handle_file({:ok, _content}, conn = %{ method: "PUT" }) do
    @public_dir <> conn.path
    |> File.write(conn.req_body)

    %{ conn | status: 200 }
  end

  defp handle_file({:error, :enoent}, conn = %{ method: "PUT" }) do
    @public_dir <> conn.path
    |> File.write(conn.req_body)

    %{ conn | status: 201 }
  end
end
