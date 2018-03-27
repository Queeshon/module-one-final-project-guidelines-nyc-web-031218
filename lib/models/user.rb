class User < ActiveRecord::Base
  has_many :drafts
  has_many :players, through: :drafts

  def add_player(player_name)
    
  end
end
