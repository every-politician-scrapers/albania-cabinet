#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('span a').text.tidy
    end

    def position
      noko.css('span').last.text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.container .sm-2')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
