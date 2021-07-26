#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

s = ARGV[0]
v = ARGV[1] || "stretch"
arch = ARGV[2] || "armhf"
base_url = 'https://packages.debian.org'
url = "#{base_url}/#{v}/#{s}"
doc = Nokogiri::HTML(URI.open(url))
doc.css("#pdownload th a").each do |e|
    sn = e.content
    if sn == arch
        link = e['href']
        puts "#{base_url}#{link}"
    end
end