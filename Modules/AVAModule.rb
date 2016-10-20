#!/usr/bin/env ruby
require "readline"
class AVAModule 
	
		def initReadline(title,list)

		comp = proc { |s| list.grep( /^#{Regexp.escape(s)}/ ) }

		Readline.completion_append_character = " "
		Readline.completion_proc = comp

		stty_save = `stty -g`.chomp

		begin
			while buf = Readline.readline(title, true)
				#p Readline::HISTORY.to_a


				task = buf.force_encoding(Encoding::UTF_8)

				if task.downcase.strip=="exit"
					break 
				end
				findTask(task)
				Readline.completion_proc = comp

				stty_save = `stty -g`.chomp

			end

		rescue Interrupt => e
		  system('stty', stty_save) # Restore
		  msg = "Machs gut!"
		  puts msg
		 # puts `say #{msg}`
		  exit
		ensure
			system "stty echo"
		end
	end


	def findTask(task)
		puts task
	end


	def talk(msg)
		puts msg
	end
end
