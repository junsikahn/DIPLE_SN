require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DIPLE
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Seoul'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ko

    # Disable the generator for coffee & scss files when creating controller
    config.generators do |g|
      g.assets          false
      g.jbuilder        false
      g.helper          false
      g.test_framework  nil
      g.template_engine nil
    end

    config.action_view.embed_authenticity_token_in_remote_forms = true

    config.middleware.use ExceptionNotification::Rack,
                          email: {
                            # Rails >= 4.2.1 do not need this option since it defaults to :deliver_now
                            deliver_with: :deliver_now,
                            email_prefix: '[Server ERROR] ',
                            sender_address: %("Server ERROR" <notice@vaskit.kr>),
                            exception_recipients: ['junsikahn@vaskit.kr', 'sunghomoon@vaskit.kr']
                          }
    #                       slack: {
    #                         webhook_url: "https://hooks.slack.com/services/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",
    #                         channel: '#test',
    #                         additional_parameters: {
    #                           mrkdwn: true
    #                         }
    #                       }
  end
end
