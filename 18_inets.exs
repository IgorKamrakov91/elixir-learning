require Record

defmodule WebServer do
	def run do
		:inets.start()
		options = [server_name: 'foo', server_root: '/tmp', document_root: '/tmp', port: 3000, modules: [App]]
		{:ok, _pid} = :inets.start(:httpd, options)
		IO.puts("running on port 3000")
		receive do: (_ -> :ok)

	end
end

defmodule App do
end

WebServer.run()
