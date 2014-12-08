module Hijri
  class Hijri

    attr_accessor :day, :month, :year
    MONTHNAMES_EN = %w(Muharram Safar Rabia-Awwal Rabia-Thani Jumaada-Awal Jumaada-Thani Rajab Sha'ban Ramadan Shawwal Dhul-Qi'dah Dhul-Hijjah)
    DAYNAMES = %w(as-Sabt al-Ahad al-Ithnayn ath-Thalaathaa al-Arba'aa' al-Khamis al-Jumu'ah)
  
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
  
    def to_abs
      month_days = 29 * (month - 1) # days on this year
      nonleap_year_days  = 354 * (year - 1)
      leap_year_days = (3 + (11 * year)) / 30.0
      this_year  = (month / 2.0).to_i
      
      return (day + month_days + this_year + nonleap_year_days + leap_year_days + Hijri::ISLAMIC_EPOCH).to_i
    end
  
    def to_greo
      Date.new *Converter.hijri_to_greo(self)
    end
  
    class << self
      def today
        d = Date.send(:now)
        # Hijri.new.greo_to_hijri(d)
      end
    end
  end
end