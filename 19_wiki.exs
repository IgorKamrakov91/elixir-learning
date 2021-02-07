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
  end
end
