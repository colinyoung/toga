module Toga
  module Commands    
    class Remove < Command
      
      def self.run!(*args)
        removed = Togafile.remove_from_group :current, args.join(' ')
        puts removed ? "Removed '#{removed}'.\r\n\r\n" : ""
        puts Togafile.lines_in_group :current
      end
    end
  end
end