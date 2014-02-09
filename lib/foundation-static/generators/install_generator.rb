require 'rails/generators'

module FoundationStatic
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')
      
     
     def check_foundation_exists
       say("           -Begining, FoundationStatic installaton process!", :blue)
       say("FoundationStatic needs zurb-foundation :")
      say("Checking for a zurb-doundation...")
        unless defined?(Foundation)
          say("Adding zurb-foundation gem to your Gemfile:")
          append_file "Gemfile", "\n", :force => true
          gem 'zurb-foundation'
          Bundler.with_clean_env do
            run "bundle install"
          end
        else
          say("Foundation is installed already !")
        end
        unless File.exists?(Rails.root.join("app/assets/stylesheets/foundation_and_overrides.scss"))
          say("Looks like you don't have foundation installed! We'll install it for you:")
          generate "foundation:install"
        else
          say("Looks like you've already installed it, good!")
        end       
     end


      def add_to_assets
         variable_source = File.join(File.dirname(__FILE__),"templates","custom_variable.scss")
         insert_into_file "app/assets/stylesheets/foundation_and_overrides.scss",File.read(variable_source), :after => "@import 'foundation';\n"
      end

      
      
    end
  end
end
