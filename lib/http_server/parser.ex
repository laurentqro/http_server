defmodule HttpServer.Parser do

  def parse(request) do
    [method, _path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    parse(method, request)
  end

  defp parse(method, request) when method in ["GET", "HEAD", "DELETE", "OPTIONS"] do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{
      method: method,
      path: path,
      resp_body: "",
      status: "",
      allow: "",
      content_type: ""
    }
  end

  defp parse(method, request) when method in ["PATCH", "PUT"] do
    [req_head, req_body] = request |> String.split("\r\n\r\n")

    [method, path, _] =
      req_head
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{
      method: method,
      path: path,
      req_body: req_body,
      resp_body: "",
      status: ""
    }
  end
end
