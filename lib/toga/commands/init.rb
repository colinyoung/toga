require 'fileutils'
require 'git'

module Toga
  module Commands
    
    class Init < Command
      
      def self.run!(args)
        dir = File.expand_path args.first
        
        # Recursively creates the file
        FileUtils.mkdir_p dir if !File.directory?(dir)
        
        # Copies the Togafile scaffold to the new Togafile
        new_togafile = File.expand_path(File.join(dir, Toga::TOGAFILE_NAME))
        unless File.exists?(new_togafile)
          File.open(new_togafile, 'w') do |f|
            togafile = File.expand_path(File.join(Toga::SCAFFOLD_PATH, Toga::TOGAFILE_NAME))
            f.write File.open(togafile).read
          end
        end
        
        # Add togafile to the .gitignore.
        begin
          git = Git.open(File.expand_path(File.join(dir)))
          if !git.status.ignored.keys.include?(Toga::TOGAFILE_NAME)
          
            File.open(File.expand_path(File.join(dir, '.gitignore')), 'a') do |f|
              f.write Toga::TOGAFILE_NAME
            end
          end
        rescue
          puts "Couldn't find .gitignore, so Togafile won't be ignored by git."
        end
        
        "Created #{Toga::TOGAFILE_NAME} in #{dir}."
      end
      
    end
  end
end