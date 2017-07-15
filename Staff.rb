#encoding: utf-8
class Object
  def print_error_str
    false
  end
end

class Staff
  require_relative "BibleClipper.rb"
  require "clipboard"

  def initialize
    ENV['LANG'] = 'ko_KR.UTF-8'
    @bible_clipper = BibleClipper.new
    @bible_clipper.verse_class.set_prefix('> ')
    @bible_clipper.verse_class.set_verse_text_delimiter(' ')
  end


  def fetch(text)
    result = Array.new
    #puts text
    #puts text.split(',').length
    text.split(',').each do |t|
      #puts "each text: #{t}"
      str = @bible_clipper.clip(t)
      #puts str
      if str
        result << str
      end
    end
    if result.length > 0
      result = result.join "\n"
      result += "\n"
      # IO.popen('pbcopy', 'w') { |f| f << result }
      Clipboard.copy(result)
      # puts result
      result
    else
      nil
    end
  end

  def search(text)
    # p sender
    search_text = text
    modified_text = search_text.downcase
    modified_text.gsub!(/\s+/, '')
    # modified_text.gsub!(/(참고|참조)/, '')
    # modified_text =~ s/\s+//g;
    # modified_text =~ s/참고//g;
    # modified_text =~ s/참조//g;
    if modified_text.length > 0
      str = fetch(modified_text)
    end
    # scrollView.setStringValue(@search_text)
  end
end

staff = Staff.new


# ARGV
if ARGV.empty?
  puts <<EOS
  Staff V1.0.0은 성경 범위를 받아서 본문을 clipboard에 copy해 드리는 어플입니다.

  '행1:16' 과 같이 원하시는 말씀을 입력하시고,
  한번 입력하신 후에는 '1-2'와 같이 절 범위만 기록하셔도 '말씀'과 '장' 정보를 기억하고 동작합니다.
  쉼표로 여러개의 범위를 입력해 주시면 각 본문이 빈 줄로 구별되어서 clipboard에 복사됩니다.
  닫으시려면 'exit' 또는 'x'라고 입력해 주세요.

  문의사항은 jmyl@me.com 으로 부탁드립니다.
  * 주의: 이 어플은 인터넷에 연결되어 있어야 동작합니다.
EOS

else
  staff = Staff.new
  
  text = ARGV.join(",")
  #puts text
  str = staff.search(text.downcase)
  if str
    puts "성공! 클립보드를 확인하세요(CMD/ctrl+'v')."
  else
    puts '입력하신 스트링이 이상합니다. 범위를 다시 확인해 주세요.'
  end
end
