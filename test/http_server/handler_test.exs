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
end
