require 'rspec/core/rake_task'
desc 'ChefSpec tests'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = [].tap do |a|
    a.push('--color')
    a.push('--format documentation')
  end.join(' ')
end

require 'foodcritic'
desc 'Run food critic with job failure on'
FoodCritic::Rake::LintTask.new do |t|
  t.options = {:fail_tags => ['correctness']}
end

require 'rubocop/rake_task'
desc 'Run RuboCop on the code significant directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['recipes/*.rb', 'libraries/*.rb',
                   'providers/*.rb', 'resources/*.rb', 'spec/**/*.rb']
  # only show the files with failures
  #task.formatters = ['files']
  # don't abort rake on failure
  task.fail_on_error = true
end

desc "Run All tests"
task :test => [:unit, :foodcritic, :rubocop]

task :default => [:test]
