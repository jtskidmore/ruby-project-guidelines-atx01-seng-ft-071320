
class Controller
  ######################################### Method that runs all other methods ###############################
 def self.run
   intro
   profile
 end

 ############################################ ALL OF THE METHODS ###########################################


    def self.main_menu
     if @@current_user == nil
            puts "You have to be logged in to play NBA TRIVIA :("
            login
     else
        puts"\n" * 20 #20
        intro
        puts "Hello #{@@current_user.name.light_blue.bold}!"
        puts "\n"
        menu_selection = PROMPT.select("Select an option:", ["Start round", "Stats", "Help", "Logout", "Quit game"])
        case menu_selection
        when 'Start round'
            new_round
          when 'Stats'
            stats
          when 'Help'
            help
          when 'Logout'
            @@current_user = nil
            main_menu
          when 'Quit game'
            quit
         end
         puts "\n" * 3 #10
      end
    end

    def self.signup
      sign_up = PROMPT.select("\n\n\n", ["Signup", "Back"])

        if sign_up == "Signup"
          puts "Please enter a username:"
          puts "\n" * 3
          name = gets.chomp
            @@current_user = User.create(name: name)
            main_menu
        else sign_up == "Back"
            new_user
        end

    end

    def self.login
       login_or_exit = PROMPT.select("", ["Login", "Back"])
       if login_or_exit == "Login"
          puts "\n" * 5
          find_user = PROMPT.ask("What is your username?".light_cyan, required: true)
          @@current_user = User.find_by(name: find_user)
            if @@current_user == nil
              puts "User not found.".light_red
              puts "Please try again."
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
        puts "*".light_cyan * 50
        puts "*".red * 50
        puts "WELCOME TO NBA TRIVIA!".blue.underline
        puts "The game is simple:".white
        puts "\n"
        puts "We give you some info about a specific NBA game and you tell us who you think won that game?".green
        puts "If you guess correctly, you're rewarded points based on the difficulty of the question.".green
        puts "\n"
        puts "Point System:".light_blue.underline
        puts "Close games are 3 pointers".white
        puts "Average games are 2 pointers".white
        puts "Blowouts (one-sided games) are free-throws (1 pointer)".white
        puts "\n"
        puts "The more you guess correctly, the more your point stats grow!".green
        puts "Easy enough, right? Let's begin!".green
        puts "*".red * 50
        puts "*".light_cyan * 50
    end

    def self.help
      instructions
      prompt = PROMPT
      option = prompt.select("\n\n", ["Start round", "Main Menu" ])
      case option
      when 'Start round'
        new_round
      when 'Main Menu'
        main_menu
      end
    end

    def self.new_user
      instructions
      puts "/".red * 100
      puts "\n" * 3
      prompt = PROMPT
        login = prompt.select("Select an option", ["Create username", "Back", "Quit game"])
      if login == 'Create username'
        signup
      elsif login == 'Back'
        intro
        profile
      elsif login == 'Quit game'
        quit
      end
    end

    def self.intro

          puts"


          _ _ _     _                      _
          | | | |___| |___ ___ _____ ___   | |_ ___
          | | | | -_| |  _| . |     | -_|  |  _| . |_ _ _
          |_____|___|_|___|___|_|_|_|___|  |_| |___|_|_|_|
                                                                                                                                              ".colorize(:light_blue)

                puts "
                ███╗   ██╗██████╗  █████╗     ████████╗██████╗ ██╗██╗   ██╗██╗ █████╗   ██╗
                ████╗  ██║██╔══██╗██╔══██╗    ╚══██╔══╝██╔══██╗██║██║   ██║██║██╔══██╗  ██║
                ██╔██╗ ██║██████╔╝███████║       ██║   ██████╔╝██║██║   ██║██║███████║  ██║
                ██║╚██╗██║██╔══██╗██╔══██║       ██║   ██╔══██╗██║╚██╗ ██╔╝██║██╔══██║  ╚═╝
                ██║ ╚████║██████╔╝██║  ██║       ██║   ██║  ██║██║ ╚████╔╝ ██║██║  ██║  ██╗
                ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝  ╚═╝  ╚═╝
                                                                                                      ".colorize(:color => :green, :background => :light_grey)
                puts"\n" * 5
    end

    def self.quit
      puts "\n" * 10 #30

      puts "
       ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗
      ██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
      ██║  ███╗██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ █████╗
      ██║   ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██╔══╝
      ╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ███████╗
       ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝
                                      ".green.bold
      print "\s" * 25,"Play again soon!".blue
      # puts "\n" * 5
    end

    def self.stats
            puts "You have played #{@@current_user.round_count} round(s).".white
            puts "Wins: ""#{@@current_user.win_count}".green
            puts "Losses: ""#{@@current_user.loss_count}".red
            puts "Points: ""#{@@current_user.points}".blue
            puts "--------------------"
            puts "\n"
            prompt = PROMPT
            option = prompt.select("", ["Start round", "Main Menu", "Quit game"])
            case option
            when 'Start round'
              new_round
            when 'Main Menu'
              main_menu
            when 'Quit game'
              quit
            end
    end

    def self.new_round
      new_game = Game.create_game
      puts "\n" * 5
      puts "--------------------".light_cyan
      puts "\n" * 2
      print "The year was ".white
      print"#{new_game.year}".blue #1990 is the api_year_value
      puts "\n" * 2
      print "The home team was the".white
      print " #{new_game.home_team}".green
      print ", and the away team was the".white
      print " #{new_game.visitor_team}".red #api_home_team and #api_away_team
      puts "\n" * 2
      print "The final score was".white
      print " #{new_game.score}".light_blue #api_home_team_points and api_away_team_points
      puts "\n" * 2
      print "The top scorers for the".white
      print " #{new_game.home_team} were:".white
      print " #{new_game.home_team_top_scorers}".yellow
      puts "\n" * 2
      print "The top scorers for the".white
      print " #{new_game.visitor_team} were:".white
      print " #{new_game.visitor_team_top_scorers}".yellow
      puts"\n" * 2
      print "Point value:".white
      print " #{new_game.point_value}".blue
      print " pointer".white
      puts"\n" * 2
      puts "Who do you think won?".white
      puts "\n" * 2
      puts "--------------------".light_cyan



      puts "Select a team."
      puts "--------------------".light_cyan
      puts "\n" * 2
      winner = new_game.winner #winner is Warriors if api_home_team_points > api_away_team_points
      loser = new_game.loser
      input =

      prompt = PROMPT
      team_choice = prompt.select("", ["#{new_game.home_team}", "#{new_game.visitor_team}"])
      case team_choice
      when "#{new_game.home_team}"
        input = new_game.home_team
      when "#{new_game.visitor_team}"
        input = new_game.visitor_team
      end


      if input == winner
        puts "You guessed correctly! Nice.".green.bold
        puts "--------------------"
        puts " To quit game, return to Main Menu, or select Play again."
        puts "--------------------"
        new_game.save
        Round.create_round(@@current_user.id, new_game.id, true)
        prompt = PROMPT
        choice = prompt.select("", ["Play again", "Main Menu"])
        case choice
        when 'Play again'
          new_round
        when 'Main Menu'
          main_menu
        end

      elsif input == loser
        puts "Wrong! Please do your homework.".light_red.bold
        puts "--------------------"
        puts " To quit game, return to Main Menu, or select 'Play again'."
        puts "--------------------"
        new_game.save
        Round.create_round(@@current_user.id, new_game.id, false)
        prompt = PROMPT
        choice = prompt.select("",["Play again", "Main Menu"])
          case choice
          when 'Play again'
              new_round
            when 'Main Menu'
              main_menu
          end
      elsif
        puts "Invalid input. Please try again."
        puts "--------------------"
      end


    end




end
