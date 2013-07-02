require 'rubygems'
require 'bundler'
require 'sinatra'
require 'data_mapper'
require 'haml'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
	class App < Sinatra::Application
    before do
      json = File.open("data/citibikenyc.json").read
      @data = MultiJson.load(json)


    get '/' do
      erb :home
    end

    get '/stations' do
      @station = Station.all
      haml :index
    end

    get '/stations/new' do
      @station = Station.new
      haml :new
    end
      
    post '/stations' do
      @station = Station.new(params[:station])
      if @station.save
        status 201
        redirect '/stations/' + @station.id.to_s
      else
        status 400
        haml :new
      end
    end

    get '/stations/edit/:id' do
      @station = Station.get(params[:id])
      haml :edit
    end

    put '/stations/:id' do
      @station = Station.get(params[:id])
      if @station.update(params[:station])
        status 201
        redirect '/stations/' + params[:id]
      else
        status 400
        haml :edit  
      end
    end

    get '/stations/delete/:id' do
      @station = Station.get(params[:id])
      haml :delete
    end

    delete '/stations/:id' do
      Station.get(params[:id]).destroy
      redirect '/stations'  
    end

    get '/stations/:id' do
      @station = Station.get(params[:id])
      haml :show
    end

    helpers do
        def partial(view)
          erb view, :layout => false
        end
end