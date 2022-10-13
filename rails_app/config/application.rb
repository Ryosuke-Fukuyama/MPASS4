require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.action_controller.include_all_helpers = false #ヘルパーの使用を限定する
    # config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
                       model_specs: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
    end
  end
end
