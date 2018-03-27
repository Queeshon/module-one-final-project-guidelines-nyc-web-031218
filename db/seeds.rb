require 'rest-client'
require 'JSON'
require 'pry'

def get_player_name
  player_data = RestClient.get("http://data.nba.net/10s/prod/v1/2016/players.json")
  player_hash = JSON.parse(player_data)

  player_hash.each do |key, value|
    if key == "league"
      value.each do |standard, player_names_array|
        player_names_array.each do |player_info|
          Player.create(first_name: player_info['firstName'], last_name: player_info['lastName'], full_name: player_info['firstName'] + ' ' + player_info['lastName'], position: player_info['pos'].split("")[0])
        end
      end
    end
  end
end

get_player_name
Player.all
