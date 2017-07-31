#!/usr/bin/ruby
require "fileutils"
require 'json'
require_relative "BibleReader.rb"

reader = BibleReader.new

translation_names = ['개역개정', '새번역', 'NIV']#BibleInfo.translation_name_to_code.keys
translation_names.each do |translation_name|
  translation_code = BibleInfo.translation_name_to_code[translation_name]
  BibleInfo.bible_name_to_chapter_len.each do |bible_name, chapter_len|
    # puts "#{translation_name}, #{bible_name}, #{chapter_len}"
    bible_shortname = BibleInfo.bible_name_to_shortname[bible_name]
    db_name = "db/#{translation_name}/#{"%02d_" % BibleInfo.bible_name_to_code[bible_name]}#{bible_name}"
    unless Dir.exist? db_name
      FileUtils.mkdir_p(db_name)
    end

    (1..chapter_len).each do |chapter|
      file = File.open "#{db_name}/#{chapter}", 'w'
      chapter_content = reader.get_chapter_from_web(translation_name, bible_shortname, chapter)
      file.write(chapter_content.to_json)
      file.close()
    end
  end
end
