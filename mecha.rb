#! /usr/bin/env ruby

require "mail"
require "restforce"
require "json"
require 'csv'
require "pp"
require 'rufus-scheduler'
require './mail'
require './api'

#All commented out puts are for printing info during trouble shooting 

def mecha


mail = Mail.last #Gets the last email from email inbox 
@subject = mail.subject #Pull the subject of the email. Kind of global variable so it can transend methods  
@email = mail.body.to_s #Gets email body also makes it a string
$opptName = '' #Declares this var so it can be used later in a method 


def getname #Method gets the oppt name from the email 
  num = @email.index("!")  #find index number til string just before account name 

  start = (num.to_i + 2) #finds the first letter of account name ##to capture character start = email[num + 2].chr

  stop = @email.index("has added") #this captures index of "h" in "has added"


  $opptName = @email[start...stop] #Takes the string from start and stop vars 
  puts $opptName

end

def checkname #Calls getname method if the subject is right 
  if @subject == "FW: Order Notification" || "Fw: Order Notification" #Checks that subject is right for the email
  #if @subject == "Fw: Order Notification" ##Uncomment for troubleshooting in testing sfdc
    puts 'The script works.'
    getname #Runs the right methd 
  else
    puts "Not the note email"
    #getname
    nil # Nothing otherwise 
  end
  puts "End of checkname and getname.rb"
end

checkname #Runs that portion of the script 

#Start of closed section 
report = @client.get('/services/data/v37.0/analytics/reports/00O61000003iN7L?includeDetails=true' ) #Gets the report from salesforce
#report = @client.get('/services/data/v37.0/analytics/reports/00O15000007XxMmEAK?includeDetails=true' ) ##Uncomment for troubleshooting in test sfdc


reportFile =  report.body.to_json #Turns report var into json

obj = JSON.parse(reportFile) #Prases reportFile

obj2 =  obj["factMap"]["T!T"]["rows"] #Gets out the proper section of the json


count =  obj["factMap"]["T!T"]["rows"].count #How to get number of items in array
counter = 0 #Counter for the loop 



opptname = $opptName.strip #Strips the white space from the oppt name 
puts $opptName
oppt = [] #Creates a hash before the method. Same for the two following lines
opptid = []
@opptidperm = ''
@opptpayreadyperm = ''

while counter < count  do #Loop to read the results of the report 

  oppt = obj2[counter]["dataCells"][0]["label"] #Counts through sections of json for the oppt details. Pulls oppt name 
  puts oppt

  opptid = obj2[counter]["dataCells"][1]["label"] #Pulls salesforce ID for our oppt 

  opptpayready = obj2[counter]["dataCells"][2]["label"]
  
  mechaclosed = obj2[counter]["dataCells"][3]["label"]  


  if opptname == oppt && opptpayready == "true" && mechaclosed == "false" #Oppt name from email needs to match oppt name from report 
    puts opptid
    @opptidperm = opptid #Make salesforce ID for this interation of loop as the one that will be used in api call
    @opptpayreadyperm = opptpayready
    puts "The if else loop with payready true worked." 
  else
    nil
  end

  puts "This is pass #{counter}"
  counter = counter + 1 #Counter that pushes loop forward
 
end



=begin
puts ""
puts ""
puts "heres a line after"
puts "This is Oppt ID for the salesforce api call" + @opptidperm
=end 

def close #Makes the api call for set "Closed Won" and closed date

  closedwon = @client.update('Opportunity', Id: @opptidperm, StageName: 'Closed Won') #Sets oppt to "Closed Won"
  closedwondate = @client.update('Opportunity', Id: @opptidperm, CloseDate: Date.today) #Sets dates for closed
  mechaclosedmark = @client.update('Opportunity', Id: @opptidperm, mechaclosed__c: "true")

  closedwon #Calls action so does line below 
  closedwondate
  mechaclosedmark
  puts "close and closed.rb work"

end


close #Calls close method 

end 



scheduler = Rufus::Scheduler.new 

otherCounter = 0

scheduler.every '1m' do #Makes mecha method run every 3 seconds
  mecha
  otherCounter = otherCounter + 1

  puts ""
  puts "Run number #{otherCounter}"
end

scheduler.join

