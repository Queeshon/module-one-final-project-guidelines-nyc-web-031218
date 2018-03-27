class CommandLineInterface

  def greet
    puts 'Welcome to the NBA Fantasy Mock Draft. Please enter your name.'
    gets.chomp
  end

  def create_username(input)
    User.create(name: input)
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
  
end


def run
  new_cli = CommandLineInterface.new
  username = new_cli.greet
  new_user = new_cli.create_username(username)
  input = new_cli.input_player_name
  player_name = new_cli.find_player_by_name(input)
  input2 = new_cli.ask_user_add(player_name)
  if input2 == 'Y'
    new_user.add_player_to_roster(player_name)
  end
end
