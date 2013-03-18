#encoding: utf-8

class BibleClipper
  require_relative "BibleShortcutHandler.rb"
  require_relative "BibleReader.rb"
  require_relative "BibleInfo.rb"

  def initialize
    @bible_info = BibleInfo.new
    @bible_shortnames = @bible_info.bible_shortname_to_name.keys
    @reader = BibleReader.new
    @sh = BibleShortcutHandler.new @bible_shortnames
    @primary_translation = '개역개정'
    @secondary_translation = 'NIV'
  end


  def get_decorated_content(translation)
    contents = []
    (@sh.start_chapter..@sh.end_chapter).each do |chapter|
      # puts chapter
      content = @reader.get_chapter(translation, @sh.bible_shortname, chapter)
      if chapter == @sh.end_chapter and not @sh.end_line.nil?
        content = content.take(@sh.end_line)
      end

      line = 1
      if chapter == @sh.start_chapter
        line = @sh.start_line
        content = content.drop(@sh.start_line-1)

      end
      content.each do |l|
        l.insert 0, "#{line}. "
        line += 1
      end

      content[0].insert 0, (@sh.bible_shortname + chapter.to_s+':')

      content.each do |l|
        l.insert 0, "> "
      end
      #Decorate content here.
      contents.concat(content)
    end
    contents
  end

  def clip(shortcut)
    if @sh.valid? shortcut
      # puts @sh
      primary_contents = get_decorated_content(@primary_translation)
      # puts primary_contents.join "\n"
      secondary_contents = get_decorated_content(@secondary_translation)
      contents = ''
      (1..primary_contents.length).each do |i|
        contents << primary_contents[i-1] << "\n"
        contents << secondary_contents[i-1] << "\n"
      end
      contents
    else
      puts 'shortcut is not valid'
    end
  end
end


# reader = BibleReader.new
# puts reader.get_chapter('개역개정', '창', 1)
# while 1
#   shortcut = gets.chomp
#   puts shortcut
#   # puts bible_clipper.clip(shortcut)  
# end

