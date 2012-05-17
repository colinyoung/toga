module Toga
  module Commands
    class Strip < Command
      
      def self.run!(*args)
        Togafile.strip!
      end
    end
  end
end