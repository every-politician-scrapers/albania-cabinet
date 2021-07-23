#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  # details for an individual member
  class Member < Scraped::HTML
    field :name do
      noko.css('span a').text.tidy
    end

    field :position do
      noko.css('span').last.text.tidy
    end
  end

  # The page listing all the members
  class Members < Scraped::HTML
    field :members do
      member_container.map { |member| fragment(member => Member).to_h }
    end

    private

    def member_container
      noko.css('.container .sm-2')
    end
  end
end

url = 'https://kryeministria.al/en/'
puts EveryPoliticianScraper::ScraperData.new(url).csv
