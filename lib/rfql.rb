require 'rfql/query'
require 'rfql/request'
module RFQL
  VERSION = '0.1.alpha.4'
  def self.request(obj = nil)
    RFQL::Request.new(obj)
  end
  def self.query(obj = nil)
    RFQL::Query.new(obj)
  end
end
