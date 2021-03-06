require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

require_all 'lib'

#Turn off SQL statement logging
module ActiveSupport
  class LogSubscriber
    def debug(*args, &block)
    end
  end
end