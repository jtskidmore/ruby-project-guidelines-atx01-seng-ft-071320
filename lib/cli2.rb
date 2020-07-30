
class Controller
  ######################################### Method that runs all other methods ###############################
 def self.run
  intro 
  profile 
 end



 ############################################ ALL OF THE METHODS ###########################################


    def self.main_menu 
     puts "\n" * 30 
     if @@current_user == nil
            puts "You have to be logged in to play NBA TRIVIA!!! :("
            login
     else
        intro
        puts "Hello #{@@current_user.name.light_blue.bold}!"
        puts "\n" 
        menu_selection = PROMPT.select("Select an option:", %w(StartNewRound Stats Help LogOut QuitGame))
        case menu_selection
          when 'StartNewRound' 
            new_round
          when 'Stats'      
            stats
          when 'Help'       
            instructions
          when 'LogOut'    
            @@current_user = nil
            main_menu
          when 'QuitGame'
            quit 
         end
      end
    end

    def self.signup
      sign_up = PROMPT.select("SignUP or Exit", %w(SignUP Back))
        
        if sign_up == "SignUP"
          puts "Please enter a username:"
          name = gets.chomp
            @@current_user = User.create(name: name)
            main_menu
        else sign_up == "Back"
            new_user
        end

    end

    def self.login
       login_or_exit = PROMPT.select("", %w(Login Back))
       if login_or_exit == "Login"
          puts "\n" * 5
          find_user = PROMPT.ask("What is your username?".light_cyan, required: true)
          @@current_user = User.find_by(name: find_user)
            if @@current_user == nil
              puts "User not found".light_red
              puts "Please try again!"
              self.login
            else
            main_menu
            end
        elsif 'Back'
              intro
              profile
        end
    end

    def self.profile
        prompt = PROMPT 
        y_or_n = prompt.yes?('Do you have a profile?')

        if y_or_n == true
          login 
        elsif y_or_n == false
          new_user
        end
    end

    def self.instructions

        puts "WELCOME TO NBA TRIVIA!!!".blue.underline
        puts "The rules are simple:".white 
        puts "\n" 
        puts "We give you some info about a specific NBA game and you tell us who you think won the game?".green
        puts "Easy enough right?".green
        puts "Guess correctly and prove your knowledge wizardry! Lets Begin!!!".green
    end

    def self.help 
      instructions
      puts"*".light_cyan * 40
      puts"\n"
      prompt = PROMPT
      options = prompt.select("Start_Game Main_Menu", %w(Start_Game Main_Menu ))
      case options
      when 'Start_Game'
        new_round
      when 'Main_Menu'
        main_menu
      end
    end
 
    def self.new_user
      instructions
      puts "/".red * 50
      prompt = PROMPT
      login = prompt.select("CreateUsername or Exit", %w(CreateUsername Back))
      if login == 'CreateUsername'
        signup
      elsif login == 'Back'
        intro
        profile
      end
    end

    def self.intro
          
          puts"                                                                                                                                                                                                     
                                                                                              
                                                                                                                                                              
          _ _ _     _                      _                                          
          | | | |___| |___ ___ _____ ___   | |_ ___                                         
          | | | | -_| |  _| . |     | -_|  |  _| . |_ _ _                    
          |_____|___|_|___|___|_|_|_|___|  |_| |___|_|_|_|
                                                          
                                                                                              ".colorize(:red).on_white     
          
          puts "***********************".cyan * 7
          puts "
          ███╗   ██╗██████╗  █████╗     ████████╗██████╗ ██╗██╗   ██╗██╗ █████╗     ██╗██╗██╗
          ████╗  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔══██╗██║██║   ██║██║██╔══██╗    ██║██║██║
          ██╔██╗ ██║██████╔╝███████║       ██║   ██████╔╝██║██║   ██║██║███████║    ██║██║██║
          ██║╚██╗██║██╔══██╗██╔══██║       ██║   ██╔══██╗██║╚██╗ ██╔╝██║██╔══██║    ╚═╝╚═╝╚═╝
          ██║ ╚████║██████╔╝██║  ██║       ██║   ██║  ██║██║ ╚████╔╝ ██║██║  ██║    ██╗██╗██╗
          ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝  ╚═╝    ╚═╝╚═╝╚═╝
                                                                                                      ".colorize(:color => :green, :background => :light_grey)
                                                                                                  
    end

    def self.quit
      puts "\n" * 30
    
      puts "                                                
      ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗
      ██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
      ██║  ███╗██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ █████╗  
      ██║   ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██╔══╝  
      ╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ███████╗
      ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝
                                      ".green.bold
      print "\s" * 25,"Play Again Soon!".blue
      puts "\n" * 10             
    end 

    def self.stats 
            puts "You have played #{@@current_user.round_count} round(s).".white 
            puts "Wins: ""#{@@current_user.win_count}".green
            puts "Losses: ""#{@@current_user.loss_count}".red
            puts "Points: ""#{@@current_user.points}".blue
            puts "--------------------" 
            puts "\n"
            prompt = PROMPT
            option = prompt.select("", %w(StartGame MainMenu ExitGame))
            case option
            when 'StartGame'
              new_round
            when 'MainMenu'
              main_menu
            when 'ExitGame'
              quit
            end

            puts "--------------------"
    end

    def self.new_round
      new_game = Game.create_game
      puts "\n" * 10
      puts "--------------------".light_cyan
      puts "\n" * 2
      print "The year is ".white 
      print"#{new_game.year}".blue #1990 is the api_year_value
      puts "\n" * 2
      print "The home team was the".white 
      print " #{new_game.home_team}".green
      print ", and the away team was the".white
      print " #{new_game.away_team}".red #api_home_team and #api_away_team
      puts "\n" * 2
      print "The final score was".white
      print " #{new_game.score}".light_blue #api_home_team_points and api_away_team_points
      puts "\n" * 2
      print "The top scorers for the".white 
      print " #{new_game.home_team} were:".white  
      print " #{new_game.home_team_top_scorers}.". yellow
      puts "\n" * 2
      print "The top scorers for the".white  
      print " #{new_game.visitor_team} were:" 
      print " #{new_game.visitor_team_top_scorers}.". yellow 
      puts"\n" * 2 
      puts "Who do you think won?".white 
      puts "\n" * 2 
      puts "--------------------".light_cyan
      

    
      puts "Type your answer below."
      puts "--------------------".light_cyan
      puts "\n" * 2
      winner = new_game.winner #winner is Warriors if api_home_team_points > api_away_team_points
      loser = new_game.loser
      input = gets.chomp


      if input == winner
        puts "You guessed correctly!".green.underline
        puts "--------------------"
        puts "--------------------"
        new_game.save
        Round.create_round(@@current_user.id, new_game.id, true)
        prompt = PROMPT
        choice = prompt.select("",%w(PlayAgain Main_Menu))
        case choice
        when 'PlayAgain'
          new_round
        when 'Main_Menu'
          main_menu
        end
        
      elsif input == loser
        puts "Wrong!!! Do your homework!".light_red.underline 
        puts "--------------------"
        puts "--------------------"
        new_game.save
        Round.create_round(@@current_user.id, new_game.id, false)
        prompt = PROMPT
        choice = prompt.select("",%w(Play_Again Main_Menu))
          case choice
            when 'Play_Again'
              new_round
            when 'Main_Menu'
              main_menu
          end
      elsif
        puts "Invalid input. Please try again."
        puts "--------------------"
      end


    end


  

