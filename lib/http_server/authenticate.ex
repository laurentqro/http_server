defmodule HttpServer.Authenticate do
  def authenticate(conn) do
    %{ conn | status: 401, headers: build_headers(conn) }
  end

  defp build_headers(conn) do
    Map.merge(conn.headers, auth_headers())
  end

  defp auth_headers() do
    %{ "WWW-Authenticate" => ~s(Basic realm="Access to HTTP server") }
  end
end
