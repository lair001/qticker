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

desc 'drop into the Pry console with only gems loaded to test scraping GFS for a stock'
task :gfs_stock_console do
	require 'bundler/setup'
	Bundler.require(:default, :development)
	require 'open-uri'
	require 'word_wrap/core_ext'
	ARGV.clear
	browser = Watir::Browser.new(:phantomjs)
	browser.goto("https://www.google.com/finance?q=MSFT")
	noko = Nokogiri::HTML(browser.html)
	binding.pry
end
