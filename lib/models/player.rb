class Player < ActiveRecord::Base
  has_many :drafts
  has_many :users, through: :drafts
end
