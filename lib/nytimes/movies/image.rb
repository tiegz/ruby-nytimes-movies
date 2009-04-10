module NYTimes
  module Movies
    class Image
      attr_accessor :url, :width, :height, :credit, :type
      def initialize(entry)
        self.url    = entry["src"]    # "http://graphics8.nytimes.com/images/2007/03/02/movies/someone.123.jpg"
        self.width  = entry["width"]  # nil
        self.height = entry["height"] # nil
        self.credit = entry["credit"] # "Someone/<br>The New York Times",
        self.type   = entry["type"]   # "image"
      end
    end
  end
end