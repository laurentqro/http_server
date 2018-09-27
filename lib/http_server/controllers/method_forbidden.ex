defmodule HttpServer.Controllers.MethodForbidden do
  def forbid(conn) do
    %{ conn | status: 405 }
  end
end
