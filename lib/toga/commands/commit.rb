require 'git'
require 'yaml'

module Toga
  module Commands
    class Commit < Command
      include Error
      
      def self.run!(args)
        git = Git.open(Dir.getwd)
        untracked = git.status.untracked!.keys
        modified = git.status.modified.keys
        
        # Get the git message to commit with
        message = Toga::Commands::Top.run!
        if args.count > 0
          task_search = args.join(' ')
          full, group, offset = Togafile.search(task_search)
          message = full
        end
        
        puts "Committing task:\n  #{message}\n\n"
        
        # Show the user the files they're leaving behind and ask to continue or die
        if untracked.count > 0 || modified.count > 0
          if untracked.count > 0
            puts error("You didn't add the following files:\n")
            puts untracked.join("\n") + "\n\n"
          end
          
          if modified.count > 0
            puts error("The following files are modified, but their changes aren't added:\n")
            puts modified.join("\n") + "\n\n"
          end
          
          puts "Continue committing? [y/a/n] (y: continue, don't stage; a: add them using git add .; n: cancel/exit)"
          continue = $stdin.gets
          response = continue[0].downcase
          if !["a", "y"].include? response
            return 0
          end
          
          if response == "a"
            git.add('.')
            puts "Added:\n" + (untracked + modified).join("\n")
          end
        end
        
        # Okay, files are all ready for commit. Prepare git commit.
        `git commit -m "#{message.gsub(/"/, '\"')}"`
      end
    end
  end
end