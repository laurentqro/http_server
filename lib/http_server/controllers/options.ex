defmodule HttpServer.Controllers.Options do

  def options(conn = %{ path: "/logs" }) do
    %{ conn | status: 200, allow: "GET, HEAD, OPTIONS" }
  end

  def options(conn) do
    %{ conn | status: 200, allow: "GET, HEAD, OPTIONS, PUT, DELETE" }
  end
end
