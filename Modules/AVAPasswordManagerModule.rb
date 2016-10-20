#!/usr/bin/env ruby
require "rubygems"
require "sequel"
require File.dirname(__FILE__)+"/AVAModule.rb"

class AVAPasswordManagerModule < AVAModule

	DB = Sequel.connect('sqlite://'+File.dirname(__FILE__)+'/data/.ava.db')

	PasswordTasks = [
		'new',
		'edit',
		'find',
		'delete',
		'delete all',
		'show all'
		].sort



		def initialize()

			DB.create_table? :passwords do
				primary_key :id
				String :login
				String :password
				String :service
				String :group
			end

			initReadline("AVA|Passwords > ", PasswordTasks)

		end

		def findTask(task)
			query = task.downcase 
			case 
			when query === "h"
				puts "Hilfe"
			when query.downcase.match(/new/)
				addNew()
			when query.downcase.match(/edit/)
			#addNew()
		when query.downcase.match(/find/)
			find()
		when query.downcase.match(/delete/)
			delete()
		when query.downcase.match(/delete all/)
			deleteAll()
		when query.downcase.match(/show all/)
			showAll()
		else
			if query != ""
				talk("Ich bin mir nicht sicher was du meinst...")
			end
		end
	end


	#Methods


	def addNew()

		puts "Enter Login Name"
		login = STDIN.gets.chomp
		
		password = getPasswordCMD(0)

		if password != ""
			
			puts "Enter Service"
			service = STDIN.gets.chomp
			puts "Enter Group"
			group = STDIN.gets.chomp
			if group == ""
				group = "-"
			end

			passwordsDB = DB[:passwords]

			passwordsDB.insert(
				:login => login, 
				:password => password, 
				:service => service, 
				:group => group
				)
			return true
		else
			return false
		end
	end
	

	def showAll()

		dataset = DB["SELECT * FROM passwords"]

		dataset.each{
			|pwd| 
			id = pwd[:id].to_s
			login = pwd[:login]
			password = pwd[:password]
			service = pwd[:service]
			group = pwd[:group]
			puts "\n***"
			puts "Id:\t\t" + id
			puts "Login:\t\t" + login
			puts "Password:\t" + password
			puts "Service:\t" + service
			puts "Group:\t\t" + group
			
		}
		puts "\n"
	end

	def deleteAll()
		puts "Really Delete? Then type 'Yes':"
		delete = STDIN.gets.chomp
		if delete == "Yes"
			DB[:passwords].delete
			puts "DElETED PASSWORDS DB"
		else
			puts "NOT DElETED PASSWORDS DB"
		end

		
	end

	def delete()
		puts "Please Enter ID:"
		id = Integer(STDIN.gets.chomp)
		
		dataset = DB["SELECT id FROM passwords WHERE id like #{id}"]

		puts dataset.count
		dataset.each{|x|
			puts "#{x}"
		}


		if dataset.count > 0
			puts "DELETE RECORD:"

			dataset.each do |pass|
				if reallyDelete()
					DB[:passwords].where(pass).delete
					puts "DElETED PASSWORD."
				else
					puts "NOT DElETED PASSWORD!"
				end

			end

		end



		
	end


	def reallyDelete ()
		puts "Really Delete? Then type 'Yes':"
		delete = STDIN.gets.chomp
		if delete == "Yes"
			return true
		else
			return false
		end
	end




	def find()

		puts "Enter SearchTerm"
		searchTerm = STDIN.gets.chomp.upcase
		#dataset = DB["SELECT * FROM passwords WHERE Upper(login) like '%#{searchTerm}%'"]
		dataset = DB["SELECT * FROM passwords WHERE Upper(login) like '%#{searchTerm}%' OR Upper(password) like '%#{searchTerm}%' OR Upper(service) like '%#{searchTerm}%'"]



		dataset.each{
			|pwd| 
			id = pwd[:id].to_s
			login = pwd[:login]
			password = pwd[:password]
			service = pwd[:service]
			group = pwd[:group]
			
			puts "\n***"
			puts "Id:\t\t" + id
			puts "Login:\t\t" + login
			puts "Password:\t" + password
			puts "Service:\t" + service
			puts "Group:\t\t" + group
			
		}
		puts "\n"
	end




	#Helper
	def getPasswordCMD(index)
		
		puts "Enter Password"
		password = STDIN.gets.chomp
		puts "Enter Password Again"
		password2 = STDIN.gets.chomp
		if password == password2
			return password
		end
		

		if index < 2
			puts "Passwords doesn't match! Try Again."
			index = index+1
			return getPasswordCMD(index)
		else
			return ""
		end
	end



end
