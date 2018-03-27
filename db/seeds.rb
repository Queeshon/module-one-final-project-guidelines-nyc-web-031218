require 'rest-client'
require 'JSON'
require 'pry'

def get_player_name
  player_data = RestClient.get("http://data.nba.net/10s/prod/v1/2016/players.json")
  player_hash = JSON.parse(player_data)

  team_data = {
    "1610612737" => "Atlanta Hawks",
    "1610612738" => "Boston Celtics",
    "1610612751" => "Brooklyn Nets",
    "1610612766" => "Charlotte Hornets",
    "1610612741" => "Chicago Bulls",
    "1610612739" => "Cleveland Cavaliers",
    "1610612742" => "Dallas Mavericks",
    "1610612743" => "Denver Nuggets",
    "1610612765" => "Detroit Pistons",
    "1610612744" => "Golden State Warriors",
    "1610612745" => "Houston Rockets",
    "1610612754" => "Indiana Pacers",
    "1610612746" => "Los Angeles Clippers",
    "1610612747" => "Los Angeles Lakers",
    "1610612763" => "Memphis Grizzlies",
    "1610612748" => "Miami Heat",
    "1610612749" => "Milwaukee Bucks",
    "1610612750" => "Minnesota Timberwolves",
    "1610612740" => "New Orleans Pelicans",
    "1610612752" => "New York Knicks",
    "1610612760" => "Oklahoma City Thunder",
    "1610612753" => "Orlando Magic",
    "1610612755" => "Philadelphia 76ers",
    "1610612756" => "Phoenix Suns",
    "1610612757" => "Portland Trailblazers",
    "1610612758" => "Sacramento Kings",
    "1610612759" => "San Antonio Spurs",
    "1610612761" => "Toronto Raptors",
    "1610612762" => "Utah Jazz",
    "1610612764" => "Washington Wizards",
  }

  player_hash.each do |key, value|
    if key == "league"
      value.each do |standard, player_names_array|
        player_names_array.each do |player_info|
          Player.create(
            first_name: player_info['firstName'],
            last_name: player_info['lastName'],
            full_name: player_info['firstName'] + ' ' + player_info['lastName'],
            position: player_info['pos'].split("")[0],
            team_name: team_data[player_info['teamId'].split[0]]
          )
        end
      end
    end
  end
end

get_player_name
Player.all
