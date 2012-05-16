module Toga
  
  # The main root class of Toga
  class CLI
    
    include Error
    
    attr_accessor :args
    attr_accessor :options
    attr_accessor :return_value
    
    def initialize(*args)
      @args = args
      @return_value = 0
      
      return usage! if args.length == 0
      
      cmd = @args.shift
      
      begin
        @command = Commands.const_get(cmd.capitalize)
      rescue
        if !@command
          fail "Invalid command '#{cmd}'.", "Type `toga` or `toga help` for usage"
          return
        end
      end
        
      @command.run! @args
    end
    
    def usage!
      path = File.expand_path(File.dirname(__FILE__) + '/../../USAGE')
      $stdout.puts File.open(path).read
    end
    
  end
end