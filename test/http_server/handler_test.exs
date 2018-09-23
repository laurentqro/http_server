defmodule HttpServer.Handler.Test do
  use ExUnit.Case

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
