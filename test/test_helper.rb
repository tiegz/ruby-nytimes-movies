require 'rubygems'
require 'test/unit'
require 'fake_web'
require 'open-uri'
require File.dirname(__FILE__) + '/../lib/nytimes_movies'

def enable_fake_web
  dir = File.dirname(__FILE__)
  
  NYTimes::Movies::Base.api_key = 'foobar'
  
  # Review fixtures
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/reviews/search.json?query=once%252520upon%252520a%252520time&api-key=foobar', :string => File.read("#{dir}/fixtures/reviews_search_once-upon-a-time.json"))
  
end

def disable_fake_web
  FakeWeb.clean_registry
end

