require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/extensiontask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
end

Rake::ExtensionTask.new 'ipconverter' do |ext|
  ext.lib_dir = 'lib/ipconverter'
end

task default: [:compile, :test]
