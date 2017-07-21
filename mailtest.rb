#! /usr/bin/env ruby

require "mail"
require "./mail"

#All commented out puts are for printing info during trouble shooting 


mail = Mail.last
@subject = mail.subject
@email = mail.body.to_s
$opptName = ''
#puts @email 

def getname
num = @email.index("!")  #find index number til string just before account name 

start = (num.to_i + 2) #finds the first letter of account name ##to capture character start = email[num + 2].chr

stop = @email.index("has added") #this captures index of "h" in "has added"


$opptName = @email[start...stop]
puts $opptName 

end


#Test section START
puts @subject
puts $opptName 




def checkname
  if @subject == "FW: Order Notification" || "Fw: Order Notification"
    puts 'The script works. Oppt name is below.' 
    puts $opptName 
    getname
  else
    puts "Not the notification email. Subject is below." 
    puts  @subject  
    #getname
    nil 
  end
  puts "End of checkname and getname.rb"
end



checkname  
 


#puts "End of getname."
