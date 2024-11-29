# frozen_string_literal: true

name = Dir["*.gemspec"].first.split(".").first
version = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*['"](?'version'\d+\.\d+\.\d+)['"]/, "version"]

task default: :test

require "rake/testtask"
Rake::TestTask.new(:test)
