#!/usr/bin/env ruby
require File.dirname(__FILE__)+"/AVAModule.rb"

class AVAHomeCamsModule < AVAModule

	BasicTasks = [
		'add Cam',
		'online',
		'snapshot',
		'stream',
		'exit'
		].sort

	def initialize()
	
		initReadline("AVA|Home|Cams > ", BasicTasks)
	end

	#override
	def findTask(task)


		query = task.downcase 
		case 
		when query === "h"
		puts "Hilfe"
		when query.downcase.match(/add cam/)
			addCam()
		when query.downcase.match(/online/)
			#TODO
		when query.downcase.match(/snapshot/)
			#TODO
		when query.downcase.match(/stream/)
			#TODO
		else
			if query != ""
				puts "Ich bin mir nicht sicher was du meinst..."
			end
		end


	end



	def addCam()
			
			puts "\\n Scanning Network... \\n"
			puts `arp -a | awk '{print $2 ":\\t" $1 "\\n"}'`
			puts "Select IP: [x.x.x.x]"
			ip = STDIN.gets.chomp

			puts "Danke"
	end
	
	


end




#
