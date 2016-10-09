class CompareLinker
  class Formatter
    class Base
      private

      def downgrade?(old_ver, new_ver, old_tag, new_tag)
        Gem::Version.new(new_ver) < Gem::Version.new(old_ver) ||
          (old_tag && new_tag && Gem::Version.new(to_ver(new_tag)) < Gem::Version.new(to_ver(old_tag)))
      end

      def to_ver(tag)
        return $1 if tag =~ /(\d+(?:\.\d+)+)\z/
      end
    end
  end
end
