#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

if ARGV.length == 0 || ARGV[0] == "-h" || ARGV[0] == "--help"
    puts "usage: deb-search.rb libglib2.0-0"
    exit
end

s = ARGV[0]
url = "https://packages.debian.org/search?keywords=#{s}"
doc = Nokogiri::HTML(URI.open(url))
doc.css("h3").each do |e|
    sn = e.content
    sn.gsub!(/^Package /, '')
    puts sn
end