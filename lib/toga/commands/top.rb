module Toga
  module Commands
    class Top < Command
      
      def self.run!(*args)
        lines = Togafile.lines_in_group(:current)
        lines.shift
        lines.delete_if {|l| l.strip.length == 0 }
        
        lines.first
      end
    end
  end
end