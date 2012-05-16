class String
  def starts_with?(prefix, options={})
    if prefix.is_a? Array
      prefix.each do |p|
        return true if self.starts_with?(p)
      end
    end
    
    prefix = prefix.to_s
    left = self[0, prefix.length]
    right = prefix
    
    return left.downcase == right.downcase if options[:case_sensitive] == false
    
    left == right
  end
end

class Array
  def includes_prefix?(prefix)
    self.each_with_index do |str, i|
      next if !str.is_a? String
      return i if str.starts_with?(prefix)
    end
    false
  end
end
