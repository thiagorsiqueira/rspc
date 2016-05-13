# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

app = PrivatePub.faye_app

# subscribe - online
app.bind(:subscribe) do |client_id, channel|
  puts "Client subscribe: #{client_id}:#{channel}"
end

app.bind(:handshake) do |client_id|
  puts "Client handshake: #{client_id}"
end

app.bind(:unsubscribe) do |client_id, channel|
	puts "Client unsubscribe: #{client_id}:#{channel}"
end

run app