require File.dirname(__FILE__) + '/../test_helper'

# NYTimes::Movies::Review.debug = true

enable_fake_web

# ex: http://api.nytimes.com/svc/movies/{version}/critics/{resource-type}[.response_format]?api-key={your-API-key}

class TestCritic < Test::Unit::TestCase
  def test_all
    r = NYTimes::Movies::Critic.all
    assert_equal 41, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Critic }
    assert r.any? { |_| _.display_name == 'Stephen Holden' }
    assert r.any? { |_| _.image.url == 'http://graphics8.nytimes.com/images/2007/03/02/movies/scott.163.jpg' }
  end
  
  def test_all_full_time
    r = NYTimes::Movies::Critic.full_time
    assert_equal 3, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Critic }
    assert r.any? { |_| _.display_name == 'Stephen Holden' }
    assert r.any? { |_| _.image.url == 'http://graphics8.nytimes.com/images/2007/03/02/movies/scott.163.jpg' }
    assert r.all? { |_| _.status == 'full-time' }
  end
  
  def test_all_full_time
    r = NYTimes::Movies::Critic.part_time
    assert_equal 38, r.size
    assert r.all? { |_| _.is_a? NYTimes::Movies::Critic }
    assert r.any? { |_| _.display_name == 'D. J. R. Bruckner' }
    assert r.all? { |_| _.status == 'part-time' }
  end

  def test_find
    a = NYTimes::Movies::Critic.find('A. O. Scott')
    assert a.is_a?(NYTimes::Movies::Critic)
    assert_equal 'A. O. Scott', a.display_name
    assert_equal 'A-O-Scott', a.seo_name
  end

  def test_find_nil
    assert_raise(NYTimes::Movies::Error) { NYTimes::Movies::Critic.find('Cheetara') }
  end

end