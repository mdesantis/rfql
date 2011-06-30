require 'echoe'

Echoe.new("rfql") do |p|
  p.author = "De Santis Maurizio"
  p.summary = "RFQL - Ruby interface for Facebook Query Language"
  p.runtime_dependencies = ["string_tools >=1.4.0"]
  p.project = 'https://github.com/ProGNOMmers/rfql'
end

#task :default => :irb

task :irb do
  $LOAD_PATH << "#{Dir.pwd}/lib"
  require 'rfql'
  require 'irb'
  ARGV.clear
  IRB.start
end
