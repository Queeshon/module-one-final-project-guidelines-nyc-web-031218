class User < ActiveRecord::Base
  has_many :drafts
  has_many :players, through: :drafts




  def roster
    self.players.map { |player| player.full_name }
  end

  def add_player_to_roster(player)
    Draft.create(player: player, user: self)
  end

  def self.all_drafted_players
    User.all.map { |user| user.roster }.flatten
  end

  def delete_last_added_player(player)
    #binding.pry
    delete = Draft.find_by(player_id: player.id)
    delete.destroy
  end

  def delete_selected_player(player)
    del = Draft.find_by(player_id: player.id)
    del.destroy
  end

  def delete_roster
    #binding.pry
    self.players = []
    #binding.pry
    self.players.reload
  end
end
