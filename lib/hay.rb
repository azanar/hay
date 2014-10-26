require 'logger'

# Hay 
module Hay
  class << self
    def logger
      return @logger if @logger

      @logger = Logger.new(STDOUT)
      @logger.formatter = proc { |severity, datetime, progname, msg| 
        "[#{datetime}, #{severity}] #{msg}\n"
      }
      @logger
    end

    def logger=(logger)
      @logger = logger
    end
  end
end
