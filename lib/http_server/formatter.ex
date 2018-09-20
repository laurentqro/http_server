defmodule HttpServer.Formatter do
  def format_response(conn = %{ method: "GET"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    Content-Type: text/html
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

  def format_response(conn = %{ method: "PUT"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    """
  end

  def format_response(conn = %{ method: "DELETE"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    """
  end

  def format_response(conn = %{ method: "HEAD"}) do
    """
    HTTP/1.1 #{conn.status} #{reason(conn.status)}
    """
  end

  defp reason(status) do
    %{
      200 => "OK",
      201 => "Created",
      204 => "No content",
      404 => "Not found"
    }[status]
  end
end
