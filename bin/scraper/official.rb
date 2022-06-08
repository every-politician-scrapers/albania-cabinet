#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('h3').first.text.tidy
    end

    def position
      noko.css('h3').last.text.split(/(?:and (?=Minister))/).map(&:tidy)
    end
  end

  class Members
    def member_container
      noko.css('.body-content .grid-item')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
