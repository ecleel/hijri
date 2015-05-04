# Hijri

[![Gem Version](https://badge.fury.io/rb/hijri.svg)](http://badge.fury.io/rb/hijri)
[![Build Status](https://travis-ci.org/ecleel/hijri.svg?branch=master)](https://travis-ci.org/ecleel/hijri)
[![Join the chat at https://gitter.im/ecleel/hijri](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ecleel/hijri?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

#####Hijri Date library for Ruby.
hijri is full lunar Islamic Hijri calendar lib for ruby.

##### Hijri Calendar (from Wikipedia)
The Islamic calendar or Muslim calendar or Hijri calendar: is a lunar calendar consisting of 12 lunar months in a year of 354 or 355 days. It is used to date events in many Muslim countries (concurrently with the Gregorian calendar), and used by Muslims everywhere to determine the proper day on which to celebrate Islamic holy days and festivals. The first year was the year during which the emigration of the Islamic prophet Muhammad from Mecca to Medina, known as the Hijra, occurred. Each numbered year is designated either H for Hijra or AH for the Latin anno Hegirae (in the year of the Hijra).[1] A limited number of years before Hijra (BH) are used to date events related to Islam, such as the birth of Muhammad in 53 BH.[2] The current Islamic year is 1431 AH, from approximately 18 December 2009 (evening) to 6 December 2010 (evening).

http://en.wikipedia.org/wiki/Islamic_calendar



## Installation

Add this line to your application's Gemfile:

    gem 'hijri'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hijri


## Usage

```ruby
require 'hijri'

# you can create hijri date from stdlib Date class.
h = Date.today.to_hijri # => #<Hijri::Date:0x007f875e8c84e8 @year=1436, @month=2, @day=16>

# or you can initialize new one.
hijri = Hijri::Date.new 1430, 1, 3 # => #<Hijri::Date:0x007f875e8dbb38 @year=1430, @month=1, @day=3>

# or you can get today hijri date directly.
today = Hijri::Date.today # => #<Hijri::Date:0x007f875e8d8410 @year=1436, @month=2, @day=16>

# and you can convert hijri date to greogian date also.
hijri.to_greo # => #<Date: 2009-01-01 ((2454833j,0s,0n),+0s,2299161j)>

# and there is DateTime too
date_and_time = Hijri::DateTime.now # => #<Hijri::DateTime:0x007f875e8eac00 @year=1436, @month=2, @day=16, @hour=14, @minute=14, @second=39, @zone="+03:00">

# hijri support strftime method with the same options as Greogian date format method
Hijri::DateTime.now.strftime('%c') # => "Ahad Rabia I 20 16:00:25 1436"
```

## Supported Ruby versions

This library aims to support and is [tested against](https://travis-ci.org/ecleel/hijri) the following Ruby
implementations:

* MRI 1.8.7
* MRI 1.9.2
* MRI 1.9.3
* MRI 2.0.0
* MRI 2.1.0
* MRI 2.2.0
* JRuby
* Rubinius

If something doesn't work on one of these Ruby versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be responsible for providing patches in a timely
fashion. If critical issues for a particular implementation exist at the time
of a major release, support for that Ruby version may be dropped.

## TODO

- [x] Add Hijri::Date and Hijri::DateTime.
- [x] Accept test error with one day range.
- [x] Add Hijri::DateTime.now to create Hijri::DateTime object.
- [x] Add Hijri::Date.today to create Hijri::Date object with today date.
- [x] Add Comparable for Hijri::Date.
- [x] Implement strftime method.
- [x] Add Hijri::Date.change method.
- [x] Raise ArgumentError when one of arguments has an invalid date value.
- [ ] Implement Hijri::Date.strptime method.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
