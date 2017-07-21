#! /usr/bin/env ruby 

require "restforce"


@client = Restforce.new :username => username,
  :password       =>  password,
  :security_token => token,
  :client_id      => clientID,
  :client_secret  => clientSecret
 
