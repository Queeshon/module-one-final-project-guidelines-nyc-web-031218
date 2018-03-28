class User < ActiveRecord::Base
  has_many :drafts
  has_many :players, through: :drafts

  def roster
    self.players.map { |player| player.full_name }
  end

  def add_player_to_roster(player)
    Draft.create(player_id: player.id, user_id: self.id)
  end

end
