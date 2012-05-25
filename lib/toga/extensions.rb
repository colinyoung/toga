require 'yaml'

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

module Git
  class Status
    
    # Retrieves files that are ignored
    def ignored
      ignored = @base.lib.send :command, 'clean', '-ndX'
      ignored = ignored.split("\n").collect {|i| i.gsub('Would remove ', '') }
      files = @files.values.dup
      subdirectory_ignores = {}
      ignored.each do |i|
        if !i[/\/(|\*)$/].nil? # ends in either / or /*
          files.each do |f|
            if f.path.starts_with?(i)
              subdirectory_ignores[f.path] = f
            end
          end
        end
      end
      subdirectory_ignores
    end
    
    def untracked!
      ignored_paths = self.ignored.keys + self.subproject_files.keys
      self.untracked.reject {|k,v| ignored_paths.include?(v.path) }
    end
    
    def subproject_files
      return @base.lib.submodules if @base.lib.respond_to? :submodules
        
      # Ruby-git doesn't support submodules, so do
      # them manually
      submodules = {}
      
      Dir.chdir(@base.dir.to_s) do 
        lines = %x[git submodule status]
      
        lines.split("\n").each do |l|
          exp = /([\-0-9A-f]+) ([^ ]+)/
          m = exp.match(l)
          ref = m[1]
          path = m[2]
        
          submodules[path] = {:ref => ref, :path => path}
        end
      end
      
      submodules
    end
    
    def modified
      regex = /^[0]+$/
      added.select {|k,v| v.sha_index[regex] && v.sha_repo[regex] }
    end
  end
end
