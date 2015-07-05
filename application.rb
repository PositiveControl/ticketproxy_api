require 'omicron'
require 'sinatra'
require 'pipe'
require 'JSON'
require_relative 'lib/search'
require 'pry'
require 'dotenv'
require_relative 'lib/search_serializer'
require_relative 'lib/params_mapper'

Dotenv.load

# include Omicron.serialization(SearchSerializer)
include Pipe

get '/' do
  erb :index
end

get '/search' do
  pipe(params, :through => [:map_params, :perform_search, :serialize])
end

post '/search' do
  pipe(params, :through => [:map_params, :perform_search, :serialize])
end

get '/tickets' do
  pipe(params, :through => [:map_params, :get_tickets, :serialize])
end

get '/venue' do
  pipe(params, :through => [:map_params, :get_venue, :serialize])
end

get '/location' do
  pipe(params, :through => [:map_params, :get_location, :serialize])
end

get '/event' do
  pipe(params, :through => [:map_params, :get_event, :serialize])
end

private

def map_params(params)
  ParamsMapper
    .new(params)
    .execute
end

def perform_search(params)
  Search.general_query(params)
end

def get_tickets(params)
  Search.ticket_query(params)
end

def get_venue(params)
  Search.venue_query(params)
end

def get_location(params)
  Search.location_query(params)
end

def get_event(params)
  Search.event_query(params)
end

def serialize(params)
  SearchSerializer
    .new
    .search_collection(params)
end

def decorate(params)
  params
end
