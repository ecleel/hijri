class Date
  def to_hijri
    Hijri::Date.new *Hijri::Converter.greo_to_hijri(self)
  end

  def last_day_of_gregorian_month(month)
    # Compute the last date of the month for the Gregorian calendar.
    if month == 2
      return 29 if (self.year % 4 == 0 && self.year % 100 != 0) || (self.year % 400 == 0)
    end
    return [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1]
  end

  def to_abs
    @d = self.day
    @m = self.month - 1
    @m.downto(1) do |m|
      @d += last_day_of_gregorian_month(@m, year)
    end
    return (@d + 365 * (year - 1) + (year -1) / 4.0 - (year - 1) / 100.0 + (year - 1) / 400.0).to_i
  end
end

class DateTime
  def to_hijri
    Hijri::DateTime.new *Hijri::Converter.greo_to_hijri(self)
  end

  if RUBY_VERSION < '1.8.8'
    alias :minute :min
    alias :second :sec
  end

end
