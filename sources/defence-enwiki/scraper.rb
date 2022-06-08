#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  # decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def holder_entries
    noko.xpath("//table[.//td[contains(.,'Term')]][last()]//tr[td]")
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[_ name start end].freeze
    end

    def empty?
      (tds.count < 4) || super
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
