#!/usr/bin/env ruby
require File.dirname(__FILE__)+"/AVAModule.rb"

class AVAWeatherModule < AVAModule

	BasicTasks = [
		'city',
		'exit'
		].sort

	def initialize()

		
		initReadline("AVA|Weather > ", BasicTasks)
	end








	#override
	def findTask(task)


		query = task.downcase 
		case 
		when query === "h"
		puts "Hilfe"
		when query.downcase.match(/city/)
			openCity()
		else
			if query != ""
				puts "Ich bin mir nicht sicher was du meinst..."
			end
		end


	end



	def openCity()
	
			puts "Enter City"
			city = STDIN.gets.chomp

			puts "Öffne Wetter.com"
			puts `open http://wetter.com`

	end

	


end




#
