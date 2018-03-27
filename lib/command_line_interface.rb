class CommandLineInterface

  def greet
    puts 'Welcome to the NBA Fantasy Mock Draft.'
  end

  def input_player_name
    puts 'To begin your draft, search for desired players.'
    puts 'To search a player by name, enter name.'
    gets.chomp
  end

  def find_player_by_name(player_name)
    Player.find_by(full_name: player_name)
  end

  def ask_user_add(player_name)
    p "Add #{player_name.full_name} to your roster? Enter (Y/N)."
    gets.chomp
  end

  def add_player_to_roster(input)

  end

end


def run
  new_cli = CommandLineInterface.new
  new_roster = []
  new_cli.greet
  input = new_cli.input_player_name
  player_name = new_cli.find_player_by_name(input)
  input2 = new_cli.ask_user_add(player_name)
  if input2 == 'Y'
    add_player_to_roster(input2)
  end
end
