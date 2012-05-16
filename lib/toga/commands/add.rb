module Toga
  module Commands
    class Add < Command
      
      def self.run!(*args)
        Togafile.append_to_group :current, args.join(' ')
        puts Togafile.lines_in_group :current
      end
    end
  end
end