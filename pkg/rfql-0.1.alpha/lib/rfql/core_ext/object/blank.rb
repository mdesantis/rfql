# From zucker https://github.com/janlelis/zucker/blob/master/lib/zucker/blank.rb
class Object
  def blank?
    if respond_to? :empty? then empty? else !self end
  end

  def present?
    !blank?
  end
end
