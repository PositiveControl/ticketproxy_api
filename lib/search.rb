require 'faraday'
require 'pry'
require 'dotenv'

Dotenv.load

class Search

  def self.perform(params)
    request(params, :general)
  end

  def self.venue(params)
    request(params, :venue)
  end

  def self.tickets(params)
    request(params, :tickets_2)
  end

  def self.location(params)
    request(params, :location)
  end

  private

  RESULTS_IDS = {
    :general => 301,
    :tickets => 302,
    :tickets_2 => 507,
    :event => 303,
    :venue => 304,
    :location => 305,
    :date => 306,
    :category => 307
  }

  CONN = Faraday.new(:url => "http://tickettransaction.com/") do |faraday|
    faraday.request :url_encoded
    faraday.response :logger
    faraday.adapter Faraday.default_adapter
  end

  def self.request(params, result_type)
    CONN
      .get(build_query(params, result_type))
      .body
  end

  def self.build_query(params, result_type)
    query = "?bid=#{ENV['BROKER_ID']}&sitenumber=1&tid=#{RESULTS_IDS[result_type]}"
    params.each { |k, v| query << "&#{k}=#{v}" }
    query
  end

end