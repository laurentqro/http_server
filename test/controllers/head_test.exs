defmodule HttpServer.Controllers.Head.Test do
  use ExUnit.Case

  test "HEAD request returns 200" do
    conn = %{ path: "/", resp_body: "", status: "" }
    conn = HttpServer.Controllers.Head.head(conn)

    assert conn.status == 200
  end
end
