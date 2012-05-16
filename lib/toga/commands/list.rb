module Toga
  module Commands
    class List < Command
      
      def self.run!(*args)
        group_names = args.first.empty? ? [:current, :later] : args.first
        group_names.each_with_index do |n, i|
          puts Togafile.lines_in_group(n)
          if i < group_names.length-1 then puts ""; end
        end
      end
    end
  end
end