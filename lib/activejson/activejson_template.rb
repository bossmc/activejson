require 'activejson/activejson_core'

module ActionView
  module Template::Handlers
    class ActiveJsonTemplate < Template::Handler
      include Compilable

      def compile(template) 
        %{ActiveJson::Core.new do |json|
          #{template.source}
        end.to_json }
      end
    end
  end
end
