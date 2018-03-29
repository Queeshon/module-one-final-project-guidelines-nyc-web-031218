class User < ActiveRecord::Base
  has_many :drafts
  has_many :players, through: :drafts


  attr_accessor :roster

  def current_roster
    self.players.map { |player| player.full_name }
  end

  def roster
    self.players.map { |player| player.full_name + ", " + player.position }
  end

  def add_player_to_roster(player)
    Draft.create(player_id: player.id, user_id: self.id)
  end

  def self.all_drafted_players
    User.all.map { |user| user.roster }.flatten
  end

  def delete_last_added_player
    self.players.last.destroy
  end

  def delete_selected_player(player_name)
    del = self.players.find_by(full_name: player_name)
    del.destroy
  end

  def delete_roster
    #binding.pry
    self.players = []
    #binding.pry
  end
end
