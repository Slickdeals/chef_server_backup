require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = [].tap do |a|
    a.push('--color')
    a.push('--format documentation')
  end.join(' ')
end

require 'foodcritic'
FoodCritic::Rake::LintTask.new do |t|
  t.options = {:fail_tags => ['correctness']}
end

desc "Run All tests"
task :test => [:unit, :foodcritic]

task :default => [:test]
