defmodule HttpServer.Handler.Test do
  use ExUnit.Case

  test "simple get request" do
    request = """
    GET /file1 HTTP/1.1

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 14

    file1 contents
    """

    assert HttpServer.Handler.handle(request) == expected_response
  end

  test "simple get request with new line at the end" do
    request = """
    GET /file2 HTTP/1.1

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 15

    file2 contents

    """

    assert HttpServer.Handler.handle(request) == expected_response
  end

  test "GET request to non-existing file returns a 404" do
    request = """
    GET /no_file_here.txt HTTP/1.1

    """

    expected_response = """
    HTTP/1.1 404 Not found
    Content-Type: text/html
    Content-Length: 14

    File not found
    """

    assert HttpServer.Handler.handle(request) == expected_response
  end

  test "HEAD request" do
    request = """
    HEAD / HTTP/1.1
    """

    expected_response = """
    HTTP/1.1 200 OK
    """

    assert HttpServer.Handler.handle(request) == expected_response
  end

  test "PUT request" do
    file_path = "/put-request.text"
    path = "vendor/cob_spec/public" <> file_path

    request = """
    PUT #{file_path} HTTP/1.1\r
    Content-Type: text/plain\r
    Content-Length: 24\r
    \r
    Some text for a new file"
    """

    expected_response = """
    HTTP/1.1 201 Created
    """

    assert HttpServer.Handler.handle(request) == expected_response

    File.rm!(path)
  end
end
