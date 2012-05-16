module Toga
  module Commands
    class List < Command
      
      def self.run!(*args)
        out = ""
        
        group_names = args.first.empty? ? [:current, :later] : args.first
        group_names.each_with_index do |n, i|
          out << Togafile.lines_in_group(n).join("\n")
          if i < group_names.length-1 then out << ""; end
        end
        
        out
      end
    end
  end
end