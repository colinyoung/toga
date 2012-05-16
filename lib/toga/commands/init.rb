require 'fileutils'

module Toga
  module Commands
    
    class Init < Command
      
      def self.run!(args)
        dir = File.expand_path args.first
        
        # Recursively creates the file
        FileUtils.mkdir_p dir if !File.directory?(dir)
        
        # Copies the Togafile scaffold to the new Togafile
        File.open(File.expand_path(File.join(dir, Toga::TOGAFILE_NAME)), 'w') do |f|
          togafile = File.expand_path(File.join(Toga::SCAFFOLD_PATH, Toga::TOGAFILE_NAME))
          f.write File.open(togafile).read
        end
        
        "Created #{Toga::TOGAFILE_NAME} in #{dir}."
      end
      
    end
  end
end