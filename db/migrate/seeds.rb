require 'rest-client'
require 'JSON'

def get_player_name
  player_data = RestClient.get("http://data.nba.net/10s/prod/v1/2016/players.json")
  player_hash = JSON.parse(player_data)

  player_hash.each do |
end
