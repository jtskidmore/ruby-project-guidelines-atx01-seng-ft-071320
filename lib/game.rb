

class Game < ActiveRecord::Base
  has_many :rounds
  has_many :users, through: :rounds

  def self.random_number
    rand(1..7956)
  end

  def self.get_game_data_from_api
    game_id = random_number
    url = "https://api-nba-v1.p.rapidapi.com/gameDetails/#{game_id}"

    details_url = URI.parse("https://api-nba-v1.p.rapidapi.com/gameDetails/#{game_id}")

    details_http = Net::HTTP.new(details_url.host, details_url.port)
    details_http.use_ssl = true
    details_http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    details_request = Net::HTTP::Get.new(details_url)
    details_request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'
    details_request["x-rapidapi-key"] = '7188ca30eemsh24dc91f4f4d2aeap15bbf4jsndeff3fcc5a96'

    details_response = details_http.request(details_request)

    JSON.parse(details_response.body)
  end

  def self.create_game
    data = get_game_data_from_api
    new_game = Game.new
    new_game.home_team = get_home_team_name(data)
    new_game.visitor_team = get_visitor_team_name(data)
    new_game.winner = get_winner(data)
    new_game.loser = get_loser(data)
    new_game.home_team_score = get_home_team_score(data)
    new_game.visitor_team_score = get_visitor_team_score(data)
    new_game.score = get_score(data)
    new_game.year = get_year(data)
    new_game.home_team_top_scorers = get_home_team_top_scorers(data)
    new_game.visitor_team_top_scorers = get_visitor_team_top_scorers(data)
    new_game
  end

  def self.get_home_team_name(data)
    data["api"]["game"][0]["hTeam"]["fullName"]
  end

  def self.get_visitor_team_name(data)
    data["api"]["game"][0]["vTeam"]["fullName"]
  end

  def self.get_home_team_score(data)
    data["api"]["game"][0]["hTeam"]["score"]["points"]
  end

  def self.get_visitor_team_score(data)
    data["api"]["game"][0]["vTeam"]["score"]["points"]
  end

  def self.get_home_team_top_scorers(data)
    home_team_num1_scorer = data["api"]["game"][0]["hTeam"]["leaders"][0]["name"]
    home_team_num2_scorer = data["api"]["game"][0]["hTeam"]["leaders"][1]["name"]
    home_team_num3_scorer = data["api"]["game"][0]["hTeam"]["leaders"][2]["name"]
    "#{home_team_num1_scorer}, #{home_team_num2_scorer}, and #{home_team_num3_scorer}"
  end

  def self.get_visitor_team_top_scorers(data)
    visitor_team_num1_scorer = data["api"]["game"][0]["vTeam"]["leaders"][0]["name"]
    visitor_team_num2_scorer = data["api"]["game"][0]["vTeam"]["leaders"][1]["name"]
    visitor_team_num3_scorer = data["api"]["game"][0]["vTeam"]["leaders"][2]["name"]
    "#{visitor_team_num1_scorer}, #{visitor_team_num2_scorer}, and #{visitor_team_num3_scorer}"
  end

  def self.get_year(data)
    data["api"]["game"][0]["seasonYear"]
  end

  def self.get_score(data)
    if get_home_team_score(data) > get_visitor_team_score(data)
      "#{get_home_team_score(data)} - #{get_visitor_team_score(data)}"
    else
      "#{get_visitor_team_score(data)} - #{get_home_team_score(data)}"
    end
  end

  def self.get_winner(data)
    if get_home_team_score(data) > get_visitor_team_score(data)
      get_home_team_name(data)
    else
      get_visitor_team_name(data)
    end
  end

  def self.get_loser(data)
    if get_home_team_score(data) < get_visitor_team_score(data)
      get_home_team_name(data)
    else
      get_visitor_team_name(data)
    end
  end


  # def self.random_number
  #   rand(1..46941)
  # end

  # def self.get_data_from_api
  #   url = "https://www.balldontlie.io/api/v1/games/#{random_number}"
  #   uri = URI.parse(url)
  #   response = Net::HTTP.get_response(uri)
  #   JSON.parse(response.body)
  # end

  # def self.create_game
  #   api_response = get_data_from_api
  #   new_game = Game.new
  #   new_game.home_team = get_home_team_name(api_response)
  #   new_game.away_team = get_visitor_team_name(api_response)
  #   new_game.winner = get_winner(api_response)
  #   new_game.loser = get_loser(api_response)
  #   new_game.home_team_score = get_home_team_score(api_response)
  #   new_game.visitor_team_score = get_visitor_team_score(api_response)
  #   new_game.postseason = postseason(api_response)
  #   new_game.score = get_score(api_response)
  #   new_game.year = get_year(api_response)
  #   new_game
  # end


#   def self.get_home_team_name(api_response)
#     api_response["home_team"]["full_name"]
#   end
#
#   def self.get_visitor_team_name(api_response)
#     api_response["visitor_team"]["full_name"]
#   end
#
#   def self.get_home_team_score(api_response)
#     api_response["home_team_score"]
#   end
#
#   def self.get_visitor_team_score(api_response)
#     api_response["visitor_team_score"]
#   end
#
#   def self.postseason(api_response)
#     if api_response["postseason"] == true
#       "playoff game"
#     else
#       "regular season game"
#     end
#   end
#
#   def self.get_score(api_response)
#     "#{get_home_team_score(api_response)} - #{get_visitor_team_score(api_response)}"
#   end
#
#   def self.get_year(api_response)
#     api_response["season"]
#   end
#
#   def self.get_winner(api_response)
#     if get_home_team_score(api_response) > get_visitor_team_score(api_response)
#       get_home_team_name(api_response)
#     else
#       get_visitor_team_name(api_response)
#     end
#   end
#
#   def self.get_loser(api_response)
#     if get_home_team_score(api_response) < get_visitor_team_score(api_response)
#       get_home_team_name(api_response)
#     else
#       get_visitor_team_name(api_response)
#     end
#   end
#
# end

end




#max random number to be auto-generated == 46941
