#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
     raw_name.gsub(/(Monsieur|Madame) /, '')
    end

    field :position do
      noko.css('h3').first.text.tidy.gsub(/^\d+\.*\s*/, '')
    end

    field :gender do
      return 'male'   if raw_name.include? 'Monsieur'
      return 'female' if raw_name.include? 'Madame'
    end

    private

    def raw_name
      noko.css('h3').last.text.tidy.gsub(/^>\s*/, '')
    end
  end

  class Members
    def member_container
      noko.css('.wf-container-main ul li.icon_list_item')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
