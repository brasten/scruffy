Gem::Specification.new do |s|
  s.name = "scruffy"
  s.version = "0.2.15"
  s.authors = ["Brasten Sager", "samhendley", "delano","jagthedrummer"]
  s.date = "2009-01-23"
  s.description = "Scruffy is a Ruby library for generating high quality, good looking graphs. It is designed to be easy to use and highly customizable."
  s.email = ["brasten@nagilum.com", "david.parry@suranyami.com","jagthedrummer@gmail.com"]
  
  s.has_rdoc = true
  s.homepage = "http://scruffy.rubyforge.org"
  s.rdoc_options = ['--quiet', '--title', 'scruffy documentation',
    "--opname", "index.html",
    "--line-numbers",
    "--main", "README.txt",
    "--inline-source"]
  s.summary = "A powerful, clean graphing library for Ruby."

  s.files = Dir['lib/**/*.rb']
  s.files += Dir['*.txt']
  s.test_files = Dir['test/**/*.rb']

  s.add_dependency("builder", [">= 2.0.0"])
end
