class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :position
      t.string :team_name
    end
  end
end
