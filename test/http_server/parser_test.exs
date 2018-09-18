defmodule HttpServer.Parser.Test do
  use ExUnit.Case

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
