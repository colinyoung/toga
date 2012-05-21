module Toga
  class Config
    
    attr_accessor :data
    attr_accessor :path
    
    def initialize(path)
      self.data = {}
      @path = path
      
      read!
    end
    
    def self.load!
      f = File.join(Dir.getwd, Toga::CONFIGFILE_NAME)
      self.new(f)
    end
    
    def read!
      begin
        handle = File.open(@path, 'r')
      rescue
        # File doesn't exist yet
        File.open(@path, 'w') {}
        return
      end
      
      handle.each do |l|
        pair = l.split('=')
        key = pair.first
        value = pair.last
        if key.nil? or key.strip.empty? or value.nil? or value.strip.empty?
          next
        end
        self.data[key.to_sym] = value.strip
      end
    end
    
    def save!
      File.open(@path, 'w') do |l|
        self.data.each do |key, value|
          l.puts "#{key}=#{value}"
        end
      end
    end
    
    def method_missing(*args)
      name = args.shift.to_s
      
      # Setter
      if name[name.length-1] == "="
        attribute = name.gsub(/[^A-z_]+/, '').to_sym
        self.data[attribute] = args.first.strip
        self.save!
        return self.data[attribute]
      end
      
      # Getter
      name = name.to_sym
      return @data[name].strip if @data.has_key?(name)
      
      nil
    end
    
  end
end