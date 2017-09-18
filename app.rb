require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require './environments'

class Game < ActiveRecord::Base
end

before do
  setupCORS()
end

def setupCORS
  response.headers["Access-Control-Allow-Origin"] = "*"
end

get "/history" do
  games = Game.order("timestamp ASC")
  history = games.reduce([]) do |game_history, game|
    game_history << {:timestamp => game.timestamp, 
                     :board => game.board}
  end
  json :games => history
end

post "/history" do
  game = Game.new()
  game.player_id = 1
  game.board = params['board']
  game.timestamp= params['timestamp']
  game.save()
  halt 200
end
