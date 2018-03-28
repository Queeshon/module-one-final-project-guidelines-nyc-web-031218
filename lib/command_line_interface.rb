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

  def input_selection_choice
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
    puts 'Enter player position: C(centers), G(guards), and F(forwards).'.bold.yellow
    gets.chomp
  end

  def input_player_team
    puts "Enter team name.".bold.yellow
    gets.chomp
  end

  def find_player_by_name(nba_player)
    Player.find_by(full_name: nba_player)
  end

  def find_player_by_position(nba_player)
    Player.where("position == '#{nba_player.upcase}'")
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
  #binding.pry

  loop do
    input = new_cli.input_selection_choice
    if new_user.roster.length > 4
      p "Roster full. View roster?"
      p new_user.roster.green
      break
    #this is the method to call a player by name.
    elsif input == "1"
      nba_player = new_cli.input_player_name
      player_name = new_cli.find_player_by_name(nba_player)
      yes_or_no = new_cli.ask_user_add(player_name)
      if (yes_or_no == 'Y' || yes_or_no == 'y') && !new_user.roster.include?(player_name.full_name)
        new_user.add_player_to_roster(player_name)
        new_user.reload
        #user_roster +=1
      elsif new_user.roster.include?(player_name.full_name)
        p "Player already in roster. Select again."
        redo
      elsif yes_or_no == 'N' || yes_or_no == 'n'
        redo
      else
        p "Invalid response. Please enter Y/N."
      end
    #this is the method to call a player by position
    elsif input == "2"
      nba_position = new_cli.input_player_position
      if nba_position == "G"|| nba_position == "F"|| nba_position == "C" || nba_position=="g"|| nba_position == "f"|| nba_position == "c"
        players_position = new_cli.find_player_by_position(nba_position)
        p players_position.map { |player| player.full_name }
        nba_player = new_cli.input_player_name
        player_name = new_cli.find_player_name_by_position(players_position, nba_player)
        yes_or_no = new_cli.ask_user_add(player_name)
          if (yes_or_no == 'Y' || yes_or_no == 'y') && !new_user.roster.include?(player_name.full_name)
            new_user.add_player_to_roster(player_name)
            new_user.reload
          #user_roster +=1
          elsif new_user.roster.include?(player_name.full_name)
            p "Player already in roster. Select again."
            redo
          elsif yes_or_no == 'N' || yes_or_no == 'n'
            redo
          else
            p "Invalid response. Please enter Y/N."
          end
      else
        p "Invalid response. Please enter C/G/F."
        redo
      end
    #this is the method to call a player by team
    elsif input == "3"
      nba_team = new_cli.input_player_team
      roster = new_cli.find_player_by_team(nba_team)
      p roster.map { |player| player.full_name }
      nba_player = new_cli.input_player_name
      player_name = new_cli.find_player_name_by_team(roster, nba_player)
      yes_or_no = new_cli.ask_user_add(player_name)
        if (yes_or_no == 'Y' || yes_or_no == 'y') && !new_user.roster.include?(player_name.full_name)
          new_user.add_player_to_roster(player_name)
          new_user.reload
          #user_roster +=1
        elsif new_user.roster.include?(player_name.full_name)
          p "Player already in roster. Select again."
          redo
        elsif yes_or_no == 'N' || yes_or_no == 'n'
          redo
        else
          p "Invalid response. Please enter Y/N."
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
