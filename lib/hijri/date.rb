module Hijri
  class Date

    include Comparable

    attr_reader :day, :month, :year

    # TODO change mon to month in format.rb.
    alias :mon  :month
    alias :mday :day
    

    MONTHNAMES = [nil] + %w(Muharram Safar Rabia-Awwal Rabia-Thani Jumaada-Awal Jumaada-Thani Rajab Sha'ban Ramadan Shawwal Dhul-Qi'dah Dhul-Hijjah)
    DAYNAMES = %w(as-Sabt al-Ahad al-Ithnayn ath-Thalaathaa al-Arba'aa' al-Khamis al-Jumu'ah)
    ABBR_MONTHNAMES = [nil] + ["Muharram", "Safar", "Rabia I", "Rabia II", "Jumaada I", "Jumaada II", "Rajab", "Sha'ban", "Ramadan", "Shawwal", "Dhul-Qi'dah", "Dhul-Hijjah"]
    ABBR_DAYNAMES = %w(Sabt Ahad Ithnayn Thalaathaa Arba'aa' Khamis Jumu'ah)
    
    [MONTHNAMES, DAYNAMES, ABBR_MONTHNAMES, ABBR_DAYNAMES].each do |xs|
      xs.each{|x| x.freeze unless x.nil?}.freeze
    end
    
    HALF_DAYS_IN_DAY       = Rational(1, 2) # :nodoc:
    HOURS_IN_DAY           = Rational(1, 24) # :nodoc:
    MINUTES_IN_DAY         = Rational(1, 1440) # :nodoc:
    SECONDS_IN_DAY         = Rational(1, 86400) # :nodoc:
    MILLISECONDS_IN_DAY    = Rational(1, 86400*10**3) # :nodoc:
    NANOSECONDS_IN_DAY     = Rational(1, 86400*10**9) # :nodoc:
    MILLISECONDS_IN_SECOND = Rational(1, 10**3) # :nodoc:
    NANOSECONDS_IN_SECOND  = Rational(1, 10**9) # :nodoc:

    class << self
      def today
        date = ::Date.today
        date.to_hijri
      end
    end

    def initialize(year=1, month=1, day=1)
       @year, @month, @day = year, month, day
    end

    def islamic_leap_year?
      return (((((11 * self.year) + 14) % 30) < 11) ? true : false)
    end

    def last_day_of_islamic_month
      # Last day in month during year on the Islamic calendar.
      return ((self.month % 2 == 1) || (self.month == 12 && islamic_leap_year?) ? 30 : 29)
    end

    def to_s
      "#{@year}-#{sprintf('%02d', @month)}-#{sprintf('%02d', @day)}"
    end

    def <=>(date)
      # Make sure the date is a Hijri::Date instance
      date = date.to_hijri
      if self.to_s == date.to_s
        return 0
      elsif @year > date.year || (@year == date.year && @month > date.month) || (@year == date.year && @month == date.month && @day > date.day)
        return 1
      else
        return -1
      end
    end

    def to_abs
      month_days = 29 * (month - 1) # days on this year
      nonleap_year_days  = 354 * (year - 1)
      leap_year_days = (3 + (11 * year)) / 30.0
      this_year  = (month / 2.0).to_i

      return (day + month_days + this_year + nonleap_year_days + leap_year_days + Hijri::ISLAMIC_EPOCH).to_i
    end

    def to_greo
      ::Date.new *Converter.hijri_to_greo(self)
    end

    # Just to have a consistent Interface.
    def to_hijri
      self
    end

  end
end
