module GemfileUtils
  module Cli
    module Comments

      def self.included(thor)
        thor.class_eval do

          desc 'comments', 'Comment Gemfile with gems descriptions fetched from rubygems'
          method_option :gemfile, default: 'Gemfile'
          method_option :licenses, default: 'false'

          def comments
            gemfile_dependencies.each do |dependency|
              add_comment(dependency.name, ruby_gems(dependency.name), ' ' * dependency.instance_variable_get(:@indention) )
            end
          end

          protected

          def add_comment(gem_name, gem_data, indention = '')
            info = gem_data['info']
            if options[:licenses]
              licenses = gem_data['licenses']
              licenses = Base::UNKNOWN_LICENCES if licenses.nil? || licenses.empty?
              info =  "(#{licenses * ', '}) #{info}"
            end
            inject_into_file options[:gemfile],  comment_block(info, indention), before: Regexp.new("[\s]*gem[\s]+['\"]#{gem_name}['\"]") if info
          end

        end
      end
    end
  end
end