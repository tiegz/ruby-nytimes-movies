require File.dirname(__FILE__) + '/../test_helper'

# NYTimes::Movies::Review.debug = true

enable_fake_web

class TestReview < Test::Unit::TestCase
  def test_search
    a = NYTimes::Movies::Review.search('neon')
    assert a.all? { |_| _.is_a? NYTimes::Movies::Review }
    assert a.any? { |_| _.name == 'Neon' }
  end
end