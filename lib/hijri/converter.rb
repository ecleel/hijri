module Hijri
  module Converter
    def self.hijri_to_greo hijri
      results = absolute_to_greo(hijri_to_absolute(hijri.year, hijri.month, hijri.day))
      if hijri.is_a? DateTime
        results.push hijri.hour, hijri.minute, hijri.second, hijri.zone
      end
      results
    end
      
    def self.greo_to_hijri greg
      results = absolute_to_hijri(greo_to_absolute(greg.year, greg.month, greg.day))
      if greg.is_a? ::DateTime
        results.push greg.hour, greg.minute, greg.second, greg.zone
      end
      results
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
      d = day
      (month - 1).downto(1) do |m|
        d += last_day_of_gregorian_month(m, year)
      end

      return (d +                      # days this year
              365 * (year - 1) +       # days in previous years ignoring leap days
              (year - 1) / 4.0 -       # Julian leap days before this year...
              (year - 1) / 100.0 +     # ...minus prior century years...
              (year - 1) / 400.0       # ...plus prior years divisible by 400
              ).to_i
    end

    def absolute_to_greo(abs)
      # Computes the Gregorian date from the absolute date.
      # Search forward year by year from approximate year
      year = (abs / 366.0 + 0.5).to_i
      while abs >= greo_to_absolute(year + 1, 1, 1)
        year += 1
      end
      # Search forward month by month from January
      month = 1
      while abs > greo_to_absolute(year, month, last_day_of_gregorian_month(month, year))
        month += 1
      end
      day = abs - greo_to_absolute(year, month, 1) + 1

      return [year, month, day]
    end
      
    def absolute_to_hijri(abs)
      # Computes the Islamic date from the absolute date.
      if abs <= ISLAMIC_EPOCH
        # Date is pre-Islamic
        month = 0
        day = 0
        year = 0
      elsif

        # Search forward year by year from approximate year
        year = ((abs - ISLAMIC_EPOCH) / 355.0).to_i
        while abs >= hijri_to_absolute(year+1, 1, 1)
          year += 1
        end

        # Search forward month by month from Muharram
        month = 1
        while abs > hijri_to_absolute(year, month, last_day_of_islamic_month(month, year))
          month += 1
        end

        day = abs - hijri_to_absolute(year, month, 1) + 1
      end

      return [year, month, day]
    end
  end
end
