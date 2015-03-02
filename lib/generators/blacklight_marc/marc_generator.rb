module BlacklightMarc
  class MarcGenerator < Rails::Generators::Base

    def generate_blacklight_marc_install
      say "blacklight_marc:marc generator is deprecated; use blacklight:marc:install instead", :red
      generate "blacklight:marc:install"
    end
  end
end