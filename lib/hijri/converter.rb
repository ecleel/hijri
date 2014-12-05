module Hijri
  module Converter
    def self.hijri_to_greo hijri
      absolute_to_greo(hijri_to_absolute(hijri.year, hijri.month, hijri.day))
    end
      
    def self.greo_to_hijri greg
      absolute_to_hijri(greo_to_absolute(greg.year, greg.month, greg.day))
    end
    
    module_function 
                    
    # Hijri Methods
    def islamic_leap_year?(year)
      return (((((11 * year) + 14) % 30) < 11) ? true : false)
    end
  
    def last_day_of_islamic_month(month, year)
      # Last day in month during year on the Islamic calendar.
      return ((month % 2 == 1) || (month == 12 && islamic_leap_year?(year)) ? 30 : 29)
    end
      
    def hijri_to_absolute(year, month, day)
      month_days = 29 * (month - 1) # days on this year
      nonleap_year_days  = 354 * (year - 1)
      leap_year_days = (3 + (11 * year)) / 30.0
      this_year  = (month / 2.0).to_i
      
      return (day + month_days + this_year + nonleap_year_days + leap_year_days + ISLAMIC_EPOCH).to_i
    end
      
    # Gregorian Methods
    def last_day_of_gregorian_month(month, year)
      # Compute the last date of the month for the Gregorian calendar.
      if month == 2
        return 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
      end
      return [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1]
    end
      
    # Absolute Methods
    def greo_to_absolute(year, month, day)
      # Computes the absolute date from the Gregorian date.
      @d = day
      @m = month - 1
      @m.downto(1) do |m|
        @d += last_day_of_gregorian_month(@m, year)
      end
      return (@d + 365 * (year - 1) + (year -1) / 4.0 - (year - 1) / 100.0 + (year - 1) / 400.0).to_i
    end
      
    def absolute_to_greo(abs)
      # Computes the Gregorian date from the absolute date.
      # Search forward year by year from approximate year
      puts abs
      year = (abs / 366.0 + 0.5).to_i
      while (abs >= greo_to_absolute(1, 1, year + 1))
        year += 1
      end
      # Search forward month by month from January
      month = 1
      while (abs > greo_to_absolute(last_day_of_gregorian_month(month, year), month, year))
        month += 1
      end
      day = abs - greo_to_absolute(1, month, year) + 1
      return [year, month, day]
    end
      
    def absolute_to_hijri(abs)
      # Computes the Islamic date from the absolute date.
      # puts "abs #{abs} and islamicEpoch #{IslamicEpoch}"
      if (abs <= ISLAMIC_EPOCH)
        # Date is pre-Islamic
        month = 0
        day = 0
        year = 0
      elsif
        # Search forward year by year from approximate year
        year = ((abs - ISLAMIC_EPOCH) / 355.0).to_i
        while (abs >= hijri_to_absolute(1,1,year+1))  
          year += 1
        end
        # Search forward month by month from Muharram
        month = 1
        while (abs > hijri_to_absolute(last_day_of_islamic_month(month,year), month, year))
          month += 1
        end
        day = abs - hijri_to_absolute(1, month, year) + 1
      end
      return [year, month, day]
    end
  end
end

# h = Hijri.new 1434, 9, 20
# puts Converter.hijri_to_greo(h)
  

