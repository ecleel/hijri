module Hijri
  class Absolute
    attr_accessor :absolute

    def initialize abs
      self.absolute = abs
    end
    
    # def greo_to_hijri(date)
    #   hijri = absolute2islamic(gregorian2absolute(date.day, date.month, date.year))
    #   Hijri.new hijri[0], hijri[1], hijri[2]
    # end
    # 
    # def hijri_to_greo(date)
    #   greo = absolute2gregorian(islamic2absolute(date.day,date.month,date.year))
    #   Date.new greo[0], greo[1], greo[2]
    # end

    def gregorian2absolute(day, month, year)
    #   # Computes the absolute date from the Gregorian date.
      @d = day
       @m = month - 1
       @m.downto(1) do |m|
         @d += last_day_of_gregorian_month(@m, year)
       end
       return (@d + 365 * (year - 1) + (year -1) / 4.0 - (year - 1) / 100.0 + (year - 1) / 400.0).to_i
     end

    def to_greo
      # Computes the Gregorian date from the absolute date.
      # Search forward year by year from approximate year
      puts self.absolute
      year = (self.absolute / 366.0 + 0.5).to_i
      while (self.absolute >= gregorian2absolute(1, 1, year + 1))
        year += 1
      end
      # Search forward month by month from January
      month = 1
      while (self.absolute > gregorian2absolute(last_day_of_gregorian_month(month, year), month, year))
        month += 1
      end
      day = self.absolute - gregorian2absolute(1, month, year) + 1
      return [year, month, day]
    end

    # TODO 
    def to_hijri
      # Computes the Islamic date from the absolute date.
      # puts "abs #{abs} and islamicEpoch #{IslamicEpoch}"
      if (absolute <= Hijri::ISLAMIC_EPOCH)
        # Date is pre-Islamic
        month = 0
        day = 0
        year = 0
      elsif
        # Search forward year by year from approximate year
        year = ((absolute - Hijri::ISLAMIC_EPOCH) / 355.0).to_i
        while (absolute >= islamic2absolute(1,1,year+1))  
          year += 1
        end
          # Search forward month by month from Muharram
        month = 1
        while (absolute > islamic2absolute(last_day_of_islamic_month(month,year), month, year))
          month += 1
        end
        day = absolute - islamic2absolute(1, month, year) + 1
      end
      return [year, month, day]
    end

  end
end