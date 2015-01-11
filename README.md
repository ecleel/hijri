# Hijri

[![Gem Version](https://badge.fury.io/rb/hijri.svg)](http://badge.fury.io/rb/hijri)
[![Build Status](https://travis-ci.org/ecleel/hijri.svg?branch=master)](https://travis-ci.org/ecleel/hijri)

#####Hijri Date library for Ruby.
hijri is full Islamic Hijri calendar lib for ruby. The way it work is to convert Gregorian date to absolute date then convert it to Hijri date.
### Hijri Calendar (from Wikipedia)
The Islamic calendar or Muslim calendar or Hijri calendar: is a lunar calendar consisting of 12 lunar months in a year of 354 or 355 days. It is used to date events in many Muslim countries (concurrently with the Gregorian calendar), and used by Muslims everywhere to determine the proper day on which to celebrate Islamic holy days and festivals. The first year was the year during which the emigration of the Islamic prophet Muhammad from Mecca to Medina, known as the Hijra, occurred. Each numbered year is designated either H for Hijra or AH for the Latin anno Hegirae (in the year of the Hijra).[1] A limited number of years before Hijra (BH) are used to date events related to Islam, such as the birth of Muhammad in 53 BH.[2] The current Islamic year is 1431 AH, from approximately 18 December 2009 (evening) to 6 December 2010 (evening).

http://en.wikipedia.org/wiki/Islamic_calendar



## Installation

Add this line to your application's Gemfile:

    gem 'hijri'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hijri

###hijri tested and worked in:
- Ruby MRI:
  - 1.8.7
  - 1.9.2
  - 1.9.3
  - 2.0.0
  - 2.1
  - 2.2
- JRuby 1.7.16.1
  - jruby-18mode
  - jruby-19mode
- Rubinius 2.4.1

## Usage

```ruby
require 'hijri'

# you can create hijri date from stdlib Date class.
h = Date.today.to_hijri # => #<Hijri::Date:0x007f875e8c84e8 @year=1436, @month=2, @day=16>

# or you can initialize new one.
hijri = Hijri::Date.new 1430, 1, 3 # => #<Hijri::Date:0x007f875e8dbb38 @year=1430, @month=1, @day=3>

# or you get today hijri date directly.
toady = Hijri::Date.today # => #<Hijri::Date:0x007f875e8d8410 @year=1436, @month=2, @day=16>

# and you can convert hijri date to greogian date.
hijri.to_greo # => #<Date: 2009-01-01 ((2454833j,0s,0n),+0s,2299161j)>

# and there is DateTime too
date_and_time = Hijri::DateTime.now # => #<Hijri::DateTime:0x007f875e8eac00 @year=1436, @month=2, @day=16, @hour=14, @minute=14, @second=39, @zone="+03:00">

# hijri support strftime method with the same option as Greogian date format
Hijri::DateTime.now.strftime('%c') # => "Ahad Rabia I 20 16:00:25 1436"
```


## TODO

- [x] Add Hijri::Date and Hijri::DateTime.
- [x] Accept test error with one day range.
- [x] Add Hijri::DateTime.now to create Hijri::DateTime object.
- [x] Add Hijri::Date.today to create Hijri::Date object with today date.
- [x] Add Comparable for Hijri::Date.
- [x] Implement strftime method.
- [ ] Add Hijri::Date.change method.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
