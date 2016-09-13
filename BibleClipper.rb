#encoding: utf-8

class BibleClipper
  require_relative "BibleShortcutHandler.rb"
  require_relative "BibleReader.rb"
  require_relative "BibleInfo.rb"
  require_relative "Verse.rb"

  def initialize
    @bible_info = BibleInfo.new
    @reader = BibleReader.new
    @sh = BibleShortcutHandler.new
    @translations = ['개역개정', 'NIV']
  end

  def clip(shortcut)
    is_valid = @sh.valid?(shortcut)
    if print_error_str
      puts is_valid
      puts @sh
    end
    
    if is_valid == :SUCCEEDED
      # puts @sh
      contents = Hash.new
      @translations.each do |translation|
        contents[translation] = get_contents(translation)
      end

      text = ''
      is_first_line = true
      past_chapter = -1
      verse_length = contents[@translations[0]].length
      (0...verse_length).each do |i|
        @translations.each do |translation|
          verse = contents[translation][i]
          text << verse.to_s(is_first_line, past_chapter != verse.chapter) << "\n"
          past_chapter = verse.chapter
          if is_first_line
            is_first_line = false
          end
        end
      end
      text = nil if text.length == 0
      text
      #text.concat
    else
      nil
    end
  end

  def verse_class
    Verse
  end

  def clear_history
    @sh.clear_history
  end

  private
  def get_contents(translation)
    contents = Array.new
    (@sh.start_chapter..@sh.end_chapter).each do |chapter|
      # puts chapter
      content = @reader.get_chapter(translation, @sh.bible_shortname, chapter)
      if chapter == @sh.end_chapter and @sh.end_verse
        content = content.take(@sh.end_verse)
      end

      verse = 1
      if chapter == @sh.start_chapter
        verse = @sh.start_verse
        content = content.drop(@sh.start_verse-1)
      end

      content.each do |line|
        contents << Verse.new(@sh.bible_shortname, chapter, verse, line)
        verse += 1
      end
      
    end
    contents
  end
end


# reader = BibleReader.new
# puts reader.get_chapter('개역개정', '창', 1)
# while 1
#   shortcut = gets.chomp
#   puts shortcut
#   # puts bible_clipper.clip(shortcut)  
# end

