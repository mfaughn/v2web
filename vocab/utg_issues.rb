require 'csv'
def _do_utg_stuff
  parse_utg_git_log
  # get_v2_utg_tickets
end

def parse_utg_git_log
  v2_tix = v2_ticket_numbers
  issues = {}
  file = File.expand_path('utg_git_log.json', __dir__)
  commits = eval File.read(file)
  relevant = commits.select do |c|
    ups = []
    c.values.each { |v| ups.concat(v.scan(/UP-\d+/)) }
    (v2_tix & ups).any? || c.values.any? { |v| v =~ /v2|V2|Oemig|table.\d/ }
  end
  # pp relevant
  # puts relevant.size
  no_up, has_up = relevant.partition { |h| h.to_s !~ /UP-\d+/ }
  puts no_up.size
  puts has_up.size
  File.open('utg_v2_commits_no_ticket.json', 'w+') { |f| f.puts(JSON.pretty_generate(no_up)) }
  File.open('utg_v2_commits_with_ticket.json', 'w+') { |f| f.puts(JSON.pretty_generate(has_up)) }
  has_up_numbers = has_up.map { |h| h.values.map { |v| v.scan(/UP-\d+/) } }.flatten.uniq
  v2_up_ticket_numbers_with_commits = v2_tix & has_up_numbers
  # puts v2_up_ticket_numbers_with_commits.sort
  puts v2_up_ticket_numbers_with_commits.size
  v2_up_tickets_with_commits = get_v2_utg_tickets.select { |k,v| v2_up_ticket_numbers_with_commits.include?(k) }
  puts v2_up_tickets_with_commits.size
  File.open('utg_v2_jira_tickets_for_which_there_are_git_commits.json', 'w+') { |f| f.puts(JSON.pretty_generate(v2_up_tickets_with_commits)) }

end

def get_utg_tickets
  issues = {}
  file = File.expand_path('utg_issues_20220830.csv', __dir__)
  table = CSV.parse(File.read(file), :headers => true, :liberal_parsing => true) do |row|
    issue = row.field('Key')
    issues[issue] ||= {comments:[], remote_links:[] }
    row.each do |key, val|
      val = val.gsub(/(\r?\n)+/, ' ')
      next if key == 'Key'
      next if val.to_s.strip.empty?
      if key == 'Remote link'
        issues[issue][:remote_links] << val
        next
      end
      if key == 'Comments'
        issues[issue][:comments] << val
        next
      end
      key = :IssueType if key =~ /Issue Type/i
      issues[issue][key.to_sym] = val
    end
  end
  issues
end

def get_v2_utg_tickets
  issues = get_utg_tickets
  v2_issues = issues.select do |i,data|
    data.to_s =~ /v2|table|0\d\d\d|Oemig|rsnelick/i
  end
  v2_issues.each do |_,data|
    data.reject! do |x,y|
      y.nil? || y.empty?
    end
  end
  v2_issues
end

def v2_ticket_numbers
  issues = get_v2_utg_tickets.keys
end
  
  

_do_utg_stuff
