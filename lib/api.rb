

class ApiData

  attr_reader :id

  def initialize(id=rand(1..46941))
    @id = id
  end

  def get_data_from_api
    url = "https://www.balldontlie.io/api/v1/games/#{@id}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def get_home_team_name
    get_data_from_api["home_team"]["full_name"]
  end

  def get_visitor_team_name
    get_data_from_api["visitor_team"]["full_name"]
  end

  def get_home_team_score
    get_data_from_api["home_team_score"]
  end

  def get_visitor_team_score
    get_data_from_api["visitor_team_score"]
  end

  ##########

  def postseason
    if get_data_from_api["postseason"] == true
      "playoff game"
    else
      "regular season game"
    end
  end

  def get_score
    "#{get_home_team_score} - #{get_visitor_team_score}"
  end

  def get_year
    get_data_from_api["season"]
  end

  def get_winner
    if get_home_team_score > get_visitor_team_score
      get_home_team_name
    else
      get_visitor_team_name
    end
  end

  def get_loser
    if get_home_team_score < get_visitor_team_score
      get_home_team_name
    else
      get_visitor_team_name
    end
  end

end




#max random number to be auto-generated == 46941
