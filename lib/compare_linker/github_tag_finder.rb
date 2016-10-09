class CompareLinker
  class GithubTagFinder
    attr_reader :octokit, :gem_name, :repo_full_name

    def initialize(octokit, gem_name, repo_full_name)
      @octokit = octokit
      @gem_name = gem_name
      @repo_full_name = repo_full_name
    end

    def find(gem_version)
      tags = auto_paginate { octokit.tags(repo_full_name) }
      if tags
        tags.find { |tag|
          tag.name == gem_version ||
            tag.name == "v#{gem_version}" ||
            tag.name == "#{gem_name}-#{gem_version}"
        }
      end
    end

    private

    def auto_paginate
      original = octokit.auto_paginate
      octokit.auto_paginate = true
      yield
    ensure
      octokit.auto_paginate = original
    end
  end
end
