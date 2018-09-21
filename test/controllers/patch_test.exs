defmodule HttpServer.Controllers.Patch.Test do
  use ExUnit.Case

  @public_dir "vendor/cob_spec/public"
  @path "/foo.txt"

  test "PATCH request returns a 204" do
    create_fixture()

    conn = %{ path: @path, req_body: "baz", resp_body: "", status: "" }
    conn = HttpServer.Controllers.Patch.patch(conn)

    assert conn.status == 204

    tear_down()
  end
end
