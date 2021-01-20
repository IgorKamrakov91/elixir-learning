defmodule Hello do
  def welcome_message(name, username, domain) do
    ["Welcome ", name, ", your email is: ", email(username, domain)]
  end

  def email(username, domain) do
    [username, ?@, domain]
  end
end

IO.puts(Hello.welcome_message("Lol", "Kek", "Cheburek"))
