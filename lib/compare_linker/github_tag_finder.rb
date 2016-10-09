class CompareLinker
  class GithubTagFinder
    attr_reader :octokit

    def initialize(octokit)
      @octokit = octokit
    end

    def find(repo_full_name, gem_version)
      tags = auto_paginate { octokit.tags(repo_full_name) }
      if tags
        tags.find { |tag|
          tag.name == gem_version || tag.name == "v#{gem_version}"
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
