require 'ics/commands/base'
require 'ics/request'
require 'ics/commands/uses_model'

module ICS
  module Commands
    class Search < ICS::Command

      # Default number of search results returned.
      DEFAULT_LIMIT  = 20
      
      BANNER = "usage: ics search [OPTIONS] QUERY"
      HELP   = <<EOF

Perform a search on Infochimps.  By default the search will be of
datasets and will return #{DEFAULT_LIMIT} datasets that match the
given QUERY.
EOF
      
      # Path to search resource
      PATH   = 'search.json'
      
      # Models this command applies to (default first)
      MODELS = %w[dataset collection source license field]
      include ICS::Commands::UsesModel


      def limit
        @limit ||= DEFAULT_LIMIT
      end

      def define_options
        on_tail("-n", "--num-results NUM", "Return the given number of results instead of the default #{DEFAULT_LIMIT}") do |n|
          @limit = n.to_i
        end
        
      end

      def query
        raise CLIError.new("Must provide a query to search for") if argv.blank?
        argv.join(' ')
      end

      def params
        {
          :query => query,
          :model => model,
          :limit => limit
        }
      end

      def execute!
        ICS::Request.new(PATH, :params => params).get.print
      end
    end
  end
end

