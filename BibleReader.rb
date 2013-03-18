#!/usr/bin/env ruby -wKU
class BibleReader
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require_relative "BibleInfo.rb"

  def initialize
    @bibleinfo = BibleInfo.new()
  end
  def get_chapter(translation_name, bible_shortname, chapter)
    translation_code = @bibleinfo.translation_name_to_code[translation_name]
    bible_name = @bibleinfo.bible_shortname_to_name[bible_shortname]
    bible_code = @bibleinfo.bible_name_to_code[bible_name]

    url = "http://www.holybible.or.kr/B_#{translation_code}/cgi/bibleftxt.php?VR=#{translation_code}&VL=#{bible_code}&CN=#{chapter}&CV=99"
    # puts url

    page = Nokogiri::HTML(open(url).read.encode('utf-8', 'cp949'))
    # page = Nokogiri::HTML(open(url).read.encode('utf-8', 'EUC-KR'))
    # page = Nokogiri::HTML(open(url).read, nil, 'eucKR')

    page.css('table li').map { |node| node.text.strip }
  end
end
