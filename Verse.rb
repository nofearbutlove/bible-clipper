class Verse

	attr_accessor :bible_shortname
	attr_accessor :chapter
	attr_accessor :verse
	attr_accessor :text

	def initialize(bible_shortname, chapter, verse, text)
		@bible_shortname = bible_shortname
		@chapter = chapter.to_s
		@verse = verse.to_s
		@text = text
	end

	def self.set_prefix(prefix)
		@@prefix = prefix
	end

	def self.set_verse_text_delimiter(delimiter)
		@@delimiter = delimiter
	end

	def to_s(bible_shortname_en, chapter_en)
		if chapter_en
			chapter = "#{@chapter}:"
		else
			chapter = ''
		end
		if bible_shortname_en
			bible_shortname = @bible_shortname
		else
			bible_shortname = ''
		end
		"#{@@prefix}#{bible_shortname}#{chapter}#{@verse}#{@@delimiter}#{@text}"
	end

end