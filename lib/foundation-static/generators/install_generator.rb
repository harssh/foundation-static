require 'rails/generators'

module FoundationStatic
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      class_option :haml, :desc => 'Generate HAML layout instead of erb', :type => :boolean
      class_option :slim, :desc => 'Generate Slim layout instead of erb', :type => :boolean

     
     def check_foundation_exists
       display "Begining, FoundationStatic installaton process!", :blue
       display "FoundationStatic needs zurb-foundation :"
        display "Checking for a zurb-doundation..."
        unless defined?(Foundation)
          display "Adding zurb-foundation gem to your Gemfile:"
          append_file "Gemfile", "\n", :force => true
          gem 'zurb-foundation'
          Bundler.with_clean_env do
            run "bundle install"
          end
        else
          display "Foundation is installed already !"
        end
        unless File.exists?(Rails.root.join("app/assets/stylesheets/foundation_and_overrides.scss"))
          display "Looks like you don't have foundation installed! We'll install it for you:"
          generate "foundation:install"
        else
          display "Looks like you've already installed it, good!"
        end       
     end


      def add_to_assets
         insert_into_file "app/assets/stylesheets/foundation_and_overrides.scss", File.read("../templates","custom_variables.scss"), :after => "@import 'foundation';\n"
      end

      
      def edit_layout
        if options.haml?||(defined?(Haml) && options.haml?)
         comment_lines '%meta{ :name => "viewport", :content => "width=device-width, initial-scale=1.0" }', 'application.html.haml'
        elsif options.slim?||(defined?(Slim) && options.slim?)
         comment_lines 'meta name="viewport" content="width=device-width, initial-scale=1.0', 'application.html.slim'
        else
          comment_lines '<meta name="viewport" content="width=device-width, initial-scale=1.0" />', 'application.html.erb'
        end
      end

      private

      def file_name
        layout_name.underscore.downcase
      end
    end
  end
end
