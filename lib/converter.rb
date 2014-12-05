require "Date"

class Hijri
  module Converter
    IslamicEpoch = 227014
  
    def last_day_of_gregorian_month(month, year)
      # Compute the last date of the month for the Gregorian calendar.
      if month == 2
        return 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
      end
      return [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1]
    end

    def gregorian2absolute(day, month, year)
      # Computes the absolute date from the Gregorian date.
      @d = day
      @m = month - 1
      @m.downto(1) do |m|
        @d += last_day_of_gregorian_month(@m, year)
      end
      return (@d + 365 * (year - 1) + (year -1) / 4 - (year - 1) / 100 + (year - 1) / 400).to_i
    end

    def absolute2gregorian(abs)
      # Computes the Gregorian date from the absolute date.
      # Search forward year by year from approximate year
      year = (abs / 366 + 0.5).to_i
      while (abs >= gregorian2absolute(1, 1, year + 1))
        year += 1
      end
      # Search forward month by month from January
      month = 1
      while (abs > gregorian2absolute(last_day_of_gregorian_month(month, year), month, year))
        month += 1
      end
      day = abs - gregorian2absolute(1, month, year) + 1
      return [day, month, year]
    end
  
    def islamic_leap_year(year)
     # True if year is an Islamic leap year
     return (((((11 * year) + 14) % 30) < 11) ? 1 : 0)
    end
  
    def last_day_of_islamic_month(month, year)
      # Last day in month during year on the Islamic calendar.
      return ((month % 2 == 1) || (month == 12 && islamic_leap_year(year)) ? 30 : 29)
    end
  
    def islamic2absolute(day, month, year)
      # Computes the absolute date from the Islamic date.
      return (day + 29 * (month - 1) + (month /2).to_i + 354 * (year - 1) + (3 + (11 * year)) / 30 + IslamicEpoch).to_i
      # return (day                      # days so far this month
      #        + 29 * (month - 1)       # days so far...
      #        + (month /2).to_i          # ...this year
      #        + 354 * (year - 1)       # non-leap days in prior years
      #        + (3 + (11 * year)) / 30 # leap days in prior years
      #        + IslamicEpoch).to_i          # days before start of calendar
    end
  
    def absolute2islamic(abs)
        # Computes the Islamic date from the absolute date.
        # puts "abs #{abs} and islamicEpoch #{IslamicEpoch}"
        if (abs <= IslamicEpoch)
          # Date is pre-Islamic
          month = 0
          day = 0
          year = 0
        elsif
          # Search forward year by year from approximate year
          year = ((abs - IslamicEpoch) / 355).to_i
          while (abs >= islamic2absolute(1,1,year+1))  
            year += 1
          end
            # Search forward month by month from Muharram
          month = 1
          while (abs > islamic2absolute(last_day_of_islamic_month(month,year), month, year))
            month += 1
          end
          day = abs - islamic2absolute(1, month, year)+ 1
        end
        return [day, month, year]
    end
  
    # alias :a2g :absolute2gregorian 
    # alias :gregorian2absolute :g2a
    # alias :islamic2absolute :h2a
    # alias :absolute2islamic :a2h
  end
end

# puts Hijri.absolute2islamic(Hijri.islamic2absolute(15,2,1431))
# tt, eq, nq = 0, 0, 0
# (1..12).each do |m|
#   (1..30).each do |d|
#     date = "#{d}#{m}2010"
#     date_converted = Hijri.absolute2gregorian(Hijri.gregorian2absolute(d, m, 2010)).join
#     if date == date_converted
#       message = "#{date} == #{date_converted}"
#       eq += 1
#     else
#       message = "#{date} != #{date_converted}"
#       nq += 1
#     end
#     puts message
#     tt += 1
#   end
# end
# 
# puts "total #{tt} equals #{eq} not equals #{nq}"
