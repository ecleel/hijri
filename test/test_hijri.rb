require 'helper'
require 'hijri'

class TestHijri < MiniTest::Unit::TestCase

  def test_version
    version = Hijri.const_get('VERSION')

    assert(!version.empty?, 'should have a VERSION constant')
  end
  
  def test_hijri_to_string
    date = Hijri::Date.new 1433, 9, 18
    assert_equal "1433-09-18", date.to_s
  end
  
  def test_greo_date_to_hijri
    date = Date.new 2014, 12, 7
    # switiching between solar calendar and lunar calendar is a bit
    # hard and complecated and there is error ratio to it. Because
    # of that we accept multiple date as a result.
    correct_dates = (14..16).map {|n| "1436-02-#{n}" }
    assert_includes correct_dates, date.to_hijri.to_s
  end
  
  def test_hijri_to_greo
    h = Hijri::Date.new 1430, 1, 1
    g = Date.new 2008, 12, 29
    assert_equal(g , h.to_greo)
  end
  
  # TODO test hijri.now  
  # TODO test Hijri::Date
  # TODO test Hijri::DateTime
end
