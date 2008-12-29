Gem::Specification.new do |s|
  s.name = "scruffy"
  s.version = "0.2.6"
  s.authors = ["Brasten Sager", "samhendley", "delano"]
  s.date = "2008-12-29"
  s.description = "Scruffy is a Ruby library for generating high quality, good looking graphs. It is designed to be easy to use and highly customizable."
  s.email = ["brasten@nagilum.com", "david.parry@suranyami.com"]
  
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
puts s.files
  s.test_files = Dir['test/**/*.rb']

  s.add_dependency("builder", [">= 2.0.0"])
  s.add_dependency("hoe", [">= 1.7.0"])
end
