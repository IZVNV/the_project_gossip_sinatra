require 'bundler'
Bundler.require
require_relative 'gossip'
require 'pry'

class ApplicationController < Sinatra::Base
  get '/' do
    #erb :index
    erb :index, locals: {gossips: Gossip.all}
  end
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  post '/gossips/' do
    id = params["id"]
    redirect "/gossips/#{id}"  
  end
  get '/gossips/:id' do
    id = params["id"]
    selected_gossip = Gossip.find(id)
    erb :show, locals: {gossip: selected_gossip, index: id}
  end
end