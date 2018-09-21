defmodule HttpServer.Controllers.Head do
  def head(conn) do
    %{ conn | status: 200 }
  end
end
