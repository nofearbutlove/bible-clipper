#encoding: utf-8

require_relative 'BibleShortcutHandler.rb'

handler = BibleShortcutHandler.new

if handler.valid? "갈1:1-2"
	
else
	puts "valid method Failed."
end
p handler

if handler.valid? "3~4"
else
	puts "valid method Failed."
end
p handler

handler.clear_history

if handler.valid? "5-8"
else
	puts "valid method Failed."
end

p handler