require File.dirname(__FILE__) + '/../test_helper'

# NYTimes::Movies::Review.debug = true

enable_fake_web

# ex: http://api.nytimes.com/svc/movies/v2/reviews/search.xml?query=big&api-key=******** (WORKS)

class TestReview < Test::Unit::TestCase
  def test_search
    r = NYTimes::Movies::Review.search('once upon a time')
    assert_equal 5, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Review }
    assert r.any? { |_| _.display_title == 'Once Upon A Time In America' }
  end

  def test_all
    r = NYTimes::Movies::Review.all
    assert_equal 20, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Review }
    assert r.any? { |_| _.display_title == 'The Song of Sparrows' }
  end
  
  def test_all_critic_picks_in_theatre
    r = NYTimes::Movies::Review.critic_picks_in_theatre
    assert_equal 20, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Review }
    assert r.any? { |_| _.display_title == 'Coraline' }
  end
  
  def test_all_critic_picks_on_dvd
    r = NYTimes::Movies::Review.critic_picks_on_dvd
    # require 'pp'
    # r.each { |rr| pp rr }
    assert_equal 20, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Review }
    assert r.any? { |_| _.display_title == 'Synecdoche, New York' }
  end

end