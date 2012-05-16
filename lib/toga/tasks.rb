module Toga
  class Tasks
    
    def self.group(group_name)
      Toga::Togafile.lines_in_group(group_name)
    end
    
  end
end
