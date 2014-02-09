$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "foundation-static/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "foundation-static"
  s.version     = FoundationStatic::VERSION
  s.authors     = ["Harssh S Shrivastava"]
  s.email       = ["harssh122@gmail.com"]
  s.homepage    = "none"
  s.summary     = "Converts foundation to static"
  s.description = "Converts foundation to static"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "sass", [">= 3.2.0"]
  s.add_dependency "zurb-foundation", ["~>4.3.2"]
  s.add_development_dependency "sqlite3"
end
