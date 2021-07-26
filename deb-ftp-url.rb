#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

if ARGV.length == 0 || ARGV[0] == "-h" || ARGV[0] == "--help"
    puts "usage: deb-ftp-url.rb libglib2.0-0 [jp] [armhf] [stretch]"
    exit
end

s = ARGV[0]
region = ARGV[1] || "jp"
arch = ARGV[2] || "armhf"
v = ARGV[3] || "stretch"
base_url = 'https://packages.debian.org'
url = "#{base_url}/#{v}/#{s}"
doc = Nokogiri::HTML(URI.open(url))

dl_url = nil
doc.css("#pdownload th a").each do |e|
    sn = e.content
    if sn == arch
        link = e['href']
        dl_url = "#{base_url}#{link}"
    end
end

if dl_url.nil?
    STDERR.puts "url not found"
    exit 1
end

doc = Nokogiri::HTML(URI.open(dl_url))

if arch == "_"
    doc.css(".cardleft a, .cardright a").each do |e|
        _s = e.content
        link = e['href']
        _url = "#{link}"
        # puts "#{_s}: #{_url}"
        puts "#{_url}"
    end
else
    doc.css(".cardleft a, .cardright a").each do |e|
        _s = e.content
        link = e['href']
        _url = "#{link}"
        if _s =~ /#{region}/
            puts "#{_url}"
        end
    end
end