require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'json'

module GemfileUtils
  module Parser
    class RubyGems
      API_URL = 'https://rubygems.org/api/v1/gems/'.freeze

      attr_reader :gems, :connection, :responses

      def initialize(gems)
        @gems = gems
        @connection = Faraday.new(url: API_URL) do |faraday|
          faraday.adapter :typhoeus
        end
      end

      def request!
        #
        @responses = {}

        connection.in_parallel(Typhoeus::Hydra.new(max_concurrency: 10)) do
          gems.map do |gem_name|
            @responses[gem_name] = connection.get("#{gem_name}")
          end
        end
        #keep only successful responses
        @responses.reject! { |_, response| response.status >= 400 }
      end

      def info(gem_name)
        responses.has_key?(gem_name) ? JSON.parse(responses[gem_name].body) : {}
      end

    end
  end
end