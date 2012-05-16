require 'yaml'

module Toga
  class Togafile
    
    HEADING_REGEX = /^[A-Z\ ]{3,}+/
    
    def self.path
      @@path ||= File.expand_path(File.join(Dir.getwd, Toga::TOGAFILE_NAME))
    end
    
    def self.path=(path)
      @@path = path
    end
    
    class << self
    
      def file_handle(mode='r')
        if block_given?
          File.open(self.path, mode) { yield }
        else
          File.open(self.path, mode)
        end
      end
    
      def lines_in_group(group_name)
        self.to_a[group_range(group_name)]
      end
    
      def append_to_group(group_name, string)
        lines = self.to_a
        range = group_range(group_name)
        last_index = range.last
        
        # Insert string at the end of the group
        lines.insert(last_index+1, string)
        
        # Write array back to file
        overwrite(lines)
      end
      
      def prepend_to_group(group_name, string)
        lines = self.to_a
        range = group_range(group_name)
        first_index = range.first + 1 # Add one to bypass title
        
        # Insert string at the end of the group
        lines.insert(first_index+1, string)
        
        # Write array back to file
        overwrite(lines)
      end
      
      def remove_from_group(group_name, string)
        offset = lines_in_group(group_name).includes_prefix?(string)
        if !offset
          puts "[Warning] Task '#{string}' doesn't exist in #{group_name}."
          return
        end
        range = group_range(group_name)
        index = range.first + offset
        
        # Insert string at the end of the group
        lines = self.to_a
        full = lines.delete_at(index)
        
        # Write array back to file
        overwrite(lines)
        
        # Return full task that was removed
        full
      end
      
      def move(prefix, move_hash)
        from  = move_hash.keys.first
        to    = move_hash.values.first
        if !lines_in_group(from).includes_prefix?(prefix)
          return false # Didn't contain this, can't move it
        end
        
        full = self.remove_from_group(from, prefix)
        self.append_to_group(to, full)
      end
      
      def search(prefix)
        lines = self.to_a
        offset = lines.includes_prefix?(prefix)
        group_name = group_at(offset)
        full = lines[offset]
        offset_in_group = offset - group_range(group_name).first
        [full, group_name, offset_in_group]
      end
      
      # Moves a task to the top of its group
      def promote(prefix)
        full, group_name, offset_in_group = search(prefix)
        self.remove_from_group(group_name, prefix)
        self.prepend_to_group(group_name, full)
      end
    
      def to_a
        file_handle.collect { |l| l.strip }
      end
      
      def group_range(group_name)
        group_name = group_name.to_s
      
        lines = []
        in_group = false      
        i = 0
        range_start = 0
        range_end = i
      
        file_handle.each do |line|
          is_heading = line.match(HEADING_REGEX)
          first_line = line.starts_with?(group_name, case_sensitive: false)
          is_other_heading = !first_line
          in_group = first_line || in_group && !is_heading
          
          range_start = i if first_line
          
          if in_group
            range_end = i
          end
        
          i += 1
        end
        
        Range.new(range_start, range_end)
      end
      
      def group_at(offset)
        group = ""
        file_handle.each_with_index do |line, i|
          if line.match(HEADING_REGEX)
            group = line[0../\W/ =~ line].strip
          end
          
          if i >= offset
            return group
          end
        end
        
        group
      end
      
      def overwrite(lines)
        handle = file_handle('w')
        lines.each {|l| handle.puts(l) }
        handle.close
      end
    
    end
    
  end
end