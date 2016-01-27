require 'mongoid'
require 'logger'
require 'datafactory/connectors/base'

module Datafactory
  module Connectors
    class MongoidConnector < Base
      def initialize(domain)
        @domain = domain
      end
      
      def self.config
        "mongoid.yaml"
      end

      def setup(opts)
        Mongo::Logger.logger.level = Logger::INFO
        Mongoid.logger.level = Logger::INFO
        Mongoid.load!("#{@domain}/#{self.class.config}", ENV["RACK_ENV"] || "development")
        require_models
        require_factories
      end
    end
  end
end
