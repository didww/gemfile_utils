module GemfileUtils
  module Cli
    module Comments

      def self.included(thor)
        thor.class_eval do

          desc 'comments', 'Comment Gemfile with gems descriptions fetched from rubygems'
          method_option :gemfile, default: 'Gemfile'
          method_option :licenses, default: 'false'
          method_option :homepage, default: 'false'

          def comments
            gemfile_dependencies.each do |dependency|
              add_comment(dependency.name, ruby_gems(dependency.name), ' ' * dependency.instance_variable_get(:@indention) )
            end
          end

          protected

          def add_comment(gem_name, gem_data, indention = '')
            before_regexp =  Regexp.new("[\s]*gem[\s]+['\"]#{gem_name}['\"]")
            info = gem_data['info']
            info = add_licences(info, gem_data) if options[:licenses]
            info = add_homepage(info, gem_data) if options[:homepage]
            inject_into_file(options[:gemfile], comment_block(info, indention), before: before_regexp) if info
          end

          def add_licences(info, gem_data)
            licenses = gem_data['licenses']
            licenses = Base::UNKNOWN_LICENCES if licenses.nil? || licenses.empty?
            "(#{licenses * ', '}) #{info}"
          end

          def add_homepage(info, gem_data)
            homepage = gem_data['homepage_uri']
            return info if  homepage.nil? || homepage.empty?
            "#{info} (#{homepage})"
          end

        end
      end
    end
  end
end