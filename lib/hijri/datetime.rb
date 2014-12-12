module Hijri
  class DateTime < Date
    
    attr_reader :hour, :minute, :second, :zone
    def initialize(year=1, month=1, day=1, hour=0, minute=0, second=0, zone="00:00")
      super(year, month, day)
      @hour   = hour
      @minute = minute
      @second = second
      @zone   = zone
    end
    
    def change(kargs)
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
      "#{super}T#{sprintf('%02d', @hour)}:#{sprintf('%02d', @minute)}:#{sprintf('%02d', @second)}#{zone_str}"
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