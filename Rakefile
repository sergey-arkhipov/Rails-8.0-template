# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks # Load all Rails and gem tasks

# Only define tasks if they don't already exist
unless Rake::Task.task_defined?("spec")
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
end

unless Rake::Task.task_defined?("rubocop")
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end

unless Rake::Task.task_defined?("reek")
  require "reek/rake/task"
  Reek::Rake::Task.new
end

task default: %i[spec rubocop reek]