end

# class CLI  jt version ^^^^^^^^= copied to my version

#   def self.run

#     puts "Welcome, human."

#     puts "This is where the instructions will be."
#     puts "--------------------"

#     while true

#       puts "Please enter your name or type 'exit' to exit application: "
#       name = gets.chomp
#       break if name == "exit"
#       user = User.find_or_create_by(name: name)

#       puts "Welcome, #{user.name}."
#       puts "--------------------"


#       while true
#         puts "Press 1 to start new round"
#         puts "Press 2 to check stats"
#         puts "--------------------"
#         select = gets.chomp.to_i
#         break if select == 1
#         puts "You have played #{user.round_count} rounds."
#         puts "You have #{user.win_count} wins and #{user.loss_count} losses."
#         puts "You have #{user.points} points."^^^^^^^^^^^^^^^^^^^^^^
#         puts "--------------------"
#         puts "--------------------"
#       end

#       new_game = Game.create_game

#       puts "--------------------"
#       puts "This is a #{new_game.point_value} point question."
#       puts "The year is #{new_game.year}." #1990 is the api_year_value
#       puts "The home team was the #{new_game.home_team}, and the away team was the #{new_game.visitor_team}." #api_home_team and #api_away_team
#       puts "The final score was #{new_game.score}." #api_home_team_points and api_away_team_points
#       puts "The top scorers for the #{new_game.home_team} were: #{new_game.home_team_top_scorers}."^^^^^^^^^^^^^
#       puts "The top scorers for the #{new_game.visitor_team} were: #{new_game.visitor_team_top_scorers}."^^^^^^^^^^^^^
#       puts "--------------------"
#       puts "Who do you think won?"
#       puts "--------------------"

#       while true
#         puts "Type your answer or type 'help' for instructions."
#         puts "--------------------"
#         winner = new_game.winner #winner is Warriors if api_home_team_points > api_away_team_points
#         loser = new_game.loser
#         input = gets.chomp

#         break if input == "quit"

#         if input == winner
#           puts "You guessed correctly!"
#           puts "--------------------"
#           puts "--------------------"
#           new_game.save
#           Round.create_round(user.id, new_game.id, true)
#           break
#         elsif input == loser
#           puts "--------------------"
#           puts "Incorrect."
#           puts "Better luck next time!"
#           puts "--------------------"
#           puts "--------------------"
#           new_game.save
#           Round.create_round(user.id, new_game.id, false)

#           break
#         elsif input == "help"
#           puts "This is where the instructions will be."
#           puts "--------------------"
#         elsif
#           puts "Invalid input. Please try again."
#           puts "--------------------"
#         end


#       end


#       end


#   end


# end