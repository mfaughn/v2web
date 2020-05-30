# require 'octokit'
# client = Octokit::Client.new(:login => ENV["GITHUB_USER"], :password => ENV["GITHUB_PW"])
def github_test(name = nil, email = nil)
  repo_dir = File.expand_path('~/projects/v2-pubs-test')
  name ||= 'Michael Faughn'
  email ||= 'mike.faughn@gmail.com'
  branch_name = name.gsub(/\s/, '')
  # here = __dir__
  Dir.chdir(repo_dir) {
    system "cd #{repo_dir}"
    system "git config user.email #{email} && git config user.name '#{name}'"
    system "git checkout -b #{branch_name}"
    system "touch test.txt"
    t = Time.now.utc
    system "echo 'Maps to commit by #{name} with email #{email} at #{t}' >> test.txt"
    system "git add test.txt"
    system "git commit -m 'test commit message at #{t}'"
    puts system 'git push -u origin ' + branch_name    
    system 'git checkout master'
  }
end
