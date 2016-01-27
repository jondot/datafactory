require 'yaml'
require 'active_record'
require 'datafactory/connectors/base'

module Datafactory
  module Connectors
    class ActiveRecordConnector < Base
      def initialize(domain)
        @domain = domain
        @db_config = YAML::load(File.open("#{@domain}/#{self.class.config}"))
      end

      def self.config
        "activerecord.yaml"
      end

      def setup(opts)
        ActiveRecord::Base.establish_connection(@db_config)
        if opts[:migrate]
          migrate
        end
        require_models
        require_factories
      end

      def drop_db
        return unless @db_config["adapter"] == "pg"
        db_config_admin = @db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})
        ActiveRecord::Base.establish_connection(db_config_admin)
        ActiveRecord::Base.connection.drop_database(@db_config["database"])
      end

      def create_db
        return unless @db_config["adapter"] == "pg"
        db_config_admin = @db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})
        ActiveRecord::Base.establish_connection(db_config_admin)
        ActiveRecord::Base.connection.create_database(@db_config["database"])
      end

      def migrate
        ActiveRecord::Migrator.migrate("#{@domain}/migrate")
      end
    end
  end
end
