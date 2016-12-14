# incompatible character encodings: ASCII-8BIT and UTF-8 fix by replacing File.binread with File.read
# https://github.com/erikhuda/thor/issues/191
class Thor
  module Actions
    class InjectIntoFile < EmptyDirectory #:nodoc:
      protected

      # Adds the content to the file.
      #
      def replace!(regexp, string, force)
        return if base.options[:pretend]
        content = File.read(destination)
        if force || !content.include?(replacement)
          content.gsub!(regexp, string)
          File.open(destination, "wb") { |file| file.write(content) }
        end
      end
    end
  end
end

