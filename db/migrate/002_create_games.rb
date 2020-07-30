

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :home_team
      t.string :visitor_team
      t.string :winner
      t.string :loser
      t.integer :home_team_score
      t.integer :visitor_team_score
      t.string :score
      t.integer :year
      t.string :home_team_top_scorers
      t.string :visitor_team_top_scorers
      t.integer :point_value 
    end
  end
end
