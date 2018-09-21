defmodule HttpServer.Parser.Test do
  use ExUnit.Case

  test "parses the HTTP method" do
    request = """
    GET /hello-world.txt HTTP/1.1
    """

    %{method: method, path: _path, req_body: req_body, resp_body: _resp_body, status: _status} = HttpServer.Parser.parse(request)

    assert method == "GET"
  end

  test "parses the request path" do
    request = """
    GET /hello-world.txt HTTP/1.1
    """

    %{method: _method, path: path, req_body: req_body, resp_body: _resp_body, status: _status} = HttpServer.Parser.parse(request)

    assert path == "/hello-world.txt"
  end

  test "parses the request body" do
    request = """
    PATCH /hello-world.txt HTTP/1.1
    Content-Length: 11\r
    \r
    goodbye world
    """

    %{method: _method, path: _path, req_body: req_body, resp_body: "", status: ""} = HttpServer.Parser.parse(request)

    assert req_body == "goodbye world\n"
  end
end
