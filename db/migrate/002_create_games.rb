

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :home_team
      t.string :away_team
      t.string :winner
      t.string :box_score
      t.integer :season
      t.string :day
    end
  end
end
