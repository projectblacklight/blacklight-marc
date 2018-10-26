require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  def fix_travis_rails_4
    if ENV['TRAVIS']
      insert_into_file 'app/assets/stylesheets/application.css', :before =>'/*' do
        "@charset \"UTF-8\";\n"
      end
    end
  end

  def remove_index
    remove_file "public/index.html"
  end

  def install_rsolr
    say_status("warning", "INSTALLING RSOLR", :yellow)
    system "bundle exec gem install rsolr --version '~>2.0'"
  end

  def run_blacklight_generator
    say_status("warning", "GENERATING BL", :yellow)
    generate 'blacklight:install', '--devise'
  end

  def run_test_support_generator
    say_status("warning", "GENERATING test_support", :yellow)

    generate 'blacklight:test_support'
  end

  def run_blacklight_marc_generator
    generate 'blacklight:marc:install'
  end
end
