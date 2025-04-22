# Rails 8.0.2 uses Propshaft instead of Sprockets
# This provides compatibility for code expecting the old asset pipeline

# Define assets configuration for backwards compatibility
module Rails
  class Application
    class Configuration
      def assets
        @assets ||= begin
          options = ActiveSupport::OrderedOptions.new
          options.version = '1.0'
          options.precompile = []
          
          # Create a paths array that responds to 
          paths = []
          def paths.<<(path)
            self.push(path)
          end
          options.paths = paths
          
          options
        end
      end
    end
  end
end

# Add default precompile patterns
Rails.application.config.assets.precompile += %w(
  actiontext.js actiontext.esm.js trix.js trix.css
)