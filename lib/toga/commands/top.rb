module Toga
  module Commands
    class Top < Command
      
      def self.run!(*args)
        # Move the given task to the top of the group
        if args.first && args.first.count > 0
          Togafile.promote(args.first.join(' '))
        end
        
        lines = Togafile.lines_in_group(:current)        
        
        lines.shift
        lines.delete_if {|l| l.strip.length == 0 }
        
        lines.first
      end
    end
  end
end