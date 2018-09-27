defmodule HttpServer.Formatter.Test do
  use ExUnit.Case

  test "response to GET request" do
    conn = %{
      method: "GET",
      status: 200,
      resp_body: "Content",
      content_type: "type/extension",
      headers: %{}
    }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 200 OK
    Content-Type: type/extension
    Content-Length: 7

    Content
    """

    assert response == expected
  end

  test "response to GET request for a JPEG image file" do
    conn = %{
      method: "GET",
      status: 200,
      resp_body: "Content",
      content_type: "type/extension",
      headers: %{}
    }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 200 OK
    Content-Type: type/extension
    Content-Length: 7

    Content
    """

    assert response == expected
  end

  test "response to PATCH request" do
    conn = %{ method: "PATCH", path: "/foo.txt", status: 201 }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 201 Created
    Content-Location: /foo.txt
    """

    assert response == expected
  end

  test "response to PUT request" do
    conn = %{ method: "PUT", path: "/foo.txt", status: 200 }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 200 OK
    """

    assert response == expected
  end

  test "response to DELETE request" do
    conn = %{ method: "DELETE", path: "/foo.txt", status: 200 }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 200 OK
    """

    assert response == expected
  end

  test "response to HEAD request" do
    conn = %{ method: "HEAD", path: "/foo.txt", status: 200 }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 200 OK
    """

    assert response == expected
  end

  test "response to OPTIONS request" do
    conn = %{ method: "OPTIONS", path: "/foo.txt", status: 200, allow: "FOO, BAR, BAZ" }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 200 OK
    Allow: FOO, BAR, BAZ
    """

    assert response == expected
  end

  test "response to method that is now allowed" do
    conn = %{ method: "gibberish", path: "/foo.txt", status: 405 }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 405 Method not allowed
    """

    assert response == expected
  end

  test "response to GET /logs" do
    conn = %{
      method: "GET",
      path: "/logs",
      status: 401,
      headers: %{ "WWW-Authenticate" => ~s(Basic realm="Access to HTTP server") }
    }

    response = HttpServer.Formatter.format_response(conn)

    expected = """
    HTTP/1.1 401 Unauthorized
    WWW-Authenticate: Basic realm="Access to HTTP server"
    """

    assert response == expected
  end
end
