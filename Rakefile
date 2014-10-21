require 'rake/testtask'

$LOAD_PATH.push("rakelib")
require 'hay/rake'

require 'coveralls/rake/task'

Edger::Rake::Tasks.new do |t|
end

namespace :cov do
  
  desc "Rake tests and then open report"
  task :run do
    puts 'Running Tests...'
    `rake`
    puts 'Opening Report.'
    path = File.expand_path('../../../', __FILE__)
    `open #{path}/coverage/index.html`
  end
  
  desc "View coverage report"
  task :report do
    path = File.expand_path('../../../', __FILE__)
    `open #{path}/coverage/index.html`
  end
end

namespace :coinstar do
  task :test do
    Rake::Task['test'].invoke
  end
end

task :test do
  Rake::Task['test:unit'].invoke
  Rake::Task['test:integration'].invoke
end

namespace :test do
  Rake::TestTask.new("integration") do |t|
    t.libs << "test"
    t.libs << "config"
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = true
  end

  Rake::TestTask.new("unit") do |t|
    t.libs << "test"
    t.libs << "config"
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
  end
end

Coveralls::RakeTask.new

task :test_with_coveralls => ['test:unit', 'test:integration', 'coveralls:push']

task :default => :test_with_coveralls
