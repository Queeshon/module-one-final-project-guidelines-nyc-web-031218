class CreateDrafts < ActiveRecord::Migration[5.0]
  def change
    create_table :drafts do |t|
      t.integer :player_id
      t.integer :user_id
    end
  end
end
