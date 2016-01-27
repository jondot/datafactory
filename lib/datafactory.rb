require "datafactory/version"
require "logger"

module Datafactory
  def self.log
    @log ||= Logger.new($stdout)
    @log
  end
end

