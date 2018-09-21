defmodule HttpServer.Controllers.Delete.Test do
  use ExUnit.Case

  @public_dir "vendor/cob_spec/public"
  @path "/foo.txt"

  test "it deletes the target resource" do
    create_fixture()

    {:ok, _} = File.read(@public_dir <> @path)

    conn = %{ path: @path, resp_body: "", status: "" }

    HttpServer.Controllers.Delete.delete(conn)

    {:error, reason} = File.read(@public_dir <> @path)

    assert reason == :enoent
  end

  defp create_fixture do
    @public_dir <> @path |> File.write!("bar")
  end
end
