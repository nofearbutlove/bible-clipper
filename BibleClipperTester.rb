#encoding: utf-8

require_relative "BibleClipper.rb"
ENV['LANG'] = 'ko_KR.UTF-8'
bible_clipper = BibleClipper.new
str =  bible_clipper.clip('창1:1')  
puts str
IO.popen('pbcopy', 'w') { |f| f << str }
