module NYTimes
  module Movies
    # This class represents a movie critic in the NYTimes database.
    class Critic < Base
      attr_accessor :image, :sort_name, :seo_name, :bio, :display_name, :status


      #-----------------
      # Class Methods
      #-----------------

      class << self
        # Retrieve all critics.
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Critic.all
        #   > [#<NYTimes::Movies::Critic:0x1185550>, ...]
        def all
          params = {}

          response = request "critics/all", params
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end

        # Retrieve all full-time critics.
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Critic.full_time
        #   > [#<NYTimes::Movies::Critic:0x1185550>, ...]
        def full_time
          params = {}

          response = request "critics/full-time", params
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end


        # Retrieve all part-time critics.
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Critic.part_time
        #   > [#<NYTimes::Movies::Critic:0x1185550>, ...]
        def part_time
          params = {}

          response = request "critics/part-time", params
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end

        # Retrieve a specific critic.
        #
        # ==== Attributes
        #
        # * +name+ - the name of the critic
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Critic.part_time
        #   > [#<NYTimes::Movies::Critic:0x1185550>, ...]
        def find(name)
          return name if name.is_a? Critic

          params = {}

          name = string_to_alias(name)
          response = request "critics/#{name}", params
          raise Error, "That critic not found!" if response.nil? || response.empty?
          parse_one response
        end

        protected
        # Parses a response json string for critics.
        def parse_many(body) # :nodoc:
          json = ActiveSupport::JSON.decode(body)
          results = json['results']
          results.map { |result|
            instantiate result
          }
        end

        # Parses a response json string for a critic.
        def parse_one(body) # :nodoc:
          json = ActiveSupport::JSON.decode(body)
          result = json['results'].first
          instantiate result
        end
        
        def instantiate(entry={})
          Critic.new(:image => (Image.new(entry["multimedia"]["resource"]) rescue nil), 
            :sort_name => entry["sort_name"], 
            :seo_name => entry["seo_name"], 
            :bio => entry["bio"], 
            :display_name => entry["display_name"], 
            :status => entry["status"])
        end
        
      end
    end
  end
end