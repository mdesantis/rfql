require 'psych'
require 'echoe'

Echoe.new("rfql") do |p|
  p.author = "De Santis Maurizio"
  p.email = 'desantis.maurizio@gmail.com'
  p.description = "RFQL - Ruby interface for Facebook Query Language"
  p.summary =<<-SMY
It lets you use ORM-style code for fetching data 
from Facebook through the Facebook Query Language
  SMY
end

#task :default => :irb

task :irb do
  $LOAD_PATH << "#{Dir.pwd}/lib"
  require 'rfql'
  require 'irb'
  ARGV.clear
  IRB.start
end
