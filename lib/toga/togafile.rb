module Toga
  class Togafile
    
    CATEGORY_HEADINGS = ['CURRENT', 'COMPLETED', 'LATER'] 
    
    def self.path
      @@path
    end
    def self.path=(path)
      @@path = path
    end
    path = File.expand_path(File.join(Dir.getwd, Toga::TOGAFILE_NAME))
    
    def self.file_handle
      File.open(self.path, 'r')
    end
    
    def self.lines_in_group(group_name)
      group_name = group_name.to_s
      
      lines = []
      other_headings = CATEGORY_HEADINGS - [group_name.upcase]
      in_group = false      
      i = 0
      
      file_handle.each do |line|
        is_heading = line.starts_with?(CATEGORY_HEADINGS, case_sensitive: false)
        is_other_heading = line.starts_with?(other_headings, case_sensitive: false)
        in_group = line.starts_with?(group_name, case_sensitive: false) || in_group && !is_heading
                  
        if in_group && !is_heading && line.strip.length > 0
          lines << line.strip
        end
        
        i += 1
      end
      
      lines
    end
    
  end
end