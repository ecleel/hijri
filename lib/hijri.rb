require 'date'

module Hijri
  ISLAMIC_EPOCH = 227014
  AVERAGE_YEARS_DAYS = 354.367056
  AVERAGE_MONTH_DAYS = 29.530588
  
  INFINITY = +1.0/0.0
end

require 'hijri/version'
require 'hijri/date'
require 'hijri/datetime'
require 'hijri/gregorian'
require 'hijri/converter'
require 'hijri/format'
