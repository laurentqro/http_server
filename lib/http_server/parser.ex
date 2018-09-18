defmodule HttpServer.Parser do

  def parse(request) do
    [method, _path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    parse(method, request)
  end

  def parse("GET", request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{
      method: method,
      path: path,
      req_body: "",
      resp_body: "",
      status: ""
    }
  end

  def parse("PATCH", request) do
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

  def parse("HEAD", request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %{
      method: method,
      path: path,
      req_body: "",
      resp_body: "",
      status: ""
    }
  end
end
