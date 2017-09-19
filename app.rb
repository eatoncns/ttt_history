require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'json'
require './environments'

class Game < ActiveRecord::Base
end

before do
  setupCORS()
end

def setupCORS
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "HEAD,GET,POST,OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
end

options '*' do
  setupCORS()
  halt 200
end

get "/history" do
  games = Game.order("timestamp ASC")
  history = games.reduce([]) do |game_history, game|
    game_history << {:timestamp => game.timestamp, 
                     :board => game.board.split(',', -1)}
  end
  json :games => history
end

post "/history" do
  input = JSON.parse(request.body.read)
  game = Game.new()
  game.player_id = 1
  game.board = input['board'].join(',') 
  game.timestamp = input['timestamp']
  game.save()
  halt 200
end
