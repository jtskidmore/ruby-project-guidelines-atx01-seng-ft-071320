
class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def self.create_round(user_id, game_id, win)
    Round.create(user_id: user_id, game_id: game_id, win?: win)
  end

end
