require File.join File.dirname(__FILE__), 'list.rb'

module Toga
  module Commands
    class Current < List
      
      def self.run!(*args)
        if !args.first || args.first.count == 0
          return super [:current]
        end

        # Make a task current.
        prefix = args.join(' ')
        full = Togafile.remove_from_group :later, prefix
        if !full
          return error "Wasn't found."
        end
        Togafile.append_to_group :current, full
        puts "Moved '#{full}' to current tasks."
      end
    end
  end
end