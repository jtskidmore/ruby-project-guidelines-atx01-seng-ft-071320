require 'bundler'
require 'open-uri'
require 'net/http'
require 'json'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# ActiveRecord::Base.logger.level = 1
ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
ActiveRecord::Base.logger.level = 1
require_all 'lib'
