root = File.join(File.dirname(__FILE__), "..")
require "foundation-static/version"

if defined?(Rails::Generators::Base)
  require "foundation-static/generators/install_generator"
end


module FoundationStatic
end
