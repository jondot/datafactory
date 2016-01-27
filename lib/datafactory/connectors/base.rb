module Datafactory
  module Connectors
    class Base
      def self.configured_by?(conf)
        config == conf
      end
      
      def require_models
        Dir.glob("#{@domain}/models/*.rb").each do |m|
          require m
        end
      end

      def require_factories
        require "#{@domain}/factories.rb"
      end
    end
  end
end

