require 'bundler'
require 'rails'

Bundler.require :default, :development

Combustion.initialize! :action_controller

require 'rspec/rails'
require 'support/active_record'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
