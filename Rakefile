require "bundler/gem_tasks"
require "rake/testtask"

import "./lib/tasks/download_rates.rake"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test
