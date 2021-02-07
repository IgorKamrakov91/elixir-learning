require IEx
require Record

defmodule Wiki do
  @moduledoc """
  	A very simple wiki.
  	CamelCase words are auto-linked.
  	Pages are stored in the support/wiki directory.
  	To run:
  	$ iex 21-wiki.exs
  	... then point your browser to http://localhost:3000
  """

  Record.defrecord(:mod, Record.extract(:mod, from_lib: "inets/include/httpd.hrl"))

  @page_name "([A-Z][a-z0-9]+){2,}"
  @valid_page_name ~r/^([A-Z][a-z0-9]+){2,}$/
  @edit_path ~r/^([A-Z][a-z0-9]+){2,}\/edit$/

  @doc """
  	Start the inets server.
  """

  def run do
    :inets.start()

    options = [
      server_name: 'foo',
      server_root: '/tmp',
      document_root: '/tmp',
      port: 3000,
      modules: [__MODULE__]
    ]

    {:ok, _pid} = :inets.start(:httpd, options)
    IO.puts("running server on port 3000")
  end

  def unquote(:do)(data) do
    [_slash | name] = mod(data, :request_uri)

    cond do
      name == '' ->
        redirect('/HomePage')

      Regex.match?(@valid_page_name, :erlang.list_to_bitstring(name)) ->
        case mod(data, :method) do
          'GET' ->
            render_page(name)

          'POST' ->
            save_page(name, data)
            redirect(name)
        end

      Regex.match?(@edit_path, :erlang.list_to_bitstring(name)) ->
        name = Regex.replace(~r/\/edit$/, :erlang.list_to_bitstring(name), "")
        render_page(name, :edit)

      true ->
        response(404, 'bad path')
    end
  end
end
