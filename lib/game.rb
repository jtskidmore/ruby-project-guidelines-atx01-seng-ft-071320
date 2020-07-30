

class Game < ActiveRecord::Base
  has_many :rounds
  has_many :users, through: :rounds

  def self.random_number
    rand(1..6222)
  end

  def self.get_game_data_from_api
    game_id = random_number
    url = "https://api-nba-v1.p.rapidapi.com/gameDetails/#{game_id}"
         #VERIFY THE GAME ID IS VALID BEFORE RUNNING SELF.CREATE_GAME
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
    until data["api"]["game"][0]["hTeam"]["leaders"][0]["name"] != nil do
      new_data_request = get_game_data_from_api
      data = new_data_request
    end
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
    new_game.point_value = get_point_value(data)
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


  def self.score_margin(data)
    if get_home_team_score(data).to_i > get_visitor_team_score(data).to_i
      get_home_team_score(data).to_i - get_visitor_team_score(data).to_i
    else
      get_visitor_team_score(data).to_i - get_home_team_score(data).to_i
    end
  end

  def self.get_point_value(data)
    if score_margin(data) < 5
      3
    elsif score_margin(data) >= 5 && score_margin(data) < 20
      2
    elsif score_margin(data) >= 20
      1
    end
  end

  def self.get_home_team_top_scorers(data)
    home_team_num1_scorer = data["api"]["game"][0]["hTeam"]["leaders"][0]["name"]
    home_team_num2_scorer = data["api"]["game"][0]["hTeam"]["leaders"][1]["name"]
    home_team_num3_scorer = data["api"]["game"][0]["hTeam"]["leaders"][2]["name"]
    players = [home_team_num1_scorer, home_team_num2_scorer, home_team_num3_scorer].uniq
    if players.length == 3
      "#{players[0]}, #{players[1]}, and #{players[2]}"
    elsif players.length == 2
      "#{players[0]} and #{players[1]}"
    elsif players.length == 1
      "#{players[0]}"
    elsif players.length == 0

    end
  end

  def self.get_visitor_team_top_scorers(data)
    visitor_team_num1_scorer = data["api"]["game"][0]["vTeam"]["leaders"][0]["name"]
    visitor_team_num2_scorer = data["api"]["game"][0]["vTeam"]["leaders"][1]["name"]
    visitor_team_num3_scorer = data["api"]["game"][0]["vTeam"]["leaders"][2]["name"]
    players = [visitor_team_num1_scorer, visitor_team_num2_scorer, visitor_team_num3_scorer].uniq
    if players.length == 3
      "#{players[0]}, #{players[1]}, and #{players[2]}"
    elsif players.length == 2
      "#{players[0]} and #{players[1]}"
    elsif players.length == 1
      "#{players[0]}"
    end
  end

  def self.get_year(data)
    data["api"]["game"][0]["seasonYear"]
  end

  def self.get_score(data)
    if get_home_team_score(data).to_i > get_visitor_team_score(data).to_i
      "#{get_home_team_score(data)} - #{get_visitor_team_score(data)}"
    else
      "#{get_visitor_team_score(data)} - #{get_home_team_score(data)}"
    end
  end

  def self.get_winner(data)
    if get_home_team_score(data).to_i > get_visitor_team_score(data).to_i
      get_home_team_name(data)
    else
      get_visitor_team_name(data)
    end
  end

  def self.get_loser(data)
    if get_home_team_score(data).to_i < get_visitor_team_score(data).to_i
      get_home_team_name(data)
    else
      get_visitor_team_name(data)
    end
  end

end

