require 'sinatra'
require 'pipe'
require 'JSON'
require_relative 'lib/search'
require 'pry'
require 'dotenv'

Dotenv.load

include Pipe

get '/' do
  erb :index
end

get '/search' do
  erb :results,
    :locals => {
      :results =>
        pipe(params, :through => [:perform_search, :decorate])
    }
end

post '/search' do
  erb :results,
    :locals => {
      :results =>
        pipe(params, :through => [:perform_search, :decorate])
    }
end

get '/tickets' do
  erb :ticket_results,
    :locals => {
      :results =>
        pipe(params, :through => [:get_tickets])
    }
end

get '/venue' do
  erb :venue_results,
    :locals => {
      :results =>
        pipe(params, :through => [:get_venue])
    }
end

get '/location' do
  erb :location_results,
    :locals => {
      :results =>
        pipe(params, :through => [:get_location])
    }
end

private

def perform_search(params)
  Search.perform(params)
end

def get_tickets(params)
  Search.tickets(params)
end

def get_venue(params)
  Search.venue(params)
end

def get_location(params)
  Search.location(params)
end

def decorate(params)
  params
end
