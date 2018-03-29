class User < ActiveRecord::Base
  has_many :drafts
  has_many :players, through: :drafts


  attr_accessor :roster

  def roster
    self.players.map { |player| player.full_name }
  end

  def add_player_to_roster(player)
    Draft.create(player_id: player.id, user_id: self.id)
  end

  def self.all_drafted_players
    User.all.map { |user| user.roster }.flatten
  end

  def delete_roster
    #binding.pry
    self.players = []
    #binding.pry
  end
end
