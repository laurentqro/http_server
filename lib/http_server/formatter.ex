defmodule HttpServer.Formatter do
  def format_response(conn = %{ method: "GET", path: "/logs" }) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    WWW-Authenticate: #{conn.headers["WWW-Authenticate"]}
    """
  end

  def format_response(conn = %{ method: "GET"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Content-Type: #{conn.content_type}
    Content-Length: #{String.length(conn.resp_body)}

    #{conn.resp_body}
    """
  end

  def format_response(conn = %{ method: "PATCH"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Content-Location: #{conn.path}
    """
  end

  def format_response(conn = %{ method: "OPTIONS"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Allow: #{conn.allow}
    """
  end

  def format_response(conn) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    """
  end

  defp reason(status) do
    %{
      200 => "OK",
      201 => "Created",
      204 => "No content",
      401 => "Unauthorized",
      404 => "Not found",
      405 => "Method not allowed"
    }[status]
  end
end
