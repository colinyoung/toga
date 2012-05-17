module Toga
  module Commands
    class Completed < Command
      
      def self.run!(*args)
        puts Commands::List.run! [:completed]
      end
    end
  end
end