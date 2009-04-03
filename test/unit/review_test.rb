require File.dirname(__FILE__) + '/../test_helper'

# NYTimes::Movies::Review.debug = true

enable_fake_web

#http://api.nytimes.com/svc/movies/v2/reviews/search.xml?query=big&api-key=******** (WORKS)

class TestReview < Test::Unit::TestCase
  def test_search
    r = NYTimes::Movies::Review.search('once upon a time')
    assert_equal 5, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Review }
    assert r.any? { |_| _.display_title == 'Once Upon A Time In America' }
  end
end