require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require './environments'

class Game < ActiveRecord::Base
end

get "/history" do
  games = Game.order("timestamp DESC")
  history = games.reduce([]) do |game_history, game|
    game_history << {:timestamp => game.timestamp, 
                     :board => game.board}
  end
  json :games => history
end

#post "/history" do

#end
