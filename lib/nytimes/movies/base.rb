module NYTimes
  module Movies
    class Base
      
      #-----------------
      # Class Methods
      #-----------------
    
      class << self
        cattr_accessor :host, :protocol, :version, :base_url, :debug, :api_key

        def request path, params
          params = params.to_param
         params += ("&" + "api%2Dkey=#{URI.escape api_key}")
#          params = params.merge!(:'api-key' => api_key).to_param
          url = URI.escape "#{base_url}/#{path}.json?#{params}"
          response = nil
          seconds = Benchmark.realtime { response = open url }
          puts "  \e[4;36;1mREQUEST (#{sprintf("%f", seconds)})\e[0m   \e[0;1m#{url}\e[0m"# if debug
          response.is_a?(String) ? response : response.read
        rescue OpenURI::HTTPError => e
          puts "  \e[4;36;1mREQUEST (404)\e[0m   \e[0;1m#{url}\e[0m"# if debug
          nil
        end
      
        protected
          def settings
            @settings ||= YAML.load(File.open(File.dirname(__FILE__)+'/../../../config/settings.yml'))
          end
      end
    
      # These are the default settings for the Base class. Change them, even per subclass if needed.
      self.host = "api.nytimes.com"
      self.protocol = "http"
      self.version = "v2"
      self.base_url = "#{protocol}://#{host}/svc/movies/#{version}"
      self.api_key = settings['key']
      self.debug = true if ENV['DEBUG']

      #-----------------
      # Instance Methods
      #-----------------
      def initialize(values={})
        values.each { |k, v| send "#{k}=", v }
      end

      # Copied from ActiveRecord::Base
      def attribute_for_inspect(attr_name)
        value = send(attr_name)

        if value.is_a?(String) && value.length > 50
          "#{value[0..50]}...".inspect
        elsif value.is_a?(Date) || value.is_a?(Time)
          %("#{value.to_s(:db)}")
        else
          value.inspect
        end
      end
    end
  end
end

