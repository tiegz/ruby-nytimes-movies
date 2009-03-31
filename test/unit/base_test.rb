require File.dirname(__FILE__) + '/../test_helper'

class Foobar < NYTimes::Movies::Base
  attr_accessor :foo, :bar, :baz 
end

class TestBase < Test::Unit::TestCase
  
  def test_new_should_set_hash_of_attributes
    f = Foobar.new(:foo => '123', :bar => 'abc')
    assert_equal '123', f.foo
    assert_equal 'abc', f.bar
    assert_nil f.baz
  end
  
  # def test_string_to_alias
  #   assert_equal NYTimes::Movies::Base.send(:string_to_alias, "Dinosaur Jr."), 'dinosaur_jr'
  #   assert_equal NYTimes::Movies::Base.send(:string_to_alias, " Something  with spaces  "), 'something_with_spaces'
  #   assert_equal NYTimes::Movies::Base.send(:string_to_alias, "Soundtracks / Musicals"), 'soundtracks_musicals'
  # end
  
end