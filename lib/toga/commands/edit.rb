require 'ruby-debug'

module Toga
  module Commands
    class Edit < Command
      
      def self.run!(*args)
        config = Config.load!
        if config.editor.nil?
          puts "Type the console command you use to launch your text editor (e.g. vi, emacs, vim, mate, nano...)"
          config.editor = $stdin.gets.strip
        end
        
        # Tailor arguments for specific editors
        args = []
        case config.editor
        when "mate"
          args.push "-a"
        end
          
        puts "#{config.editor} #{Dir.getwd}/#{Toga::TOGAFILE_NAME} #{args.join(" ")}"
        system "#{config.editor} #{Dir.getwd}/#{Toga::TOGAFILE_NAME} #{args.join(" ")}"
      end
    end
  end
end