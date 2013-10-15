require 'ostruct'
require 'yaml'

config = YAML.load(ERB.new(File.read(File.join(Rails.root,'config','app_config.yml'))).result) || {}
AppConfig = OpenStruct.new(config[Rails.env] || {})

