module NYTimes
  module Movies
    # This class represents a movies review in the NYTimes database.
    class Review < Base
      attr_accessor :byline, :capsule_review, :critics_pick, :date_updated, :display_title, 
        :dvd_release_date, :headline, :link, :mpaa_rating, :nyt_movie_id, :opening_date, 
        :publication_date, :related_urls, :seo_name, :sort_name, :summary_short, :thousand_best

      #-----------------
      # Class Methods
      #-----------------

      class << self
        # Search for all reviews with a query.
        #
        # ==== Attributes
        #
        # * +query+ - The search term to find a review
        # * +options+ - 
        #    * <tt>:critic_picks</tt> - +true+ to include only NYT Critic Picks, +false+ to exclude them.
        #    * <tt>:thousand_best</tt> - +true+ to include only NYTimes The Best 1,000 Movies Ever Made, +false+ to exclude them.
        #    * <tt>:dvd</tt> - +true+ to include only dvd-released, +false+ to exclude them.
        #    * <tt>:reviewer</tt> - NOT IMPLEMENTED YET
        #    * <tt>:publication_date</tt> - either a Time/Date/DateTime, or a Range of start to end Time/Date/Datetimes, for the article pubdate
        #    * <tt>:opening_date</tt> - either a Time/Date/DateTime, or a Range of start to end Time/Date/Datetimes, for the movie pubdate
        #    * <tt>:page</tt> - the page number of results; 20 shown at a time (default is 1)
        #    * <tt>:order</tt> - one of four values to sort by: title, publication_date, opening_date, dvd_release_date
        #      by-title by-publication-date | by-opening-date | by-dvd-release-date
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Review.search('neon')
        #   > [#<NYTimes::Movies::Review:0x1185550>, ...]
        def search(query, options={})
          options.symbolize_keys!

          params                   = {}
          params[:query]           = URI.escape(query)
          params[:offset]          = ((options[:page] - 1) * 20) if params[:page]
          params[:order]           = "by-#{options[:order].downcase.gsub(/_/,'-')}" if options[:order]
          params[:'critic-picks']  = (options[:critic_picks] ? 'Y' : 'N') if options[:critic_picks]
          params[:'thousand-best'] = (options[:thousand_best] ? 'Y' : 'N') if options[:thousand_best]
          params[:dvd] = (options[:dvd] ? 'Y' : 'N') if options[:dvd]
          if date = options[:publication_date]
            params[:'publication-date'] = (date.is_a?(Range) ? "#{date.begin.to_date.strftime("%Y-%m-%d");date.begin.to_date.strftime("%Y-%m-%d")}" : date.to_date.strftime("%Y-%m-%d"))
          end
          if date = options[:opening_date]
            params[:'opening-date'] = (date.is_a?(Range) ? "#{date.begin.to_date.strftime("%Y-%m-%d");date.begin.to_date.strftime("%Y-%m-%d")}" : date.to_date.strftime("%Y-%m-%d"))
          end

          response = request "reviews/search", params
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end
        
        # Retrieve all reviews.
        #
        # ==== Attributes
        #
        # * +options+ - 
        #    * <tt>:page</tt> - the page number of results; 20 shown at a time (default is 1)
        #    * <tt>:order</tt> - one of four values to sort by: title, publication_date, opening_date, dvd_release_date
        #      by-title by-publication-date | by-opening-date | by-dvd-release-date
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Review.all
        #   > [#<NYTimes::Movies::Review:0x1185550>, ...]
        def all(options={})
          options.symbolize_keys!

          params                   = {}
          params[:offset]          = ((options[:page] - 1) * 20) if params[:page]
          params[:order]           = "by-#{options[:order].downcase.gsub(/_/,'-')}" if options[:order]

          response = request "reviews/all", params
          puts "\nresponse is #{response.inspect}\n"
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end

        # Retrieve all NYT Critics' Picks in theatres right now.
        #
        # ==== Attributes
        #
        # * +options+ - 
        #    * <tt>:page</tt> - the page number of results; 20 shown at a time (default is 1)
        #    * <tt>:order</tt> - one of four values to sort by: title, publication_date, opening_date, dvd_release_date
        #      by-title by-publication-date | by-opening-date | by-dvd-release-date
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Review.critic_picks_in_theatre
        #   > [#<NYTimes::Movies::Review:0x1185550>, ...]
        def critic_picks_in_theatre(options={})
          options.symbolize_keys!

          params                   = {}
          params[:offset]          = ((options[:page] - 1) * 20) if params[:page]
          params[:order]           = "by-#{options[:order].downcase.gsub(/_/,'-')}" if options[:order]

          response = request "reviews/picks", params
          puts "\nresponse is #{response.inspect}\n"
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end
        
        # Retrieve all NYT Critics' Picks on dvd.
        #
        # ==== Attributes
        #
        # * +options+ - 
        #    * <tt>:page</tt> - the page number of results; 20 shown at a time (default is 1)
        #    * <tt>:order</tt> - one of four values to sort by: title, publication_date, opening_date, dvd_release_date
        #      by-title by-publication-date | by-opening-date | by-dvd-release-date
        #
        # ==== Examples
        #
        #   NYTimes::Movies::Review.critic_picks_on_dvd
        #   > [#<NYTimes::Movies::Review:0x1185550>, ...]
        def critic_picks_on_dvd(options={})
          options.symbolize_keys!

          params                   = {}
          params[:offset]          = ((options[:page] - 1) * 20) if params[:page]
          params[:order]           = "by-#{options[:order].downcase.gsub(/_/,'-')}" if options[:order]

          response = request "reviews/dvd-picks", params
          puts "\nresponse is #{response.inspect}\n"
          raise Error, "No reviews found!" if response.nil? || response.empty?
          parse_many response
        end
        
        
        protected
        # Parses a response json string for reviews.
        def parse_many(body) # :nodoc:
          json = ActiveSupport::JSON.decode(body)
          results = json['results']
          results.map { |result|
            instantiate result
          }
        end

        # Parses a response xml string for a review.
        def parse_one(body) # :nodoc:
        end
        
        def instantiate(entry={})
          puts "\n\nThe nentry is #{entry.inspect}\n"
          Review.new(:byline => entry["byline"], 
            :capsule_review => entry["capsule_review"], 
            :critics_pick => entry["critics_pick"], 
            :date_updated => entry["date_updated"], 
            :display_title => entry["display_title"], 
            :dvd_release_date => entry["dvd_release_date"], 
            :headline => entry["headline"], 
            :link => entry["link"], 
            :mpaa_rating => entry["mpaa_rating"], 
            :nyt_movie_id => entry["nyt_movie_id"], 
            :opening_date => entry["opening_date"], 
            :publication_date => entry["publication_date"], 
            :related_urls => entry["related_urls"], 
            :seo_name => entry["seo-name"],
            :sort_name => entry["sort_name"], 
            :summary_short => entry["summary_short"], 
            :thousand_best => entry["thousand_best"])
        end
        
      end
    end
  end
end