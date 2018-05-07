require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../spec/test_app_templates', __dir__)

  def remove_index
    remove_file "public/index.html"
    remove_file 'app/assets/images/rails.png'
  end

  def install_blacklight
    say_status("warning", "GENERATING BL", :yellow)

    generate 'blacklight:install', '--devise'
  end

  def run_test_support_generator
    say_status("warning", "GENERATING test_support", :yellow)

    generate 'blacklight:test_support'
  end

  def install_engine
    say_status("warning", "GENERATING BL-MARC", :yellow)

    generate 'blacklight:marc:install'
  end
end

