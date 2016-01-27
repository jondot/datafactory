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
    
    def log
      @log ||= Logger.new($stdout)
      @log
    end

    def use(domain, opts={migrate:true})
      log.info("use: #{domain}")
      connector(domain).setup(opts)
    end

    def drop_db(domain)
      log.info("drop: #{domain}")
      connector(domain).drop_db
    end
    
    def create_db(domain)
      log.info("drop: #{domain}")
      connector(domain).create_db
    end

    def up; end
    def down; end
    
    def run!(meth)
      tagline = "===== #{meth}: #{self.class.name} "
      log.info(tagline + "="*(63-tagline.length))
      b = Benchmark.measure do
        self.send(meth)
      end
      log.info("===== took: #{b.to_s.chomp} =====")
      log.info("")
    end

  private
    def connector(domain)
      path = Pathname.new(Dir["#{domain}/*.yaml"].first)
      CONNECTORS.find{|c| c.configured_by?(path.basename.to_s) }.new(domain)
    end
  end
end
