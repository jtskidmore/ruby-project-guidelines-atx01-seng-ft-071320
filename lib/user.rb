

class User < ActiveRecord::Base
  has_many :rounds
  has_many :games, through: :rounds

  def rounds
    Round.where(user_id: self.id)
  end

  def round_count
    rounds.count
  end

  def points
    points = []
    rounds.each do |round|
      if round.win? == true
        game = Game.find_by(id: round.game_id)
        points << game.point_value
      end
    end
    points.sum
  end

  def wins
    rounds.where(win?: true)
  end

  def win_count
    wins.count
  end

  def losses
    rounds.where(win?: false)
  end

  def loss_count
    losses.count
  end

end
