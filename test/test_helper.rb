require 'rubygems'
require 'test/unit'
require 'fake_web'
require 'open-uri'
require File.dirname(__FILE__) + '/../lib/nytimes_movies'

def enable_fake_web
  dir = File.dirname(__FILE__)
end

def disable_fake_web
  FakeWeb.clean_registry
end

