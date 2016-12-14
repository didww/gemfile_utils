module GemfileUtils
  module Cli
    module Licenses

      def self.included(thor)
        thor.class_eval do
          desc 'licenses', 'Comment Gemfile with gems all dependencies licences fetched from rubygems'
          method_option :gemfile, default: 'Gemfile'

          def licenses
            licenses_list = []
            gemfile_dependencies.each do |dependency|
              l = ruby_gems(dependency.name)['licenses']
              l =  Base::UNKNOWN_LICENCES if l.nil? || l.empty?
              licenses_list += l
            end

            prepend_to_file options[:gemfile], comment_block(licenses_comment(licenses_list))
          end

          private
          def licenses_comment(list)
            safe_encode "Licenses: #{list.uniq.sort}"
          end
        end
      end
    end
  end
end