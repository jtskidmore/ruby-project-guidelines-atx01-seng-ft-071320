

class CLI

  def self.run

    puts "Welcome, human."

    puts "This is where the instructions will be."
    puts "--------------------"

    while true

      puts "Please enter your name or type 'exit' to exit application: "
      name = gets.chomp
      break if name == "exit"
      user = User.find_or_create_by(name: name)

      puts "Welcome, #{user.name}."
      puts "--------------------"


      while true
        puts "Press 1 to start new round"
        puts "Press 2 to check stats"
        select = gets.chomp.to_i
        break if select == 1
        puts "You have played #{user.round_count} rounds."
        puts "You have #{user.win_count} wins and #{user.loss_count} losses"
        puts "--------------------"
        puts "--------------------"
      end

      new_game = Game.create_game

      puts "The year is #{new_game.year}" #1990 is the api_year_value
      puts "The home team was the #{new_game.home_team}, and the away team was the #{new_game.away_team}" #api_home_team and #api_away_team
      puts "The final score was #{new_game.score}" #api_home_team_points and api_away_team_points
      puts "Who do you think won?"
      puts "--------------------"

      while true
        puts "Type your answer or type 'help' for instructions."
        puts "--------------------"
        winner = new_game.winner #winner is Warriors if api_home_team_points > api_away_team_points
        loser = new_game.loser
        input = gets.chomp

        break if input == "quit"

        if input == winner
          puts "You guessed correctly!"
          puts "--------------------"
          puts "--------------------"
          new_game.save
          Round.create_round(user.id, new_game.id, true)
          break
        elsif input == loser
          puts "Wrong!!! Do your homework!"
          puts "--------------------"
          puts "--------------------"
          new_game.save
          Round.create_round(user.id, new_game.id, false)

          break
        elsif input == "help"
          puts "This is where the instructions will be."
          puts "--------------------"
        elsif
          puts "Invalid input. Please try again."
          puts "--------------------"
        end


      end


      end


  end


end
