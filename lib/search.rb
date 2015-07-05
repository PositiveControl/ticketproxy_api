require 'faraday'
require 'pry'
require 'dotenv'

Dotenv.load

class Search

  def self.general_query(params)
    request(params, :general, true)
  end

  def self.venue_query(params)
    request(params, :venue)
  end

  def self.ticket_query(params)
    request(params, :tickets_2)
  end

  def self.location_query(params)
    request(params, :location)
  end

  def self.event_query(params)
    request(params, :event)
  end

  private

  RESULTS_IDS = {
    :general => 301,
    :tickets => 302,
    :tickets_2 => 507,
    :event => 303,
    :event_names => 404,
    :venue => 304,
    :location => 305,
    :date => 306,
    :category => 307
  }

  PARAMS_MAPPER = {
    :broker_id => :bid,
    :site_number => :sitenumber,
    ### FINISH params mapper

  }

  CONN = Faraday.new(:url => "http://tickettransaction.com/") do |faraday|
    faraday.request :url_encoded
    faraday.response :logger
    faraday.adapter Faraday.default_adapter
  end

  def self.request(params, result_type, html = false)
      request = CONN
        .get(build_query(params, result_type, html))
      if request.body.include?('404?')
        "404 - This is not the page you are looking for"
      else
        request.body
      end
  end

  def self.build_query(params, result_type, html = false)
    query = "?bid=#{ENV['BROKER_ID']}&sitenumber=1&tid=#{RESULTS_IDS[result_type]}"
    query + "&html=true" if html
    params.each { |k, v| query << "&#{k}=#{v}" }
    query
  end

end