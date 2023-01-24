# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/extensiontask'

ROOT = File.expand_path(__dir__)

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
end

Rake::ExtensionTask.new 'ipconverter' do |ext|
  ext.lib_dir = 'lib'
end

task default: %i[compile test]

desc "Run benchmarks"
task benchmark: [:compile] do
  sh "ruby #{ROOT}/benchmark/str_to_int.rb"
  sh "ruby #{ROOT}/benchmark/int_to_str.rb"
end
