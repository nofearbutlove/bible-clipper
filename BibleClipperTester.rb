#encoding: utf-8

require_relative "BibleClipper.rb"
ENV['LANG'] = 'ko_KR.UTF-8'
bible_clipper = BibleClipper.new
bible_clipper.verse_class.set_prefix('> ')
bible_clipper.verse_class.set_verse_text_delimiter(' ')

puts "Retreaving..."
str =  bible_clipper.clip('레24:8-9')

puts "Succeeded!"
#puts str
IO.popen('pbcopy', 'w') { |f| f << str }

