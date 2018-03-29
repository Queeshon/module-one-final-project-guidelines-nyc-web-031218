require 'pry'

class CommandLineInterface

  def greet
    puts 'Welcome to the NBA Fantasy Mock Draft. Please enter your name.'.bold.green
    gets.chomp
  end

  def create_username(input)
    User.create(name: input)
    #puts 'To begin your draft, search for desired players.'.bold.yellow
  end

  def input_selection_choice
    puts "To search a player by name, enter 1.".bold.green
    sleep(1)
    puts 'To search players by position, enter 2.'.bold.green
    sleep(1)
    puts "To search players by team, enter 3.".bold.green
    sleep(1)
    puts "To delete the last player added, enter 4.".bold.yellow
    sleep(1)
    puts "To delete a specific player, enter 5.".bold.yellow
    sleep(1)
    puts "To delete your current roster, enter 6.".bold.yellow
    sleep(1)
    puts "To exit the NBA Fantasy Mock Draft application, enter 7.".bold.red
    gets.chomp
  end

  def input_player_name
    puts 'Enter player name.'.bold.green
    gets.chomp
  end

  def input_player_position
    puts 'Enter player position: C(centers), G(guards), and F(forwards).'.bold.green
    gets.chomp
  end

  def input_player_team
    puts "Enter team name.".bold.green
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
    puts "Add #{player_name.full_name} to your roster? Enter (Y/N).".bold.green
    gets.chomp
  end

  def are_you_really_sure
    puts 'Are you sure you want to delete the last player added? Enter (Y/N).'.bold.yellow
    gets.chomp
  end

  def you_serious
    puts "Are you sure you want to delete the selected player? Enter (Y/N).".bold.yellow
    gets.chomp
  end

  def are_you_sure
    puts "Are you sure you want to delete your current roster? Enter (Y/N).".bold.yellow
    gets.chomp
  end

end

def check_roster(player_name)
  all = User.all_drafted_players
  all.include?(player_name)
end



