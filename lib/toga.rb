$:.unshift File.dirname(File.join(__FILE__))

module Toga
  SCAFFOLD_PATH = File.join(File.dirname(__FILE__), 'toga/scaffold')
  TOGAFILE_NAME = 'Togafile'
end

require "toga/extensions"
require "toga/version"
require "toga/error"
require "toga/togafile"
require "toga/tasks"
require "toga/command"
Dir.glob(File.dirname(__FILE__) + '/toga/commands/*', &method(:require))
require "toga/cli"
