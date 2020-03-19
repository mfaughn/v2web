# require 'octokit'
# client = Octokit::Client.new(:login => ENV["GITHUB_USER"], :password => ENV["GITHUB_PW"])
def github_test(name = nil, email = nil)
  repo_dir = File.expand_path('~/projects/v2-pubs-test')
  name ||= 'Michael Faughn'
  email ||= 'mike.faughn@gmail.com'
  system "cd #{repo_dir}"
  system "git config user.email #{email} && git config user.name '#{name}'"
  system "touch test.txt"
  t = Time.now.utc
  system "echo 'Maps to commit by #{name} with email #{email} at #{t}' >> test.txt"
  system "git add ."
  system "git commit -m 'test commit message at #{t}'"
  puts system 'git push'
end
