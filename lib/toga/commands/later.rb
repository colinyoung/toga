module Toga
  module Commands
    class Later < Command
      
      def self.run!(*args)
        Togafile.append_to_group :later, args.join(' ')
        Togafile.lines_in_group :later
      end
    end
  end
end