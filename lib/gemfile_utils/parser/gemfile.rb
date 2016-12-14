require 'gemnasium/parser'
require 'gemnasium/parser/gemfile'
module GemfileUtils
  module Parser
    class Gemfile < ::Gemnasium::Parser::Gemfile
      #do not exclude any gem
      def exclude?(_match, _opts)
        false
      end

      def dependency(match)
        dep = super(match)
        dep.instance_variable_set(:@indention, match.to_s.index(/[^ ]/) ) #count spaces before gem method
        dep
      end

    end
  end
end