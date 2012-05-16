module Toga
  module Commands    
    class Remove < Command
      
      def self.run!(*args)
        out = ""
        
        removed = Togafile.remove_from_group :current, args.join(' ')
        out << removed ? "Removed '#{removed}'.\r\n\r\n" : ""
        out << Togafile.lines_in_group(:current)
        
        out
      end
    end
  end
end