
class Controller
  ######################################### Method that runs all other methods ###############################
 def self.run
  intro 
  profile 
  main_menu
 end



 ############################################ ALL OF THE METHODS ###########################################


    def self.main_menu 
     puts "\n"
     if @@current_user == nil
            puts "You have to be logged in to play NBA TRIVIA!!! :("
            login
     else
        intro
        puts "Hello #{@@current_user.name.light_blue.bold}!"
        puts "\n" 
        menu_selection = PROMPT.select("Select an option:", %w(StartNewRound Stats Help LogOut QuitGame))
        case menu_selection
          when 'StartNewRound' #Need to bring method over from old cli.rb
            new_round
          when 'Stats'      
            stats
          when 'Help'       
            instructions
          when 'LogOut'    
            @@current_user = nil
            main_menu
          when 'Quitgame'
            quit 
         end
      end
    end

    def self.signup
      sign_up = PROMPT.select("SignUP or Exit", %w(SignUP Exit))
        
        if sign_up == "SignUP"
          puts "Please enter a username:"
          name = gets.chomp
            @@current_user = User.create(name: name)
            main_menu
        else sign_up == "Exit"
            quit
        end

    end

    def self.login
       login_or_exit = PROMPT.select("", %w(Login ExitGame))
       if login_or_exit == "Login"
          puts "\n" * 5
          find_user = PROMPT.ask("What is your username?".light_cyan, required: true)
          @@current_user = User.find_by(name: find_user)
            if @@current_user == nil
              puts "User not found".light_red
              puts "Please try again!"
              self.login
            end
        elsif 'ExitGame'
              quit
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
 
    def self.new_user
      instructions
      puts "/".red * 50
      prompt = PROMPT
      login = prompt.select("CreateUsername or Exit", %w(CreateUsername ExitGame))
      if login == 'CreateUsername'
        signup
      elsif login == 'ExitGame'
        quit
      end
    end

    def self.intro
          # puts              "WELCOME TO".colorize(:light_cyan).bold
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
      puts "\n" * 20
      print "\s" * 25,"Play Again Soon!".blue
      puts "\n"
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
            puts "You have played #{@@current_user.round_count} round(s)."
            puts "Wins: #{@@current_user.win_count}" 
            puts "Losses: #{@@current_user.loss_count}"
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
      puts "The year is #{new_game.year}" #1990 is the api_year_value
      puts "The home team was the #{new_game.home_team}, and the away team was the #{new_game.away_team}" #api_home_team and #api_away_team
      puts "The final score was #{new_game.score}" #api_home_team_points and api_away_team_points
      puts "Who do you think won?"
      puts "--------------------".light_cyan
      help = "help".yellow

    
      puts "Type your answer or type #{help} for instructions."
      puts "--------------------"
      winner = new_game.winner #winner is Warriors if api_home_team_points > api_away_team_points
      loser = new_game.loser
      input = gets.chomp


      if input == winner
        puts "You guessed correctly!"
        puts "--------------------"
        puts "--------------------"
        new_game.save
        Round.create_round(@@current_user.id, new_game.id, true)
        prompt = PROMPT#experimental code
        option = prompt.select("",%w(Play_Again Main_Menu))#experimental code
        case option 
        when 'Play_Again'
          new_round
        when 'Main_Menu'
          main_menu
        end
        
      elsif input == loser
        puts "Wrong!!! Do your homework!"
        puts "--------------------"
        puts "--------------------"
        new_game.save
        Round.create_round(@@current_user.id, new_game.id, false)
        prompt = PROMPT#experimental code
        prompt.select("",%w(Play_Again Main_Menu))#experimental code
          case option 
            when 'Play_Again'
              new_round
            when 'Main_Menu'
              main_menu
          end
      elsif input == "help"
        instructions
        puts "--------------------"
      elsif
        puts "Invalid input. Please try again."
        puts "--------------------"
      end


    end


  

end