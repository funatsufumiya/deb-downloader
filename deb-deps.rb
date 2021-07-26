#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

if ARGV.length == 0 || ARGV[0] == "-h" || ARGV[0] == "--help"
    puts "usage: deb-deps.rb libglib2.0-0 [stretch]"
    exit
end

s = ARGV[0]
v = ARGV[1] || "stretch"
base_url = 'https://packages.debian.org'
url = "#{base_url}/#{v}/#{s}"
doc = Nokogiri::HTML(URI.open(url))

list = doc.css("#pdeps span.nonvisual + a").map do |e|
    ed = e.parent.css("span.nonvisual").last
    if !ed.nil? && ed.text == "dep:"
        e.content
    else
        nil
    end
end

#p list
list = list.filter{ |x| !x.nil? }.uniq

list.each do |e|
    puts e
end