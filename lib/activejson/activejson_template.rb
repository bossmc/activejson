require 'activejson/activejson_core'

module ActionView
  module Template::Handlers
    class ActiveJsonTemplate
      class_attribute :default_format
      self.default_format = 'text/json'

      def compile(template) 
        %{ActiveJson::Core.new do |json|
          #{template.source}
        end.to_json }
      end

      def self.call(template)
        new.compile(template)
      end
    end
  end
end
