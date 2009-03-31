require 'rubygems'
require 'activesupport'
#require 'hpricot'
require 'open-uri'
require 'benchmark'

require 'lib/nytimes/movies/base'
require 'lib/nytimes/movies/review'

module NYTimes
  module Movies
    class Error < StandardError; end
  end
end