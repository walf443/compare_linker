require "ostruct"

class CompareLinker
  class Formatter
    class Markdown < Base
      def format(gem_info)
        g = OpenStruct.new(gem_info)

        text = "* [ ] "
        text += case
        when g.owner && g.old_rev && g.new_rev
          "[%s](%s): [%s...%s](%s)" % [
            g.gem_name,
            github_url(g.owner, g.gem_name),
            g.old_rev,
            g.new_rev,
            github_compare_url(g.owner, g.gem_name, g.old_rev, g.new_rev),
          ]
        when g.homepage_uri && g.old_tag && g.new_tag
          "[%s](%s): [%s...%s](%s)" % [
            g.gem_name,
            github_url(g.repo_owner, g.repo_name),
            g.old_ver,
            g.new_ver,
            github_compare_url(g.repo_owner, g.repo_name, g.old_tag, g.new_tag),
          ]
        when g.homepage_uri
          "[%s](%s): %s...%s" % [
            g.gem_name,
            g.homepage_uri,
            g.old_ver,
            g.new_ver,
          ]
        when g.old_tag && g.new_tag
          "[%s](%s): [%s...%s](%s)" % [
            g.gem_name,
            github_url(g.repo_owner, g.repo_name),
            g.old_ver,
            g.new_ver,
            github_compare_url(g.repo_owner, g.repo_name, g.old_tag, g.new_tag),
          ]
        when g.repo_owner && g.repo_name
          "[%s](%s): %s...%s" % [
            g.gem_name,
            github_url(g.repo_owner, g.repo_name),
            g.old_ver,
            g.new_ver,
          ]
        else
          "%s: (link not found) %s...%s" % [
            g.gem_name,
            g.old_ver,
            g.new_ver,
          ]
        end

        if downgrade?(g.old_ver, g.new_ver, g.old_tag, g.new_tag)
          text += " (downgrade)"
        end

        text
      end

      private

      def github_url(repo_owner, repo_name)
        "https://github.com/#{repo_owner}/#{repo_name}"
      end

      def github_compare_url(repo_owner, repo_name, old_tag, new_tag)
        "#{github_url(repo_owner, repo_name)}/compare/#{old_tag}...#{new_tag}"
      end
    end
  end
end
