desc 'IRB console'
task :irb do
  $LOAD_PATH << "#{Dir.pwd}/lib"
  require 'rfql'
  require 'irb'
  ARGV.clear
  IRB.start
end
