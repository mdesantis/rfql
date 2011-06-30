require 'rfql/query/quoting'
module RFQL::Query::Methods
  include RFQL::Query::Quoting
  
  def query(query = nil)
    @query = query
    self
  end
  
  def select(*fields)
    @select =
      if fields.blank?
        nil
      else
        fields.flatten!; fields.uniq!; fields.join(', ')
      end
    self
  end
  def select?; @select; end
  
  def from(from = nil)
    @from = from
    self
  end
  def from?; @from; end
  
  def where(where = nil)
    @where = 
      case where
        when String   then where
        when Array    then sanitize_sql_array(where)
        when Hash     then sanitize_sql_hash_for_conditions(where)
        when NilClass then nil
        else          raise ArgumentError, "only strings, hashes or arrays can be converted to sql conditions"
      end
    self
  end
  def where?; @where; end
  
  def order(order = nil)
    @order = order
    self
  end
  def order?; @order; end
  
  def limit(limit = nil)
    @limit = limit
    self
  end
  def limit?; @limit; end
  
  private
  def compose_query
    [].tap do |arr|
      arr << "SELECT #{@select}"  if @select.present?
      arr << "FROM #{@from}"      if @from.present?
      arr << "WHERE #{@where}"    if @where.present?
      arr << "ORDER BY #{@order}" if @order.present?
      arr << "LIMIT #{@limit}"    if @limit.present?
    end.join(' ')
  end
  
  def sanitize_sql_hash_for_conditions(attrs)
    conditions = attrs.map do |attr, value|
        attr = attr.to_s
        attribute_condition(attr, value)
    end.join(' AND ')

    replace_bind_variables(conditions, expand_range_bind_variables(attrs.values))
  end
  
  def attribute_condition(quoted_column_name, argument)
    case argument
      when nil   then "#{quoted_column_name} IS ?"
      when Array then "#{quoted_column_name} IN (?)"
      when Range then if argument.exclude_end?
                        "#{quoted_column_name} >= ? AND #{quoted_column_name} < ?"
                      else
                        "#{quoted_column_name} BETWEEN ? AND ?"
                      end
      else            "#{quoted_column_name} = ?"
    end
  end
  
  def expand_range_bind_variables(bind_vars)
    expanded = []

    bind_vars.each do |var|
      next if var.is_a?(Hash)

      if var.is_a?(Range)
        expanded << var.first
        expanded << var.last
      else
        expanded << var
      end
    end

    expanded
  end
  
  def sanitize_sql_array(ary)
    statement, *values = ary
    if values.first.is_a?(Hash) and statement =~ /:\w+/
      replace_named_bind_variables(statement, values.first)
    elsif statement.include?('?')
      replace_bind_variables(statement, values)
    else
      statement % values.collect { |value| quote_string(value.to_s) }
    end
  end
  
  def replace_named_bind_variables(statement, bind_vars)
    statement.gsub(/(:?):([a-zA-Z]\w*)/) do
      if $1 == ':' # skip postgresql casts
        $& # return the whole match
      elsif bind_vars.include?(match = $2.to_sym)
        quote_bound_value(bind_vars[match])
      else
        raise ArgumentError, "missing value for :#{match} in #{statement}"
      end
    end
  end
  
  def quote_bound_value(value)
    if value.respond_to?(:map) && !value.acts_like?(:string)
      if value.respond_to?(:empty?) && value.empty?
        quote(nil)
      else
        value.map { |v| quote(v) }.join(',')
      end
    else
      quote(value)
    end
  end
  
  def replace_bind_variables(statement, values)
    raise_if_bind_arity_mismatch(statement, statement.count('?'), values.size)
    bound = values.dup
    statement.gsub('?') { quote_bound_value(bound.shift) }
  end
  
  def raise_if_bind_arity_mismatch(statement, expected, provided)
    unless expected == provided
      raise ArgumentError, "wrong number of bind variables (#{provided} for #{expected}) in: #{statement}"
    end
  end
end
