defmodule HttpServer.Controllers.Delete do
  @public_dir "vendor/cob_spec/public"

  def delete(conn = %{ path: path }) do
    @public_dir <> path
    |> File.rm

    %{ conn | status: 200 }
  end
end
