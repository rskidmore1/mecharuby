#! /usr/bin/env ruby

require "mail"


#Whose is this: testing 
Mail.defaults do
  retriever_method :imap, :address    => "imap.gmail.com",
                          :port       => 993,
                          :user_name  => email,
                          :password   => password,
                          :enable_ssl => true
end


