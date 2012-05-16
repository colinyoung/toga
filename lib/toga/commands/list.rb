module Toga
  module Commands
    class List < Command
      
      def self.run!(*args)
        group_name = args.first.first || "current"
        puts Togafile.lines_in_group(group_name).to_a
      end
    end
  end
end