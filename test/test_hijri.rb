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
  
  def test_hijri_date_today
    gdate = Date.today
    hdate = Hijri::Date.today
    assert_equal gdate, hdate.to_greo
  end
  
  def test_hijri_datetime_now_create_datetime_object_with_now_date_and_time
    g_datetime = DateTime.now
    h_datetime = Hijri::DateTime.now
    exact_date = h_datetime.to_greo

    # I assert it one by one because there is a different in n variable in
    # DateTime and I couldn't find it.
    # -#<DateTime: 2014-12-09T13:46:30+03:00 ((2457001j,38790s,467109000n),+10800s,2299161j)>
    # +#<DateTime: 2014-12-09T13:46:30+03:00 ((2457001j,38790s,0n),+10800s,2299161j)>
    assert_equal g_datetime.year, exact_date.year
    assert_equal g_datetime.month, exact_date.month
    assert_equal g_datetime.day, exact_date.day
    assert_equal g_datetime.hour, exact_date.hour
    assert_equal g_datetime.minute, exact_date.minute
    assert_equal g_datetime.second, exact_date.second
    assert_equal g_datetime.zone, exact_date.zone
  end

  def test_comparing_two_hijri_date
    date1 = Hijri::Date.new 1435, 1, 1
    date2 = Hijri::Date.new 1435, 1, 1
    
    assert_equal date1, date2
  end
end
