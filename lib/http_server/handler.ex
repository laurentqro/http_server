defmodule HttpServer.Handler do
  def handle(request) do
    request
    |> parse
    |> route
    |> format_response
  end

  defp parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{ method: method, path: path, resp_body: "", status: "" }
  end

  defp route(conn = %{ method: "GET", path: path }) do
    ("vendor/cob_spec/public" <> path)
    |> Path.expand
    |> File.read
    |> handle(conn)
  end

  def handle({:ok, resp_body}, conn) do
    %{ conn | resp_body: resp_body, status: 200 }
  end

  defp format_response(conn) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Content-Type: text/html
    Content-Length: #{String.length(conn.resp_body)}

    #{conn.resp_body}
    """
  end

  defp reason(status) do
    %{
      200 => "OK"
    }[status]
  end
end
