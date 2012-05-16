require 'minitest/autorun'
require 'minitest/unit'
require 'mocha'
require 'fileutils'

require_relative '../lib/toga'

describe Toga::CLI do
  before do
    # => pass
    @directory = File.expand_path(File.dirname(__FILE__) + '/test_output')
  end

  describe 'init' do
    it 'creates the file' do
      seed_togafile
    end
  end
  
  describe 'add' do
    before { seed_togafile }
    
    it 'adds a new task to the current group' do
      add_new_task('Run toga tests')
      
      assert Toga::Tasks.group(:current).includes_prefix?('Run toga t')
    end
  end
  
  describe 'complete' do
    before do
      seed_togafile
      add_new_task('Run toga tests')
    end
    
    it 'moves a task to the completed group' do
      Toga::Commands::Complete.run! ['Run toga t']
      
      refute Toga::Tasks.group(:current).includes_prefix?('Run toga t'), "Current group should NOT have task"
      Toga::Tasks.group(:completed).include?('Run toga tests').must_equal(true)
    end
  end
  
  describe 'uncomplete, current' do
    before do 
      seed_togafile
      add_new_task('Run toga tests')
      Toga::Commands::Complete.run! ['Run toga t']
    end
    
    it 'moves a task back to current group' do
      Toga::Commands::Uncomplete.run! ["Run toga t"]
      
      refute Toga::Tasks.group(:completed).includes_prefix?('Run toga t'), "Completed group should NOT have task"
      Toga::Tasks.group(:current).include?('Run toga tests').must_equal(true)
    end
  end
  
  after do
    # I hardcoded this so that the tests can't seriously screw you up
    safe_clean
  end
  
  def safe_clean
    temp_dir = File.expand_path(File.dirname(__FILE__) + '/test_output')
    if File.directory?(temp_dir)
      FileUtils.remove_dir(temp_dir)
    end
  end
  
  def seed_togafile
    test_togafile = File.join(@directory, Toga::TOGAFILE_NAME)
    Toga::Togafile.path = test_togafile
    
    Toga::Commands::Init.run! [@directory]
    File.directory?(@directory).must_equal(true)
    File.exists?(test_togafile).must_equal(true)
  end
  
  def add_new_task(task)
    Toga::Commands::Add.run! [task]
  end
end