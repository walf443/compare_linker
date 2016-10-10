class CompareLinker
  class Formatter
    class Text < Base
      private

      def post_format
        text = case
        when g.owner && g.old_rev && g.new_rev
          "#{g.gem_name}: #{github_compare_url(g.owner, g.gem_name, g.old_rev, g.new_rev)}"
        when g.homepage_uri && g.old_tag && g.new_tag
          "#{g.gem_name} (#{g.homepage_uri}): #{github_compare_url(g.repo_owner, g.repo_name, g.old_tag, g.new_tag)}"
        when g.homepage_uri
          "#{g.gem_name} (#{g.homepage_uri}): #{g.old_ver}...#{g.new_ver}"
        when g.old_tag && g.new_tag
          "#{g.gem_name}: #{github_compare_url(g.repo_owner, g.repo_name, g.old_tag, g.new_tag)}"
        when g.repo_owner && g.repo_name
          "#{g.gem_name}: #{github_url(g.repo_owner, g.repo_name)} #{g.old_ver}...#{g.new_ver}"
        else
          "#{g.gem_name} (link not found): #{g.old_ver}...#{g.new_ver}"
        end

        text += " (downgrade)" if downgraded
        text
      end
    end
  end
end
