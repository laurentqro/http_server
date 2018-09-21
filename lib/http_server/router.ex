defmodule HttpServer.Router do

  def route(conn = %{ method: "GET" }) do
    HttpServer.Controllers.Get.get(conn)
  end

  def route(conn = %{ method: "PATCH" }) do
    HttpServer.Controllers.Patch.patch(conn)
  end

  def route(conn = %{ method: "PUT" }) do
    HttpServer.Controllers.Put.put(conn)
  end

  def route(conn = %{ method: "DELETE" }) do
    HttpServer.Controllers.Delete.delete(conn)
  end

  def route(conn = %{ method: "HEAD" }) do
    HttpServer.Controllers.Head.head(conn)
  end
end
