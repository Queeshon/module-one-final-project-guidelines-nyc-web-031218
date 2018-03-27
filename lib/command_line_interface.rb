class CommandLineInterface

  def greet
    puts 'Welcome to the NBA Fantasy Mock Draft. Please enter your name.'.bold.yellow
    gets.chomp
  end

  def create_username(input)
    User.create(name: input)
  end

  def input_choice
    puts 'To begin your draft, search for desired players.'.bold.yellow
    sleep(2)
    puts "To search a player by name, enter 1.".bold.yellow
    sleep(1)
    puts 'To search players by position, enter 2.'.bold.yellow
    sleep(1)
    puts "To search players by team, enter 3.".bold.yellow
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

end



def run
  new_cli = CommandLineInterface.new
  username = new_cli.greet
  new_user = new_cli.create_username(username)
  input = new_cli.input_choice
    if input == "1"
      nba_player = new_cli.input_player_name
      player_name = new_cli.find_player_by_name(nba_player)
      input2 = new_cli.ask_user_add(player_name)
      if input2 == 'Y'
        new_user.add_player_to_roster(player_name)
      end
    elsif input == "2"
      nba_position = new_cli.input_player_position
      players_position = new_cli.find_player_by_position(nba_position)
      p players_position.map { |player| player.full_name }
      input3 = new_cli.input_player_name
      player_name = new_cli.find_player_name_by_position(players_position, input3)
      input4 = new_cli.ask_user_add(player_name)
        if input4 == "Y"
          new_user.add_player_to_roster(player_name)
        end
    elsif input == "3"
      nba_team = new_cli.input_player_team
      roster = new_cli.find_player_by_team(nba_team)
      p roster.map { |player| player.full_name }
      input5 = new_cli.input_player_name
      player_name = new_cli.find_player_name_by_team(roster, input5)
      input6 = new_cli.ask_user_add(player_name)
        if input6 == "Y"
          new_user.add_player_to_roster(player_name)
        end
    end


end
