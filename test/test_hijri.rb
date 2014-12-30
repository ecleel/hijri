require 'helper'
require 'hijri'

class TestHijri < MiniTest::Unit::TestCase

  def test_version
    version = Hijri.const_get('VERSION')

    assert(!version.empty?, 'should have a VERSION constant')
  end
  
  def test_hijri_date_to_string
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

  def test_comparing_hijri_date_and_greogrian_date
    date1 = Hijri::Date.new(1435, 1, 1)
    date2 = Hijri::Date.new(1435, 1, 1).to_greo

    assert_equal date1, date2
  end

  def test_comparing_two_hijri_datetime
    date1 = Hijri::DateTime.new(1435, 1, 1, 1, 1, 1, 1)
    date2 = Hijri::DateTime.new(1435, 1, 1, 1, 1, 1, 1)

    assert_equal date1, date2
  end

  def test_hijri_datetime_to_string
    datetime = Hijri::DateTime.new 1433, 9, 18, 1, 1, 1, '+03:00'
    assert_equal "1433-09-18T01:01:01+03:00", datetime.to_s
  end

  def test_hijri_datetime_to_string_add_plus_for_zone_equal_0000
    datetime = Hijri::DateTime.new 1433, 9, 18, 1, 1, 1, '00:00'
    assert_equal "1433-09-18T01:01:01+00:00", datetime.to_s
  end
  
  def test_hijri_date_strftime_shows_hijri_month_names
    date = Hijri::Date.new 1436, 2, 21
    assert_equal "Safar", date.strftime("%B")
  end

  def test_hijri_date_strftime_with_no_input
    date = Hijri::Date.new 1433, 9, 18
    assert_equal "1433-09-18", date.strftime
  end
  
  def test_hijri_datetime_strftime_with_no_input
    datetime = Hijri::DateTime.new 1433, 9, 18, 1, 1, 1, '+03:00'
    #"1433-09-18T01:01:01+03:00"
    assert_equal datetime.to_s, datetime.strftime
  end
  
  def test_hijri_full_arabic_month
    date = Hijri::Date.new 1436, 3, 1
    assert_equal "Rabia-Awwal", date.strftime('%B')
  end
  
  def test_hijri_short_arabic_month_name
    date = Hijri::Date.new 1436, 3, 1
    assert_equal "Rabia I", date.strftime('%b')
  end
  
  # def test_hijri_full_arabic_day_name
  #   date = Hijri::Date.new 1436, 3, 1
  #   assert_equal "AsSabt", date.strftime('%A')
  # end
  #
  # def test_hijri_short_arabic_day_name
  #   date = Hijri::Date.new 1436, 3, 1
  #   assert_equal "Rabia I", date.strftime('%b')
  # end

  # TODO remove abbrev Month from format.
  # TODO use arabic names for day
  # TODO for abbrev day wi'll use days names without al. e.g sabt ahad
  # TODO we need to delete a lot of stuff from format.

  # TODO add Hijri::Date.change and test it.
  # TODO yday
  # TODO wday to make %a and %A work

end
