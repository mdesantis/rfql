task :default => :irb

task :irb do
  require 'ruby-debug'
  $LOAD_PATH << "#{Dir.pwd}/lib"
  require 'rfql'
  require 'irb'
  ARGV.clear
  IRB.start
end

task :rdebug do
end
