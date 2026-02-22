module Jekyll
  # Helper function for getting git creation time
  def self.get_git_creation_time(file_path)
    return nil unless File.exist?('.git')

    result = `git log --format="%ai" --diff-filter=A --reverse -- "#{file_path}" 2>/dev/null | head -1`.strip
    return nil if result.empty?

    begin
      Time.parse(result)
    rescue
      nil
    end
  end

  # Add creation time to posts using git history (standard Jekyll hook pattern)
  Jekyll::Hooks.register :documents, :post_init do |post|
    # Get creation time from git (most reliable, works in CI/CD)
    git_creation_time = Jekyll.get_git_creation_time(post.path)
    post.data['created_at'] = git_creation_time if git_creation_time
  end

  # Sort posts by date, then by creation time when dates match
  class PostSorterGenerator < Generator
    safe true
    priority :lowest

    def generate(site)
      # Get all posts as an array
      posts_array = site.posts.to_a
      
      # Sort posts by date first, then by creation time
      sorted_posts = posts_array.sort do |a, b|
        # First compare by date (newer first)
        date_comparison = b.date <=> a.date
        if date_comparison != 0
          date_comparison
        else
          # If dates are equal, compare by creation time
          a_time = get_creation_time(a)
          b_time = get_creation_time(b)
          b_time <=> a_time  # Reverse order (newer first)
        end
      end
      
      # Replace the posts array in the PostReader
      if site.posts.instance_variable_defined?(:@posts)
        site.posts.instance_variable_set(:@posts, sorted_posts)
      end
    end

    private

    def get_creation_time(post)
      # Use created_at from front matter if available (set by hook above)
      return post.data['created_at'] if post.data['created_at']
      
      # Fall back to git creation time
      git_time = get_git_creation_time(post.path)
      return git_time if git_time

      # Fall back to file system birthtime
      if File.exist?(post.path)
        stat = File.stat(post.path)
        return stat.birthtime if stat.respond_to?(:birthtime)
        return stat.mtime
      end

      Time.now
    end

    def get_git_creation_time(file_path)
      Jekyll.get_git_creation_time(file_path)
    end
  end
end
