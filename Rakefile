require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

desc 'Run all tests by default'
task :default => :test

task :test do
  Dir['test/**/*_test.rb'].all? do |file|
    system("export DEBUG=true && ruby -Itest #{file}")
  end or raise "Failures"
end
