module Hijri
  class DateTime < Date

    attr_reader :hour, :minute, :second, :offset, :zone

    alias :min :minute
    alias :sec :second

    def initialize(year=1, month=1, day=1, hour=0, minute=0, second=0, zone="00:00")
      super(year, month, day)
      if valid_time?(hour, minute, second, zone)
        @hour   = hour
        @minute = minute
        @second = second
        @offset = zone.to_f / 24
        @zone   = zone
      else
        raise ArgumentError, "Invalid Date"        
      end
    end

    def change(kargs)
      super(kargs)
      @hour   = kargs.fetch :hour, hour
      @minute = kargs.fetch :minute, minute
      @second = kargs.fetch :second, second
      @zone   = kargs.fetch :zone, zone
    end

    def to_greo
      ::DateTime.new *Converter.hijri_to_greo(self)
    end

    def to_s
      zone_str = (@zone == '00:00' ? "+#{@zone}" : @zone)
      format('%.4d-%02d-%02dT%02d:%02d:%02d%s',
             year, mon, mday, hour, min, sec, zone_str)
    end

    def valid_time?(hour, minute, second, zone)
      return false unless (0..23).cover?(hour)
      return false unless (0..59).cover?(minute)
      return false unless (0..59).cover?(second)
      return true
    end

    class << self
      def now
        datetime = ::DateTime.now
        hijri = datetime.to_hijri
        hijri.change :hour => datetime.hour, :minute => datetime.minute, :second => datetime.second
        hijri
      end
    end

  end

end