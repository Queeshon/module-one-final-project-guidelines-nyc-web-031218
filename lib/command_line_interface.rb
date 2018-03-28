require 'pry'

class CommandLineInterface

  def greet
    puts 'Welcome to the NBA Fantasy Mock Draft. Please enter your name.'.bold.yellow
    gets.chomp
  end

  def create_username(input)
    User.create(name: input)
    #puts 'To begin your draft, search for desired players.'.bold.yellow
  end

  def input_choice
    puts "To search a player by name, enter 1.".bold.yellow
    sleep(1)
    puts 'To search players by position, enter 2.'.bold.yellow
    sleep(1)
    puts "To search players by team, enter 3.".bold.yellow
    sleep(1)
    puts "To exit the NBA Fantasy Mock Draft application, enter 4.".bold.red
    gets.chomp
  end

  def input_player_name
    puts 'Enter player name.'.bold.yellow
    gets.chomp
  end

  def input_player_position
    puts 'Enter player position.'.bold.yellow
    gets.chomp
  end

  def input_player_team
    puts "Enter team name.".bold.yellow
    gets.chomp
  end

  def find_player_by_name(player_name)
    Player.find_by(full_name: player_name)
  end

  def find_player_by_position(player_posiiton)
    Player.where("position == '#{player_posiiton}'")
  end

  def find_player_name_by_position(player_position_array, player_name)
    player_position_array.find_by(full_name: player_name)
  end

  def find_player_by_team(player_team)
    Player.where("team_name == '#{player_team}'")
  end

  def find_player_name_by_team(roster, player_name)
    roster.find_by(full_name: player_name)
  end

  def ask_user_add(player_name)
    p "Add #{player_name.full_name} to your roster? Enter (Y/N)."
    gets.chomp
  end

  def neglected_player
    p ""
  end

end





def run
  new_cli = CommandLineInterface.new
  username = new_cli.greet
  new_user = new_cli.create_username(username)
  user_roster = 0
  #binding.pry

  loop do
    input = new_cli.input_choice
    if user_roster > 4
      p "Roster full. View roster?"
      p new_user.roster
      break
    #this is the method to call a player by name.
    elsif input == "1"
      nba_player = new_cli.input_player_name
      player_name = new_cli.find_player_by_name(nba_player)
      input2 = new_cli.ask_user_add(player_name)
      if input2 == 'Y' || input2 == 'y'
        new_user.add_player_to_roster(player_name)
        user_roster +=1
      elsif input2 == 'N' || input2 == 'n'
        redo
      else
        p "Invalid response. Please enter Y/N.".bold.red
      end
    #this is the method to call a player by position
    elsif input == "2"
      nba_position = new_cli.input_player_position
      players_position = new_cli.find_player_by_position(nba_position)
      p players_position.map { |player| player.full_name }
      input3 = new_cli.input_player_name
      player_name = new_cli.find_player_name_by_position(players_position, input3)
      input4 = new_cli.ask_user_add(player_name)
        if input4 == 'Y' || input4 == 'y'
          new_user.add_player_to_roster(player_name)
          user_roster +=1
        elsif input4 == 'N' || input4 == 'n'
          redo
        else
          p "Invalid response. Please enter Y/N.".bold.red
      end
    #this is the method to call a player by team
    elsif input == "3"
      nba_team = new_cli.input_player_team
      roster = new_cli.find_player_by_team(nba_team)
      p roster.map { |player| player.full_name }
      input5 = new_cli.input_player_name
      player_name = new_cli.find_player_name_by_team(roster, input5)
      input6 = new_cli.ask_user_add(player_name)
        if input6 == 'Y' || input6 == 'y'
          new_user.add_player_to_roster(player_name)
          user_roster +=1
        elsif input6 == 'N' || input6 == 'n'
          redo
        else
          p "Invalid response. Please enter Y/N.".bold.red
        end
    #this is the method to break the loop
    elsif input == "4"
      p "K"
      break
    else
      puts "Invalid response. Please enter 1, 2, or 3.".bold.red
    end
  end
end
