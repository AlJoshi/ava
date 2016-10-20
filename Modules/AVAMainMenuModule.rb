#!/usr/bin/env ruby
require File.dirname(__FILE__)+"/AVAModule.rb"
require File.dirname(__FILE__)+"/AVAPasswordManagerModule.rb"
require File.dirname(__FILE__)+"/AVAWeatherModule.rb"
require File.dirname(__FILE__)+"/AVAHomeModule.rb"

class AVAMainMenuModule < AVAModule

	BasicTasks = [
		'passwords',
		'exit',
		'home',
		'weather'
		].sort

	def initialize()

		

	end


	def start()
		initReadline("AVA > ", BasicTasks)
	end





	#override
	def findTask(task)


		query = task.downcase 
		case 
		when query === "h"
		puts "Hilfe"
		when query.downcase.match(/password/)
			apm = AVAPasswordManagerModule.new()
		when query.downcase.match(/weather/)
			awm = AVAWeatherModule.new()
		when query.downcase.match(/home/)
			awm = AVAHomeModule.new()
		else
			if query != ""
				talk("Ich bin mir nicht sicher was du meinst...")
			end
		end


	end
	


end




#
