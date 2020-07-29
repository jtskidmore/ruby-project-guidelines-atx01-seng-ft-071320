

class Game < ActiveRecord::Base
  has_many :rounds
  has_many :users, through: :rounds

  def self.random_number
    rand(1..46941)
  end

  def self.get_data_from_api
    url = "https://www.balldontlie.io/api/v1/games/#{random_number}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def self.create_game
    api_response = get_data_from_api
    new_game = Game.new
    new_game.home_team = get_home_team_name(api_response)
    new_game.away_team = get_visitor_team_name(api_response)
    new_game.winner = get_winner(api_response)
    new_game.loser = get_loser(api_response)
    new_game.home_team_score = get_home_team_score(api_response)
    new_game.visitor_team_score = get_visitor_team_score(api_response)
    new_game.postseason = postseason(api_response)
    new_game.score = get_score(api_response)
    new_game.year = get_year(api_response)
    new_game
  end


  def self.get_home_team_name(api_response)
    api_response["home_team"]["full_name"]
  end

  def self.get_visitor_team_name(api_response)
    api_response["visitor_team"]["full_name"]
  end

  def self.get_home_team_score(api_response)
    api_response["home_team_score"]
  end

  def self.get_visitor_team_score(api_response)
    api_response["visitor_team_score"]
  end

  ##########

  def self.postseason(api_response)
    if api_response["postseason"] == true
      "playoff game"
    else
      "regular season game"
    end
  end

  def self.get_score(api_response)
    "#{get_home_team_score(api_response)} - #{get_visitor_team_score(api_response)}"
  end

  def self.get_year(api_response)
    api_response["season"]
  end

  def self.get_winner(api_response)
    if get_home_team_score(api_response) > get_visitor_team_score(api_response)
      get_home_team_name(api_response)
    else
      get_visitor_team_name(api_response)
    end
  end

  def self.get_loser(api_response)
    if get_home_team_score(api_response) < get_visitor_team_score(api_response)
      get_home_team_name(api_response)
    else
      get_visitor_team_name(api_response)
    end
  end

end




#max random number to be auto-generated == 46941
