require 'thor'

module Datafactory
  class Cli < Thor
    include Thor::Actions
    source_root File.expand_path("../templates", File.dirname(__FILE__))
    $: << "."

    desc "up [DOMAIN]", "Load data for domain"
    def up(domain)
      flow = get_flow(domain)
      flow.run!(:down)
      flow.run!(:up)
    end

    desc "down [DOMAIN]", "Load data for domain"
    def down(domain)
      get_flow(domain).run!(:down)
    end

    method_option :connector
    desc "domain [DOMAIN]", "init a new data domain (database)"
    def domain(domain)
      say "Initializing #{domain}..."
      @namespace = domain.capitalize
      connector = options[:connector] || "activerecord"
      directory("connectors/#{connector}", domain)
    end

    desc "init [FLOW_NAME]", "make a new flow"
    def init(name)
      @flowname = name
      directory("flows")
      template("Gemfile")
      say "Running bundler..."
      say `bundle`
    end


    no_commands do
      def flowname
        @flowname
      end

      def get_flow(domain)
        require("flows/#{domain}")
        klass = Object.const_get(domain.capitalize)
        klass.new
      end
    end
  end
end
