task :environment do
  require_relative './config/environment.rb'
end

task :development do
	Bundler.require(:development)
end

desc 'drop into the Pry console'
task :console => [:environment, :development] do
	cli = Cli.new
  ARGV.clear
	binding.pry
end
