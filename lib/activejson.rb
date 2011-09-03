require 'activejson/activejson_template'
ActionView::Template.register_template_handler :activejson, ActionView::Template::Handlers::ActiveJsonTemplate
