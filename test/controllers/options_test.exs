defmodule HttpServer.Controllers.Options.Test do
  use ExUnit.Case

  test "returns GET, HEAD, OPTIONS, PUT, DELETE for any request path" do
    conn = %{ path: "/file1", status: "", allow: "" }
    conn = HttpServer.Controllers.Options.options(conn)

    assert conn.status == 200
    assert conn.allow == "GET, HEAD, OPTIONS, PUT, DELETE"
  end

  test "returns GET, HEAD, OPTIONS for request to /logs" do
    conn = %{ path: "/logs", status: "", allow: "" }
    conn = HttpServer.Controllers.Options.options(conn)

    assert conn.status == 200
    assert conn.allow == "GET, HEAD, OPTIONS"
  end
end
