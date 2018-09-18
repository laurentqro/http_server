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

  test "PATCH request returns a 204" do
    ("vendor/cob_spec/public" <> "/hello-world.txt") |> File.write("hello world")

    request = """
    PATCH /hello-world.txt HTTP/1.1\r
    \r
    """

    expected_response = """
    HTTP/1.1 204 No content
    Content-Location: /hello-world.txt
    """

    ("vendor/cob_spec/public" <> "/hello-world.txt") |> File.rm

    assert HttpServer.Handler.handle(request) == expected_response
  end

  test "PATCH updates the target resource" do
    ("vendor/cob_spec/public" <> "/hello-world.txt") |> File.write("hello world")

    request = """
    PATCH /hello-world.txt HTTP/1.1
    Content-Length: 11\r
    \r
    goodbye world
    """

    HttpServer.Handler.handle(request)

    {:ok, updated_content} = ("vendor/cob_spec/public" <> "/hello-world.txt") |> File.read

    ("vendor/cob_spec/public" <> "/hello-world.txt") |> File.rm

    assert updated_content == "goodbye world\n"
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
end
