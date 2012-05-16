require File.join File.dirname(__FILE__), 'list.rb'

module Toga
  module Commands
    class Current < List
      
      def self.run!(*args)
        super [:current]
      end
    end
  end
end