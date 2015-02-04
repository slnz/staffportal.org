require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(assets: %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Staff
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.initialize_on_precompile = false
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.logger = Logger.new(STDOUT)
    config.assets.initialize_on_precompile = false
    config.i18n.enforce_available_locales = false
    config.autoload_paths << Rails.root.join('app/observers')
    config.active_record.observers = :user_observer, :'User::DocumentObserver'
  end
end
