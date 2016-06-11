#encoding: utf-8

class BibleShortcutHandler
  require_relative "BibleInfo.rb"

  attr_reader :bible_shortname
  attr_reader :start_chapter
  attr_reader :start_verse
  attr_reader :end_chapter
  attr_reader :end_verse

  def initialize
    @bible_shortname = nil
    @start_chapter = nil
    @start_verse = nil
    @end_chapter = nil
    @end_verse = nil
  end

  def to_s
    end_verse = @end_verse
    if end_verse.nil?
      end_verse = 'end'
    end
    "#{@bible_shortname}#{@start_chapter}:#{@start_verse}-#{@end_chapter}:#{end_verse}"
  end

  def clear_history
    @bible_shortname = nil
    @start_chapter = nil
  end

  def get_chapter_and_verse(str)
    if str =~ /^(\d+):(\d+)$/
      yield($1.to_i, $2.to_i)
      return true
    elsif str =~ /^(\d+)$/
      yield(@start_chapter, $1.to_i)
      return true
    else
      return false
    end
  end

  def valid?(shortcut)
    shortcut.encode! 'UTF-8'
    shortcut.gsub! /\s+/, ''
    # book_match_str = '
    # ^
    #       (?<book>\D+)                    
    #       (?:
    #         (?<sc>\d+)[:;](?<sv>\d+)[-~]
    #         (?<ec>\d+)[:;](?<ev>\d+)      
    #         |
    #         (?<sc>\d+)[:;](?<sv>\d+)[-~]
    #         (?<ev>\d+)                    
    #         |
    #         (?<sc>\d+)[-~](?<ec>\d+)      
    #         |
    #         (?<sc>\d+)[:;](?<sv>\d+)      
    #         |
    #         (?<sc>\d+)                    
    #       )
    #       |
    #       (?:                             
    #         (?<sc>\d+)[:;](?<sv>\d+)[-~]
    #         (?<ec>\d+)[:;](?<ev>\d+)      
    #         |
    #         (?<sc>\d+)[:;](?<sv>\d+)[-~]
    #         (?<ev>\d+)                    
    #         |
    #         (?<sv>\d+)[-~](?<ev>\d+)      
    #         |
    #         (?<sc>\d+)[:;](?<sv>\d+)      
    #         |
    #         (?<sv>\d+)                    
    #       )
    #   $'
    # puts book_match_str
    # if Regexp.new(book_match_str, Regexp::EXTENDED).match(shortcut)

    book_name_included = false
    if /^(\D+)(\d.*)$/ =~ shortcut
      book_name_included = true
      shortcut = $2 # shortcut에서 책 정보 삭제.
      if BibleInfo.bible_shortnames.find_index($1)
        @bible_shortname = $1
      elsif BibleInfo.bible_names.find_index($1)
        @bible_shortname = BibleInfo.bible_name_to_shortname[$1]
      else # 책 이름이 이상한 경우.
        return :INVALID_BOOKNAME
      end
    elsif not @bible_shortname
      #성경 이름이 없음.
      return :NO_BOOKNAME_HISTORY
    end
    
    
    if /^(\d+)[:;](\d+)[-~](\d+)[:;](\d+)$/ =~ shortcut
      @start_chapter = $1
      @start_verse = $2
      @end_chapter = $3
      @end_verse = $4
    elsif /^(\d+)[:;](\d+)[-~](\d+)$/ =~ shortcut
      @start_chapter = $1
      @start_verse = $2
      @end_chapter = $1
      @end_verse = $3
    elsif /^(\d+)[:;](\d+)$/ =~ shortcut
      @start_chapter = $1
      @start_verse = $2
      @end_chapter = $1
      @end_verse = $2
    elsif /^(\d+)[-~](\d+)$/ =~ shortcut
      if book_name_included
        @start_chapter = $1
        @end_chapter = $2
        @start_verse = 1
        @end_verse = nil
      elsif @bible_shortname
        if @start_chapter
          @end_chapter = @start_chapter
          @start_verse = $1
          @end_verse = $2
        else
          return :NO_CHAPTER_HISTORY
        end
      else
        return :NO_BOOKNAME_HISTORY
      end
    elsif /^(\d+)$/ =~ shortcut
      if book_name_included
        @start_chapter = $1
        @end_chapter = $1
        @start_verse = 1
        @end_verse = nil
      elsif @bible_shortname
        if @start_chapter
          @end_chapter = @start_chapter
          @start_verse = $1
          @end_verse = $1
        else
          return :NO_CHAPTER_HISTORY
        end
      else
        return :NO_BOOKNAME_HISTORY
      end
    else
      puts shortcut
      return :INPUT_PATTERN_ERROR
    end
    
    @start_chapter = @start_chapter.to_i
    @start_verse = @start_verse.to_i
    @end_chapter = @end_chapter.to_i
    @end_verse = @end_verse.to_i if @end_verse
    return :SUCCEEDED
  end
  # def valid?(shortcut)
  #   shortcut.gsub! /\s+/, ''
    #   if shortcut =~ /^([^:~\-\d\s]+)(.*)$/
    #     if BibleInfo.bible_shortnames.find_index($1)
    #       @bible_shortname = $1
    #       shortcut = $2
    #     elsif BibleInfo.bible_names.find_index($1)
    #       @bible_shortname = BibleInfo.bible_name_to_shortname[$1]
    #       shortcut = $2
    #     end
    #   else
    #     return false unless @bible_shortname
    #   end
    #   #puts @bible_shortname
    #   rangestr = shortcut.split /[-~]/
    #   if rangestr.length > 2
    #     return false
    #   elsif rangestr.length < 1
    #     return false
    #   else
    #     if not get_chapter_and_verse(rangestr[0]) { |c, v| @start_chapter=c; @start_verse=v; }
    #       return false
    #     end
    #     if rangestr.length == 2
    #       if not get_chapter_and_verse(rangestr[1]) { |c, v| @end_chapter=c; @end_verse=v; }
    #         return false
    #       end
    #     else
    #       @end_chapter=@start_chapter; @end_verse=@start_verse
    #     end
    #     if @start_chapter
    #       return true
    #     else
    #       return false
    #     end
    #   end
    # end
  end
