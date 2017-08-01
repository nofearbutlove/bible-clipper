
class BibleReader

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require "fileutils"
  require 'json'

  require_relative "BibleInfo.rb"

  def initialize

  end

    def get_chapter_from_web(translation_name, bible_shortname, chapter)
        translation_code = BibleInfo.translation_name_to_code[translation_name]
        bible_name = BibleInfo.bible_shortname_to_name[bible_shortname]
        bible_code = BibleInfo.bible_name_to_code[bible_name]
        bible_english_code = BibleInfo.bible_name_to_english_code[bible_name]

        hangul_translations = ['개역개정', '개역한글', '표준새번역', '새번역', '공동번역', '공동번역 개정판']
        if hangul_translations.include?(translation_name)#FALSE
            url = "http://bible.godpia.com/read/reading.asp?ver=#{translation_code}&ver2=&vol=#{bible_english_code}&chap=#{chapter}&sec="
            page = Nokogiri::HTML(open(url).read, nil)
            page.search('.//span[@class="num"]').remove
            chapter_content = page.css('.wide p').map { |node| node.text.strip }
        else
            # puts "영어"
            # Holybible
            # 개역개정 여호수아 22장 10절 문제 있음.

            # Bible Gateway
            # https://www.biblegateway.com/passage/?search=gen1&version=ESV
            # puts "hi"
            # puts "https://www.biblegateway.com/passage/?search=#{bible_english_code}#{chapter}&version=#{translation_code}"
            url = "http://www.holybible.or.kr/B_#{translation_code}/cgi/bibleftxt.php?VR=#{translation_code}&VL=#{bible_code}&CN=#{chapter}&CV=99"

            # Holybible!
            page = Nokogiri::HTML(open(url).read, nil, 'eucKR')
            chapter_content = page.css('table li').map { |node| node.text.strip }
        end
        if chapter_content.length == 0
            puts "Website is deactivated!"
            exit
        end

        chapter_content
    end

    def get_chapter(translation_name, bible_shortname, chapter)
        translation_code = BibleInfo.translation_name_to_code[translation_name]
        bible_name = BibleInfo.bible_shortname_to_name[bible_shortname]
        bible_code = BibleInfo.bible_name_to_code[bible_name]
        bible_english_code = BibleInfo.bible_name_to_english_code[bible_name]

        dir = File.dirname(__FILE__)
        db_name = "#{dir}/db/#{translation_name}/#{"%02d_" % bible_code}#{bible_name}"
        # puts db_name
        file_name = "#{db_name}/#{chapter}"

        buffer = File.open(file_name, 'r').read
        chapter_content = JSON.parse(buffer)
        chapter_content
    end
end
