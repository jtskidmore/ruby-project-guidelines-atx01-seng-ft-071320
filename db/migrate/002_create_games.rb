

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :home_team
      t.string :away_team
      t.string :winner
      t.string :loser
      t.integer :home_team_score
      t.integer :visitor_team_score
      t.string :postseason
      t.string :score
      t.integer :year
    end
  end
end
