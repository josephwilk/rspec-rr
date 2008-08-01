require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rcov'

desc 'Default: run unit tests.'
task :default => :spec

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
