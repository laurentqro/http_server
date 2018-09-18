defmodule HttpServer.Parser do
  def parse(request) do
    [req_head, req_body] = request |> String.split("\n\n")

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
