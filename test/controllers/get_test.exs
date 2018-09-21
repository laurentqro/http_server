defmodule HttpServer.Controllers.Get.Test do
  use ExUnit.Case

  @public_dir "vendor/cob_spec/public"
  @path "/foo.txt"

  test "it returns 200" do
    create_fixture()

    conn = %{ path: @path, resp_body: "", status: "" }
    conn = HttpServer.Controllers.Get.get(conn)

    assert conn.status == 200

    tear_down()
  end

  test "it assigns file content to response body" do
    create_fixture()

    conn = %{ path: @path, resp_body: "", status: "" }

    conn = HttpServer.Controllers.Get.get(conn)

    assert conn.resp_body == "bar"

    tear_down()
  end

  test "it returns 404" do
    conn = %{ path: "/foo.txt", resp_body: "", status: "" }
    conn = HttpServer.Controllers.Get.get(conn)

    assert conn.status == 404
  end

  defp create_fixture do
    @public_dir <> @path |> File.write!("bar")
  end

  defp tear_down do
    File.rm(@public_dir <> @path)
  end
end
