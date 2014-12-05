require 'helper'
require 'hijri'

class TestHijri < MiniTest::Unit::TestCase

  def test_version
    version = Hijri.const_get('VERSION')

    assert(!version.empty?, 'should have a VERSION constant')
  end
  
  def test_hijri_to_s
    date = Hijri::Hijri.new 1433, 9, 18
    assert_equal "1433-09-18", date.to_s
  end
  
  def test_datetime_to_hijri
    date = Date.new 2012, 8, 6
    assert_equal "1433-09-18", date.to_hijri.to_s
  end
end
