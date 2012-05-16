module Toga
  module Error
  
    def self.included(base)
      base.extend(ClassMethods)
      base.send :include, ClassMethods
    end
  
    module ClassMethods
    
      def error(*args)
        args.map {|a| puts "[Toga] Error: " + a }
      end
    
      def fail(*args)
        args.map {|a| puts "[Toga] Failure: " + a }
      end
    end
  end
end