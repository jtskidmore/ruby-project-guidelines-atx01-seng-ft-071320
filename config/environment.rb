require 'bundler'
require 'open-uri'
require 'net/http'
require 'json'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

require_all 'lib'

#NEW INSTANCE OF TTY PROMPT FOR MENU FEATURE
PROMPT = TTY::Prompt.new



#REMOVE THE SQL FIRE FROM THE DIPLAYED INFO IN THE TERMINAL
ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
ActiveRecord::Base.logger.level = 1

