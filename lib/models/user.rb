class User < ActiveRecord::Base
  has_many :drafts
  has_many :players, through: :drafts

  attr_accessor :roster

  def add_player_to_roster(player)
    Draft.create(player_id: player.id, user_id: self.id)
    roster << player.full_name
  end

end
