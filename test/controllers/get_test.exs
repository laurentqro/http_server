defmodule HttpServer.Controllers.Get.Test do
  use ExUnit.Case

  @public_dir "vendor/cob_spec/public"

  test "it returns 200" do
    path = "/foo.txt"
    @public_dir <> path |> File.write("bar")

    conn = %{ path: path, resp_body: "", status: "" }
    conn = HttpServer.Controllers.Get.get(conn)

    assert conn.status == 200

    File.rm(@public_dir <> path)
  end

  test "it assigns file content to response body" do
    path = "/foo.txt"
    @public_dir <> path |> File.write("bar")
    conn = %{ path: path, resp_body: "", status: "" }

    conn = HttpServer.Controllers.Get.get(conn)

    assert conn.resp_body == "bar"

    File.rm(@public_dir <> path)
  end

  test "it returns 404" do
    conn = %{ path: "/foo.txt", resp_body: "", status: "" }
    conn = HttpServer.Controllers.Get.get(conn)

    assert conn.status == 404
  end
end
