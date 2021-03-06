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
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/reviews/all.json?api-key=foobar', :string => File.read("#{dir}/fixtures/reviews_all.json"))
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/reviews/picks.json?api-key=foobar', :string => File.read("#{dir}/fixtures/reviews_picks.json"))
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/reviews/dvd-picks.json?api-key=foobar', :string => File.read("#{dir}/fixtures/reviews_dvd-picks.json"))

  # Critic fixtures
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=foobar', :string => File.read("#{dir}/fixtures/critics_all.json"))
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/critics/full-time.json?api-key=foobar', :string => File.read("#{dir}/fixtures/critics_full-time.json"))
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/critics/part-time.json?api-key=foobar', :string => File.read("#{dir}/fixtures/critics_part-time.json"))
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/critics/a-o-scott.json?api-key=foobar', :string => File.read("#{dir}/fixtures/critics_find_a-o-scott.json"))
  FakeWeb.register_uri('http://api.nytimes.com/svc/movies/v2/critics/cheetara.json?api-key=foobar', :string => File.read("#{dir}/fixtures/critics_find_cheetara.json"))

end

def disable_fake_web
  FakeWeb.clean_registry
end

