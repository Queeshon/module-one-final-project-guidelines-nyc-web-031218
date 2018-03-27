class Player < ActiveRecord::Base
  has_many :drafts
  has_many :users, through: :drafts

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
