require 'compare_linker'
require 'factory_girl'
require 'rspec'

Dir["#{__dir__}/support/**/*.rb"].each do |f|
  require f
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include LoadFixtureHelper

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
