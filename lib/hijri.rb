require "Date"

module Hijri
  IslamicEpoch = 227014
  
  def self.last_day_of_gregorian_month(month, year)
    # Compute the last date of the month for the Gregorian calendar.
    if month == 2
      return 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    end
    return [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1]
  end

  def self.gregorian2absolute(day, month, year)
    # Computes the absolute date from the Gregorian date.
    @d = day
    month.downto(1) do |m|
      @d += last_day_of_gregorian_month(m, year)
    end
    return (@d + 365 * (year - 1) + (year -1) / 4 - (year - 1) / 100 + (year - 1) / 400).to_i
  end

  def self.absolute2gregorian(abs)
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
  
  def self.islamic_leap_year(year)
   # True if year is an Islamic leap year
   return (((((11 * year) + 14) % 30) < 11) ? 1 : 0)
  end
  
  def self.last_day_of_islamic_month(month, year)
    # Last day in month during year on the Islamic calendar.
    return ((month % 2 == 1) || (month == 12 && islamic_leap_year(year)) ? 30 : 29)
  end
  
  def self.islamic2absolute(day, month, year)
    # Computes the absolute date from the Islamic date.
    return (day + 29 * (month - 1) + (month /2).to_i + 354 * (year - 1) + (3 + (11 * year)) / 30 + IslamicEpoch).to_i
    # return (day                      # days so far this month
    #        + 29 * (month - 1)       # days so far...
    #        + (month /2).to_i          # ...this year
    #        + 354 * (year - 1)       # non-leap days in prior years
    #        + (3 + (11 * year)) / 30 # leap days in prior years
    #        + IslamicEpoch).to_i          # days before start of calendar
  end
  
  def self.absolute2islamic(abs)
      # Computes the Islamic date from the absolute date.
      puts "abs #{abs} and islamicEpoch #{IslamicEpoch}"
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
          day = abs - islamic2absolute(1, month, year) + 1
        end
      end
      return [day, month, year]
  end
end
