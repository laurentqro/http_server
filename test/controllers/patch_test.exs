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

  test "it creates the resource" do
    create_fixture()

    conn = %{ path: @path, req_body: "baz", resp_body: "", status: "" }
    HttpServer.Controllers.Patch.patch(conn)

    {:ok, content} = File.read(@public_dir <> @path)

    assert content == "baz"

    tear_down()
  end

  defp create_fixture do
    @public_dir <> @path |> File.write("bar")
  end

  defp tear_down do
    File.rm(@public_dir <> @path)
  end
end
