require 'yaml'
require 'sequel'
require 'datafactory/connectors/base'


module Datafactory
  module Connectors
    class SequelConnector < Base
      Sequel.extension :migration
      # monkey patch for factory_girl
      Sequel::Model.send :alias_method, :save!, :save
      def initialize(domain)
        @domain = domain
        @db_config = YAML::load(File.open("#{@domain}/#{self.class.config}"))
      end

      def self.config
        "sequel.yaml"
      end

      def setup(opts)
        @db = Sequel.connect(@db_config["uri"])
        Sequel::Model.db = @db
        if opts[:migrate]
          migrate
        end
        require_models
        require_factories
      end

      def migrate
        Sequel::Migrator.apply(@db, "#{@domain}/migrate")
      end

      def drop_db
        raise "not implemented"
      end

      def create_db
        raise "not implemented"
      end
    end
  end
end


