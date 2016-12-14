require 'thor'
require_relative '../thor/actions/inject_into_file'
require_relative '../parser/gemfile'
require_relative '../parser/ruby_gems'

require_relative 'modules/comments'
require_relative 'modules/licenses'


module GemfileUtils
  module Cli
    class Base < ::Thor
      include ::Thor::Actions
      namespace :gemfile_utils

      UNKNOWN_LICENCES = ['Unknown'].freeze

      include GemfileUtils::Cli::Comments
      include GemfileUtils::Cli::Licenses



      protected

      def gemfile_dependencies
        @gemfile_dependencies ||= GemfileUtils::Parser::Gemfile.new(gemfile_content).dependencies
      end

      def gemfile_content
        @gemfile_content ||= File.read( options[:gemfile] )
      end

      def ruby_gems(gem_name)
        ruby_gems_parser.info(gem_name)
      end

      def ruby_gems_parser
        @ruby_gems_parser ||= begin
          rg =  GemfileUtils::Parser::RubyGems.new(gemfile_dependencies.map(&:name))
          rg.request!
          rg
        end
      end

      def comment_block(str, indention = '')
        safe_encode str.lines.map{|line|  "#{indention}# #{line.chomp}" }.join($/) + $/
      end

      def safe_encode(value)
         value.encode("utf-8", invalid: :replace, undef: :replace, replace: "_")
      end

    end
  end
end