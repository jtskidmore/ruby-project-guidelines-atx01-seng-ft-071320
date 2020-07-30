

class CLI

 
   def self.run
    intro

        prompt = PROMPT 
        y_or_n = prompt.yes?('Do you have a profile?')

        if y_or_n == true

        elsif y_or_n == false
          new_user
        end

  
    while true
      name = "name".green 
      exit = "exit".red 
      puts "\n" * 2 
      puts "Please enter your #{name} or type #{exit} to leave application: "
      name = gets.chomp
      break if name == "exit"
      @@user = User.find_or_create_by(name: name)
      puts"\n" * 2
      puts "Welcome, #{@@user.name}."
      puts "--------------------"


      while true
        puts "Press 1 to start new round"
        puts "Press 2 to check stats"
        select = gets.chomp.to_i
        break if select == 1
        puts "You have played #{@@user.round_count} round(s)."
        puts "You have #{@@user.win_count} wins and #{@@user.loss_count} losses"
        puts "--------------------"
        puts "--------------------"
      end
      play_a_round
    end #experimental
     play_a_round

     def self.play_a_round #experimental code
        new_game = Game.create_game
        puts "The year is #{new_game.year}" #1990 is the api_year_value
        puts "The home team was the #{new_game.home_team}, and the away team was the #{new_game.away_team}" #api_home_team and #api_away_team
        puts "The final score was #{new_game.score}" #api_home_team_points and api_away_team_points
        puts "Who do you think won?"
        puts "--------------------"
        help = "help".yellow

       while true
        puts "Type your answer or type #{help} for instructions."
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
          Round.create_round(@@user.id, new_game.id, true)
          prompt = PROMPT#experimental code
          prompt.select("",%w(Play_Again Main_Menu))#experimental code
          break
        elsif input == loser
          puts "Wrong!!! Do your homework!"
          puts "--------------------"
          puts "--------------------"
          new_game.save
          Round.create_round(@@user.id, new_game.id, false)
          prompt = PROMPT#experimental code
          prompt.select("",%w(Play_Again Main_Menu))#experimental code
          break
        elsif input == "help"
          instructions
          puts "--------------------"
        elsif
          puts "Invalid input. Please try again."
          puts "--------------------"
        end


      end #experimental code


      end
    # end #experimental code

  end


  def self.instructions

   puts "WELCOME TO NBA TRIVIA!!!".blue.underline
   puts "The rules are simple:".white 
   puts "\n" 
   puts "We give you some info about a specific NBA game and you tell us who you think won the game?".green
   puts "Easy enough right?".green
   puts "Guess correctly and prove your knowledge wizardry! Lets Begin!!!".green
  end

   def self.new_user
     instructions
     puts "/".red * 50
     prompt = PROMPT
     login = prompt.select("CreateUsername or Exit", %w(CreateUsername Exit))
     if login == 'Exit'
       
     end
   end

  #  def self.main
  #   puts "\n" * 30
  #   if @@user == nil
  #       puts "You have to be logged in to play NBA TRIVIA!!! :("
  #       IceBreaker.login
  #   else
  #   IceBreaker.banner_icebreaker
  #   puts "Hello #{@@current_user.username.light_yellow.bold}!"
  #   puts "\n" 
  #   menu_selection = PROMPT.select("Select from the following options?", %w(MyIceBreakers RandomIcebreaker DateIcebreaker YearIcebreaker EditMyInfo LogOut))






   def self.intro
    # puts              "WELCOME TO".colorize(:light_cyan).bold
    puts"

                                                
    _ _ _     _                      _             
    | | | |___| |___ ___ _____ ___   | |_ ___       
    | | | | -_| |  _| . |     | -_|  |  _| . |_ _ _ 
    |_____|___|_|___|___|_|_|_|___|  |_| |___|_|_|_|
                                                    
       ".colorize(:red).on_white     
    
    puts "***********************".cyan * 6
    puts "
    ███╗   ██╗██████╗  █████╗     ████████╗██████╗ ██╗██╗   ██╗██╗ █████╗     ██╗██╗██╗
    ████╗  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔══██╗██║██║   ██║██║██╔══██╗    ██║██║██║
    ██╔██╗ ██║██████╔╝███████║       ██║   ██████╔╝██║██║   ██║██║███████║    ██║██║██║
    ██║╚██╗██║██╔══██╗██╔══██║       ██║   ██╔══██╗██║╚██╗ ██╔╝██║██╔══██║    ╚═╝╚═╝╚═╝
    ██║ ╚████║██████╔╝██║  ██║       ██║   ██║  ██║██║ ╚████╔╝ ██║██║  ██║    ██╗██╗██╗
    ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝  ╚═╝    ╚═╝╚═╝╚═╝
                                                                                                   ".colorize(:color => :green, :background => :light_grey)
                                                                                             
   end


end
