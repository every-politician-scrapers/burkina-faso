#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Members
    decorator RemoveReferences
    decorator UnspanAllTables
    decorator WikidataIdsDecorator::Links

    def member_container
      noko.xpath("//h3[.//span[contains(.,'Ministères')]]//following-sibling::ul[1]//li")
    end
  end

  class Member
    field :id do
      noko.css('a').last.attr('wikidata')
    end

    field :name do
      noko.css('a').last.text.tidy
    end

    field :positionID do
    end

    field :position do
      noko.text.split(':').first.tidy
    end

    field :startDate do
      '2021-01-10'
    end

    field :endDate do
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url).csv
