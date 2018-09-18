defmodule HttpServer.Handler do
  def handle(request) do
    request
    |> parse
    |> route
    |> format_response
  end

  def parse(request) do
    [req_head, req_body] = request |> String.split("\n\n")

    [method, path, _] =
      req_head
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{
      method: method,
      path: path,
      req_body: req_body,
      resp_body: "",
      status: ""
    }
  end

  defp route(conn = %{ method: "GET", path: path }) do
    ("vendor/cob_spec/public" <> path)
    |> Path.expand
    |> File.read
    |> handle_file(conn)
  end

  defp route(conn = %{ method: "PATCH", path: path }) do
    %{ conn | status: 204 }
  end

  def handle_file({:ok, resp_body}, conn) do
    %{ conn | resp_body: resp_body, status: 200 }
  end

  def handle_file({:error, :enoent}, conn) do
    %{ conn | resp_body: "File not found", status: 404 }
  end

  defp format_response(conn = %{ method: "GET"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conn.resp_body)}

    #{conn.resp_body}
    """
  end

  defp format_response(conn = %{ method: "PATCH"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Content-Location: #{conn.path}
    """
  end

  defp reason(status) do
    %{
      200 => "OK",
      204 => "No content",
      404 => "Not found"
    }[status]
  end
end
