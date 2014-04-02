$:.push File.expand_path("../lib", __FILE__)

require 'rfql/version'

Gem::Specification.new do |s|
  s.name        = 'rfql'
  s.version     = RFQL::VERSION
  s.summary     = 'AREL-style interface for the Facebook Query Language'
  s.description = 'AREL-style interface for fetching data from Facebook through the Facebook Query Language'
  s.author      = 'Maurizio De Santis'
  s.email       = 'desantis.maurizio@gmail.com'
  s.homepage    = 'https://github.com/mdesantis/rfql'
  s.files       = `git ls-files`.split("\n")
  s.homepage    =
    'http://rubygems.org/gems/hola'
  s.license     = 'MIT'
  s.add_dependency 'activesupport', '~> 4.0', '>= 4.0.0'
end