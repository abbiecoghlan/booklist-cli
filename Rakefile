require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc 'install'
task :launch do 
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

desc 'starts app'
task :launch do 
  ruby "bin/run.rb"
end