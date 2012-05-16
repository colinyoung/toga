module Toga
  module Commands
    class Add < Command
      
      def self.run!(*args)
        Togafile.append_to_group :current, args.join(' ')
      end
    end
  end
end