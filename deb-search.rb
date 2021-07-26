#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

s = ARGV[0]
url = "https://packages.debian.org/search?keywords=#{s}"
doc = Nokogiri::HTML(URI.open(url))
doc.css("h3").each do |e|
    sn = e.content
    sn.gsub!(/^Package /, '')
    puts sn
end