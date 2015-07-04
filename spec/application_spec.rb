require 'spec_helper'
require_relative '../application'
require 'rack/test'
require 'pry'

describe 'Application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should respond with JSON (#get index)' do
    get '/'
    expect(last_response.body).to eql("Hello Moto!")
  end

  it 'should respond with query results' do
    post '/search', {:query => 'Red Rocks'}
    expect(last_response.body).to include("<!--")
  end


end