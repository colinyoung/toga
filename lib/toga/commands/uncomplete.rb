module Toga
  module Commands
    class Uncomplete < Command
      
      def self.run!(*args)
        prefix = args.join(' ')
        Togafile.move prefix, :completed => :current
      end
    end
  end
end