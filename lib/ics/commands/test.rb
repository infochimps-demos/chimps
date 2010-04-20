require 'ics/commands/base'
require 'ics/request'

module ICS
  module Commands
    class Test < ICS::Command

      PATH = 'test_api_authentication.json'

      BANNER = "usage: ics test"
      HELP = <<EOF

Print diagnostic information on the API credentials being used by ics
and send a test request to Infochimps to make sure the API credentials
work.

EOF
      
      def execute!
        puts "Reading identity file at #{CONFIG[:identity_file]}" if ICS.verbose?
        response = ICS::Request.new(PATH, :sign => true).get
        if response.blank?
          puts "ERROR! Could not authenticate with Infochimps"
        else
          puts "SUCCESS"
          response.print
        end
      end

    end
  end
end

