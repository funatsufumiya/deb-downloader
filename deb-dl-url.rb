#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

if ARGV.length == 0 || ARGV[0] == "-h" || ARGV[0] == "--help"
    puts "usage: deb-dl-url.rb libglib2.0-0 [armhf] [stretch]"
    exit
end

s = ARGV[0]
arch = ARGV[1] || "armhf"
v = ARGV[2] || "stretch"
base_url = 'https://packages.debian.org'
url = "#{base_url}/#{v}/#{s}"
doc = Nokogiri::HTML(URI.open(url))
if arch == "_"
    doc.css("#pdownload th a").each do |e|
        sn = e.content
        link = e['href']
        puts "#{base_url}#{link}"
    end
else
    doc.css("#pdownload th a").each do |e|
        sn = e.content
        if sn == arch
            link = e['href']
            puts "#{base_url}#{link}"
        end
    end
end