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

    %{ method: method, path: path, resp_body: "" }
  end

  defp route(conn) do
    %{ conn | resp_body: "Twiglets, Crisps, Nuts" }
  end

  defp format_response(conn) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(conn.resp_body)}

    #{conn.resp_body}
    """
  end
end
