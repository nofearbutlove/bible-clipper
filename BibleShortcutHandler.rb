#encoding: utf-8
class BibleShortcutHandler

  attr_accessor :bible_shortname
  attr_accessor :start_chapter
  attr_accessor :start_line
  attr_accessor :end_chapter
  attr_accessor :end_line

  def initialize(bible_shortnames)
    @bible_shortname = nil
    @start_chapter = nil
    @bible_shortnames = bible_shortnames
  end
  BookNameRegExp = '\s*([^:~\-\d\s]+)\s*';
  NumberRegExp = '\s*(\d+)\s*';

  def to_s
    if @end_line.nil?
      end_line = 'end'
    end
    "#{bible_shortname}#{start_chapter}:#{start_line}-#{end_chapter}:#{end_line}"
  end

  def valid?(shortcut)

    if shortcut =~ /^#{BookNameRegExp}(.*)$/
      if @bible_shortnames.find_index($1)
        @bible_shortname = $1
        shortcut = $2
      end
    end

    if shortcut =~ /^#{NumberRegExp}(.*)$/
      @start_chapter, @start_line, @end_chapter, @end_line = $1, 1, $1, nil;
      true
    elsif /^#{NumberRegExp}[-~]#{NumberRegExp}/
      @start_chapter, @start_line, @end_chapter, @end_line = $1, 1, $2, nil;
      true
    elsif /^#{NumberRegExp}:#{NumberRegExp}/
      @start_chapter, @start_line, @end_chapter, @end_line = $1, $2, $1, $2;
      true
    elsif /^#{NumberRegExp}:#{NumberRegExp}[-~]#{NumberRegExp}/
      @start_chapter, @start_line, @end_chapter, @end_line = $1, $2, $1, $4;
      true
    elsif /^#{NumberRegExp}:#{NumberRegExp}[-~]#{NumberRegExp}:#{NumberRegExp}/
      @start_chapter, @start_line, @end_chapter, @end_line = $1, $2, $3, $4;
      true
    else
      false
    end
  end
end
