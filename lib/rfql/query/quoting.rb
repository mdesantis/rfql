# Adapted from https://github.com/rails/rails/blob/master/activerecord/lib/active_record/connection_adapters/abstract/quoting.rb
require 'yaml'
module RFQL
  class Query
    module Quoting
  # Quotes the column value to help prevent
  # {SQL injection attacks}[http://en.wikipedia.org/wiki/SQL_injection].
  def quote(value)
    case value
    when String    then "'#{quote_string(value)}'"
      when true    then 'true'
      when false   then 'false'
      when nil     then "NULL"
      when Numeric then value.to_s
      when Date    then value.to_time.to_i.to_s
      when Time    then value.to_i.to_s
      when Symbol  then value.to_s
      else         "'#{quote_string(YAML.dump(value))}'"
    end
  end

  # Quotes a string, escaping any ' (single quote) and \ (backslash)
  # characters.
  def quote_string(s)
    s.gsub(/\\/, '\&\&').gsub(/'/, "''") # ' (for ruby-mode)
  end

  # Quotes the column name. Defaults to no quoting.
  def quote_column_name(column_name)
    column_name.to_s
  end

  # Quotes the table name. Defaults to column name quoting.
  def quote_table_name(table_name)
    quote_column_name(table_name)
  end
end
end
end
