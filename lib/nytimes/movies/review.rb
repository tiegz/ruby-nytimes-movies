module NYTimes
  module Movies
    # This class represents a movies review in the NYTimes database.
    class Review < Base
      attr_accessor :title, :uri

      #-----------------
      # Class Methods
      #-----------------

      class << self
        # Search for all reviews with a query.
        # 
        # ==== Examples
        #
        #   NYTimes::Movies::Review('neon')
        #   > ...
        def search(query, options={})
          options.symbolize_keys!

          params         = {}
          params[:query] = URI.escape(query)

          response = request "reviews/search", params
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end
      end
    end
  end
end