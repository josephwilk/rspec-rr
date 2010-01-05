require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rcov'

desc 'Default: run unit tests.'
task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rspec-rr"
    gem.summary = %Q{Helping Rspec and Rspec-rails play nicely with RR the test double framework}
    gem.description = %Q{Helping Rspec and Rspec-rails play nicely with RR the test double framework.}
    gem.email = "joe@josephwilk.net"
    gem.homepage = "http://github.com/josephwilk/rspec-rr"
    gem.authors = ["Joseph Wilk"]

    gem.add_development_dependency 'rspec'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
  unless ENV['NO_RCOV']
    t.rcov = true
    t.rcov_dir = 'coverage'
    t.rcov_opts = ['--exclude', 'lib/spec_rr.rb,,\/var\/lib\/gems,\/Library\/Ruby,\.autotest']
  end
end

desc 'Generate documentation for the rspec-rr plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Rspec-rr'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
