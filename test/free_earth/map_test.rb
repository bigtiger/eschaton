require File.dirname(__FILE__) + '/../test_helper'

Test::Unit::TestCase.output_fixture_base = File.dirname(__FILE__)
    
class FreeEarthMapTest < Test::Unit::TestCase
  
  def test_map_initialize
    assert_output_fixture :map_default,
                          Eschaton.with_global_script{ 
                            map = FreeEarth::Map.new
                          }

  end


end
