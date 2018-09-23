defmodule HttpServer.Controllers.Put.Test do
  use ExUnit.Case

  @public_dir "vendor/cob_spec/public"
  @path "/put-request.txt"

  test "PUT request returns a 201 on creation" do
    conn = %{ path: @path, req_body: "Some file content", resp_body: "", status: "" }
    conn = HttpServer.Controllers.Put.put(conn)

    {:ok, content } = read_file_content()

    assert content == "Some file content"
    assert conn.status == 201

    tear_down()
  end

  test "PUT request returns a 200 on update" do
    create_fixture()

    conn = %{ path: @path, req_body: "Some content updates", resp_body: "", status: "" }
    conn = HttpServer.Controllers.Put.put(conn)

    {:ok, content } = read_file_content()

    assert content == "Some content updates"
    assert conn.status == 200

    tear_down()
  end

  defp create_fixture do
    @public_dir <> @path |> File.write!("bar")
  end

  defp tear_down do
    File.rm(@public_dir <> @path)
  end

  def read_file_content do
    File.read(@public_dir <> @path)
  end
end
