#! /usr/bin/env ruby 

require "restforce"
require "json"
require 'csv'
require "pp"
require 'rufus-scheduler'
require './mail'
require './api'
require './mailtest'

#All commented out puts are their in case script breaks and needs troubleshooting 

puts @client.describe('Account')

puts ""
puts "SFDC works if there is no ruby error and instance url will show at the bottom of hash above." 

