module Toga
  module Commands
    class Later < Command
      
      def self.run!(*args)
        if args.first && args.first.count == 0
          puts Commands::List.run! [:later]
        end
        Togafile.append_to_group :later, args.join(' ')
        Togafile.lines_in_group :later
      end
    end
  end
end