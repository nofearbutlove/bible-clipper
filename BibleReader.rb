
class BibleReader
  
  require 'rubygems'    
  require 'nokogiri'
  require 'open-uri'
  require "fileutils"
  require 'json'

  require_relative "BibleInfo.rb"

  def initialize

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
    
    unless File.exist? file_name
      unless Dir.exist? db_name
        FileUtils.mkdir_p(db_name)
      end

      hangul_translations = ['개역개정', '개역한글', '표준새번역', '새번역', '공동번역', '공동번역 개정판']
      if hangul_translations.include?(translation_name)#FALSE
        # puts "한글"
        # 대한성서공회
        url = "http://www.bskorea.or.kr/infobank/korSearch/korbibReadpage.aspx?version=#{translation_code}&book=#{bible_english_code}&chap=#{chapter}"
        # puts open(url).read.gsub(/<BR><SPAN>/, '<BR></SPAN><SPAN>')
        page = Nokogiri::HTML(open(url).read.gsub(/<BR><SPAN>/, '<BR></SPAN><SPAN>'), nil)
        # puts page
        # puts page.css('#tdBible1 span').map { |node| node.text.strip }
        page.search('.//div').remove
        page.search('.//a[@class="comment"]').remove
        page.search('.//font[@class="number"]').remove
        page.search('.//font[@class="smallTitle"]').remove
        
        # puts page.xpath('//td[@id="tdBible1"]')
        
        # puts page.css('#tdBible1 span').map { |node| node.text.strip }
        # page.xpath('//td[@id="tdBible1"]/span').each do |a|
        #   puts a.content
        # end
        
        # page.css('table li').map { |node| node.text.strip }
        page.css('#tdBible1 span').map { |node| node.text.strip }
      else
        # puts "영어"
        # Holybible
        # 개역개정 여호수아 22장 10절 문제 있음.
        
        # Bible Gateway
        # https://www.biblegateway.com/passage/?search=gen1&version=NIV
        url = "http://www.holybible.or.kr/B_#{translation_code}/cgi/bibleftxt.php?VR=#{translation_code}&VL=#{bible_code}&CN=#{chapter}&CV=99"

        # Holybible!
        page = Nokogiri::HTML(open(url).read, nil, 'eucKR')
        chapter_content = page.css('table li').map { |node| node.text.strip }
      end
      File.open(file_name, 'w').write(chapter_content.to_json)
    else
      buffer = File.open(file_name, 'r').read
      chapter_content = JSON.parse(buffer)
    end
    chapter_content
  end
end
