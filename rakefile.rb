require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'tests/*_test.rb'
  t.verbose = true
end
