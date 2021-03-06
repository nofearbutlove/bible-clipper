#encoding: utf-8
class BibleInfo 
	#require "JSON"

	
	def self.db_name
		@@db_name
	end
	def self.translation_name_to_code
		@@translation_name_to_code
	end
	def self.bible_shortname_to_name
		@@bible_shortname_to_name
	end
	def self.bible_name_to_code
		@@bible_name_to_code
	end
	def self.bible_name_to_english_code
		@@bible_name_to_english_code
	end
	def self.bible_name_to_chapter_len
		@@bible_name_to_chapter_len
	end

	def self.bible_name_to_shortname
		@@bible_shortname_to_name.invert
	end

	def self.bible_shortnames
		@@bible_shortname_to_name.keys
	end

	def self.bible_names
		@@bible_name_to_chapter_len.keys
	end
	
	@@db_name = 'BibleDB'
	@@translation_name_to_code =
	{
		'개역개정'=>'GAE',
		'개역한글'=>'HAN',
		'표준새번역'=>'SAE',
		'새번역'=>'SAENEW',
		'공동번역'=>'COG',
		'공동번역 개정판'=>'COGNEW',
		'NIV'=>'NIV',
		'KJV'=>'KJV',
		'NASB'=>'NASB'
	}
	@@bible_shortname_to_name =
	{
		'창'=>'창세기',
		'출'=>'출애굽기',
		'레'=>'레위기',
		'민'=>'민수기',
		'신'=>'신명기',
		'수'=>'여호수아',
		'삿'=>'사사기',
		'룻'=>'룻기',
		'삼상'=>'사무엘상',
		'삼하'=>'사무엘하',
		'왕상'=>'열왕기상',
		'왕하'=>'열왕기하',
		'대상'=>'역대상',
		'대하'=>'역대하',
		'스'=>'에스라',
		'느'=>'느헤미야',
		'에'=>'에스더',
		'욥'=>'욥기',
		'시'=>'시편',
		'잠'=>'잠언',
		'전'=>'전도서',
		'아'=>'아가',
		'사'=>'이사야',
		'렘'=>'예레미야',
		'애'=>'예레미야 애가',
		'겔'=>'에스겔',
		'단'=>'다니엘',
		'호'=>'호세아',
		'욜'=>'요엘',
		'암'=>'아모스',
		'옵'=>'오바댜',
		'욘'=>'요나',
		'미'=>'미가',
		'나'=>'나훔',
		'합'=>'하박국',
		'습'=>'스바냐',
		'학'=>'학개',
		'슥'=>'스가랴',
		'말'=>'말라기',
		'마'=>'마태복음',
		'막'=>'마가복음',
		'눅'=>'누가복음',
		'요'=>'요한복음',
		'행'=>'사도행전',
		'롬'=>'로마서',
		'고전'=>'고린도전서',
		'고후'=>'고린도후서',
		'갈'=>'갈라디아서',
		'엡'=>'에베소서',
		'빌'=>'빌립보서',
		'골'=>'골로새서',
		'살전'=>'데살로니가전서',
		'살후'=>'데살로니가후서',
		'딤전'=>'디모데전서',
		'딤후'=>'디모데후서',
		'딛'=>'디도서',
		'몬'=>'빌레몬서',
		'히'=>'히브리서',
		'약'=>'야고보서',
		'벧전'=>'베드로전서',
		'벧후'=>'베드로후서',
		'요일'=>'요한1서',
		'요이'=>'요한2서',
		'요삼'=>'요한3서',
		'유'=>'유다서',
		'계'=>'요한계시록'
	}
	@@bible_name_to_code =
	{
		'창세기'=>1,
		'출애굽기'=>2,
		'레위기'=>3,
		'민수기'=>4,
		'신명기'=>5,
		'여호수아'=>6,
		'사사기'=>7,
		'룻기'=>8,
		'사무엘상'=>9,
		'사무엘하'=>10,
		'열왕기상'=>11,
		'열왕기하'=>12,
		'역대상'=>13,
		'역대하'=>14,
		'에스라'=>15,
		'느헤미야'=>16,
		'에스더'=>17,
		'욥기'=>18,
		'시편'=>19,
		'잠언'=>20,
		'전도서'=>21,
		'아가'=>22,
		'이사야'=>23,
		'예레미야'=>24,
		'예레미야 애가'=>25,
		'에스겔'=>26,
		'다니엘'=>27,
		'호세아'=>28,
		'요엘'=>29,
		'아모스'=>30,
		'오바댜'=>31,
		'요나'=>32,
		'미가'=>33,
		'나훔'=>34,
		'하박국'=>35,
		'스바냐'=>36,
		'학개'=>37,
		'스가랴'=>38,
		'말라기'=>39,
		'마태복음'=>40,
		'마가복음'=>41,
		'누가복음'=>42,
		'요한복음'=>43,
		'사도행전'=>44,
		'로마서'=>45,
		'고린도전서'=>46,
		'고린도후서'=>47,
		'갈라디아서'=>48,
		'에베소서'=>49,
		'빌립보서'=>50,
		'골로새서'=>51,
		'데살로니가전서'=>52,
		'데살로니가후서'=>53,
		'디모데전서'=>54,
		'디모데후서'=>55,
		'디도서'=>56,
		'빌레몬서'=>57,
		'히브리서'=>58,
		'야고보서'=>59,
		'베드로전서'=>60,
		'베드로후서'=>61,
		'요한1서'=>62,
		'요한2서'=>63,
		'요한3서'=>64,
		'유다서'=>65,
		'요한계시록'=>66
	}
	
	@@bible_name_to_english_code =
	{
		'창세기'=>'gen',
		'출애굽기'=>'exo',
		'레위기'=>'lev',
		'민수기'=>'num',
		'신명기'=>'deu',
		'여호수아'=>'jos',
		'사사기'=>'jdg',
		'룻기'=>'rut',
		'사무엘상'=>'1sa',
		'사무엘하'=>'2sa',
		'열왕기상'=>'1ki',
		'열왕기하'=>'2ki',
		'역대상'=>'1ch',
		'역대하'=>'2ch',
		'에스라'=>'ezr',
		'느헤미야'=>'neh',
		'에스더'=>'est',
		'욥기'=>'job',
		'시편'=>'psa',
		'잠언'=>'pro',
		'전도서'=>'ecc',
		'아가'=>'sng',
		'이사야'=>'isa',
		'예레미야'=>'jer',
		'예레미야애가'=>'lam',
		'에스겔'=>'ezk',
		'다니엘'=>'dan',
		'호세아'=>'hos',
		'요엘'=>'jol',
		'아모스'=>'amo',
		'오바댜'=>'oba',
		'요나'=>'jnh',
		'미가'=>'mic',
		'나훔'=>'nam',
		'하박국'=>'hab',
		'스바냐'=>'zep',
		'학개'=>'hag',
		'스가랴'=>'zec',
		'말라기'=>'mal',
		'마태복음'=>'mat',
		'마가복음'=>'mrk',
		'누가복음'=>'luk',
		'요한복음'=>'jhn',
		'사도행전'=>'act',
		'로마서'=>'rom',
		'고린도전서'=>'1co',
		'고린도후서'=>'2co',
		'갈라디아서'=>'gal',
		'에베소서'=>'eph',
		'빌립보서'=>'php',
		'골로새서'=>'col',
		'데살로니가전서'=>'1th',
		'데살로니가후서'=>'2th',
		'디모데전서'=>'1ti',
		'디모데후서'=>'2ti',
		'디도서'=>'tit',
		'빌레몬서'=>'phm',
		'히브리서'=>'heb',
		'야고보서'=>'jas',
		'베드로전서'=>'1pe',
		'베드로후서'=>'2pe',
		'요한1서'=>'1jn',
		'요한2서'=>'2jn',
		'요한3서'=>'3jn',
		'유다서'=>'jud',
		'요한계시록'=>'rev'
	}

	@@bible_name_to_chapter_len =
	{
		'창세기'=>50,
		'출애굽기'=>40,
		'레위기'=>27,
		'민수기'=>36,
		'신명기'=>34,
		'여호수아'=>24,
		'사사기'=>21,
		'룻기'=>4,
		'사무엘상'=>31,
		'사무엘하'=>24,
		'열왕기상'=>22,
		'열왕기하'=>25,
		'역대상'=>29,
		'역대하'=>36,
		'에스라'=>10,
		'느헤미야'=>13,
		'에스더'=>10,
		'욥기'=>42,
		'시편'=>150,
		'잠언'=>31,
		'전도서'=>12,
		'아가'=>8,
		'이사야'=>66,
		'예레미야'=>52,
		'예레미야 애가'=>5,
		'에스겔'=>48,
		'다니엘'=>12,
		'호세아'=>14,
		'요엘'=>3,
		'아모스'=>9,
		'오바댜'=>1,
		'요나'=>4,
		'미가'=>7,
		'나훔'=>3,
		'하박국'=>3,
		'스바냐'=>3,
		'학개'=>2,
		'스가랴'=>14,
		'말라기'=>4,
		'마태복음'=>28,
		'마가복음'=>16,
		'누가복음'=>24,
		'요한복음'=>21,
		'사도행전'=>28,
		'로마서'=>16,
		'고린도전서'=>16,
		'고린도후서'=>13,
		'갈라디아서'=>6,
		'에베소서'=>6,
		'빌립보서'=>4,
		'골로새서'=>4,
		'데살로니가전서'=>5,
		'데살로니가후서'=>3,
		'디모데전서'=>6,
		'디모데후서'=>4,
		'디도서'=>3,
		'빌레몬서'=>1,
		'히브리서'=>13,
		'야고보서'=>5,
		'베드로전서'=>5,
		'베드로후서'=>3,
		'요한1서'=>5,
		'요한2서'=>1,
		'요한3서'=>1,
		'유다서'=>1,
		'요한계시록'=>22
	}
end

