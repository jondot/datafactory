require 'pathname'
require 'factory_girl'
require 'faker'
require "datafactory/connectors/activerecord"
require "datafactory/connectors/sequel"
require "datafactory/connectors/mongoid"


module Datafactory
  module Dataflow
    include FactoryGirl::Syntax::Methods
    
    CONNECTORS = [
      Connectors::ActiveRecordConnector,
      Connectors::MongoidConnector,
      Connectors::SequelConnector
    ]
    
    def use(domain, opts={migrate:true})
      connector(domain).setup(opts)
    end

    def drop_db(domain)
      connector(domain).drop_db
    end
    
    def create_db(domain)
      connector(domain).create_db
    end


    def up; end
    def down; end

  private
    def connector(domain)
      path = Pathname.new(Dir["#{domain}/*.yaml"].first)
      CONNECTORS.find{|c| c.configured_by?(path.basename.to_s) }.new(domain)
    end
  end
end
