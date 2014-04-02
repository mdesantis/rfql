module RFQL
  require 'rfql/version'
  require 'rfql/query'
  require 'rfql/request'

  def self.request(obj = nil)
    Request.new(obj)
  end

  def self.query(obj = nil)
    Query.new(obj)
  end
end