def run
  new_cli = CommandLineInterface.new
  username = new_cli.greet
  new_user = new_cli.create_username(username)
  #binding.pry

  loop do
    full_name_all = Player.all.map { |player| player.full_name }
    team_all = Player.all.map {|player| player.team_name}
    input = new_cli.input_selection_choice
    if new_user.roster.length > 4
      puts "Roster full. Thanks for using our app.".bold.cyan
      puts new_user.roster
      break
    #this is the method to call a player by name.
    elsif input == "1"
      nba_player = new_cli.input_player_name
      if full_name_all.include?(nba_player) && !check_roster(nba_player)
        player_name = new_cli.find_player_by_name(nba_player)
        yes_or_no = new_cli.ask_user_add(player_name)
        if (yes_or_no == 'Y' || yes_or_no == 'y') && !new_user.roster.include?(player_name.full_name)
          new_user.add_player_to_roster(player_name)
          new_user.reload
          puts "Current roster: #{new_user.roster}"
          #user_roster +=1
        elsif new_user.roster.include?(player_name.full_name)
          puts "Player already in roster. Select again.".bold.red
          redo
        elsif yes_or_no == 'N' || yes_or_no == 'n'
          puts "Current roster: #{new_user.roster}"
          redo
        else
          puts "Invalid response. Please enter Y/N.".bold.red
        end
      else
        puts "Invalid name or player already drafted.".bold.red
        redo
      end
    #this is the method to call a player by position
    elsif input == "2"
      nba_position = new_cli.input_player_position
      if nba_position == "G"|| nba_position == "F"|| nba_position == "C" || nba_position=="g"|| nba_position == "f"|| nba_position == "c"
        players_position = new_cli.find_player_by_position(nba_position)
        p players_position.map { |player| player.full_name }
        nba_player = new_cli.input_player_name
        if full_name_all.include?(nba_player) && !check_roster(nba_player)
          player_name = new_cli.find_player_name_by_position(players_position, nba_player)
          yes_or_no = new_cli.ask_user_add(player_name)
              if (yes_or_no == 'Y' || yes_or_no == 'y') && !new_user.roster.include?(player_name.full_name)
                new_user.add_player_to_roster(player_name)
                new_user.reload
                puts "Current roster: #{new_user.roster}"
                #user_roster +=1
              elsif new_user.roster.include?(player_name.full_name)
                puts "Player already in roster. Select again.".bold.red
                redo
              elsif yes_or_no == 'N' || yes_or_no == 'n'
                puts "Current roster: #{new_user.roster}"
                redo
              else
                puts "Invalid response. Please enter Y/N.".bold.red
              end
          else
            puts "Invalid name or player already drafted.".bold.red
          end
      else
        puts "Invalid response. Please enter C/G/F.".bold.red
        redo
      end
    #this is the method to call a player by team
    elsif input == "3"
      nba_team = new_cli.input_player_team
      if team_all.include?(nba_team)
      roster = new_cli.find_player_by_team(nba_team)
      puts roster.map { |player| player.full_name + ", " + player.position }
      nba_player = new_cli.input_player_name
        if full_name_all.include?(nba_player) && !check_roster(nba_player)
          player_name = new_cli.find_player_name_by_team(roster, nba_player)
          yes_or_no = new_cli.ask_user_add(player_name)
            if (yes_or_no == 'Y' || yes_or_no == 'y') && !new_user.roster.include?(player_name.full_name)
              new_user.add_player_to_roster(player_name)
              new_user.reload
              puts "Current roster: #{new_user.roster}"
              #user_roster +=1
            elsif new_user.roster.include?(player_name.full_name)
              puts "Player already in roster. Select again.".bold.red
              redo
            elsif yes_or_no == 'N' || yes_or_no == 'n'
              puts "Current roster: #{new_user.roster}"
              redo
            else
              puts "Invalid response. Please enter Y/N.".bold.red
            end
          else
            puts "Invalid name or player already drafted.".bold.red
          end
        else
          puts "Invalid name. Please spell-check. Enter full team name.".bold.red
        end
    elsif input == "4"
      yes_or_no = new_cli.are_you_really_sure
      if yes_or_no == "Y" || yes_or_no == "y"
        new_user.roster
        player_name = new_user.delete_last_added_player
        puts "#{player_name.full_name} deleted from roster.".bold.yellow
        #binding.pry
        new_user.reload
        puts "Current roster: #{new_user.roster}"
        #binding.pry
        redo
      elsif yes_or_no == "N" || yes_or_no == "n"
        redo
      else
        puts "Invalid response. Please enter Y/N.".bold.red
      end
    elsif input == "5"
      player_name = new_cli.input_player_name
      yes_or_no = new_cli.you_serious
      if (yes_or_no == "Y" || yes_or_no == "y") && new_user.current_roster.include?(player_name)
        new_user.roster
        new_user.delete_selected_player(player_name)
        puts "#{player_name} removed from roster.".bold.yellow
        #binding.pry
        new_user.reload
        puts "Current roster: #{new_user.roster}"
        #binding.pry
        redo
      elsif yes_or_no == "N" || yes_or_no == "n"
        redo
      else
        puts "Invalid response. Please enter Y/N.".bold.red
      end
    #this is the method to delete your roster
    elsif input == "6"
      yes_or_no = new_cli.are_you_sure
      if yes_or_no == "Y" || yes_or_no == "y"
        new_user.roster
        new_user.delete_roster
        puts "Roster empty.".bold.yellow
        #binding.pry
        new_user.reload
        #binding.pry
        redo
      elsif yes_or_no == "N" || yes_or_no == "n"
        redo
      else
        puts "Invalid response. Please enter Y/N.".bold.red
      end
    #this is the method to break the loop
    elsif input == "7"
      puts "K".bold.magenta
      break
    elsif input == "Heisenberg"
      puts "You're goddamn right.".bold.cyan
    else
      puts "Invalid response. Please enter 1 - 5.".bold.red
    end
  end
end
