#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

if ARGV.length == 0 || ARGV[0] == "-h" || ARGV[0] == "--help"
    puts "usage: deb-dl.rb libglib2.0-0 [jp] [armhf] [stretch]"
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

dl_url = ""

if arch == "_"
    doc.css(".cardleft a, .cardright a").each do |e|
        _s = e.content
        link = e['href']
        _url = "#{link}"
        # puts "#{_s}: #{_url}"
        puts "#{_url}"
    end

    exit
else
    doc.css(".cardleft a, .cardright a").each do |e|
        _s = e.content
        link = e['href']
        _url = "#{link}"
        if _s =~ /#{region}/
            dl_url = _url
            # puts "#{_url}"
            break
        end
    end
end

if dl_url.nil? || dl_url.strip == ''
    STDERR.puts "mirror #{region} not found. trying other."

    dl_url = doc.css("#content a").map{|e|
        _s = e.content
        e['href']
    }.filter{|u| u =~ /debian/ }.first

    if dl_url.nil? || dl_url.strip == ''
        STDERR.puts "mirror not found. exits."
        exit 1
    end
end

#puts "#{dl_url}"

#puts Dir.pwd
_uri = URI.parse(dl_url)
filename = File.basename(_uri.path)
path = "#{Dir.pwd}/#{filename}"
#puts path

URI.open(dl_url) do |c|
    open(path, "w+b") do |out|
      out.write(c.read)
    end
end


puts "Downloaded: #{dl_url}"