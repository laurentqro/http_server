defmodule HttpServer.Handler do
  def handle(request) do
    request
    |> HttpServer.Parser.parse
    |> HttpServer.Router.route
    |> HttpServer.Formatter.format_response
  end
end
