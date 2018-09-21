defmodule HttpServer.Controllers.Patch do
  @public_dir "vendor/cob_spec/public"

  def patch(conn = %{ path: path, req_body: req_body }) do
    @public_dir <> path
    |> File.write(req_body)

    %{ conn | status: 204 }
  end
end
