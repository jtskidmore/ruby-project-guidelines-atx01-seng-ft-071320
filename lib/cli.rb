

class CLI < ApiData

  def self.run

    self.greet

    puts "This is where the instructions will be."
    puts "--------------------"

    while true

      puts "Please enter your name to start a new game or type 'exit' to exit application: "
      name = gets.chomp
      break if name == "exit"
      user = self.find_name(name)
      # puts "#{user}"
      puts "--------------------"

      new_game = CLI.new()
      # new_round = Round.create(user_id: user.id, game_id: game.id)

      # puts "#{new_round}"

      puts "The year is #{new_game.get_year}" #1990 is the api_year_value
      puts "The home team was the #{new_game.get_home_team_name}, and the away team was the #{new_game.get_visitor_team_name}" #api_home_team and #api_away_team
      puts "The final score was #{new_game.get_score}" #api_home_team_points and api_away_team_points
      puts "Who do you think won?"
      puts "--------------------"

      while true
        puts "Type your answer or type 'help' for instructions."
        puts "--------------------"
        winner = new_game.get_winner #winner is Warriors if api_home_team_points > api_away_team_points
        loser = new_game.get_loser
        input = gets.chomp

        break if input == "quit"

        if input == winner
          puts "You guessed correctly!"
          puts "--------------------"
          puts "--------------------"
          break
        elsif input == loser
          puts "Wrong!!! Do your homework!"
          puts "--------------------"
          puts "--------------------"
          break
        elsif input == "help"
          puts "This is where the instructions will be."
          puts "--------------------"
        elsif
          puts "Invalid input. Please try again."
          puts "--------------------"
        end



        #Session.create(user_id: <user.id>, game_id: <game.id>)

      end
  end

  end

  def self.find_name(name)
    User.find_or_create_by(name: name)
    puts "Welcome, #{name}."
  end


  def self.greet
    puts "Hello human."
  end

end
