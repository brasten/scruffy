lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'scruffy/version'

Gem::Specification.new do |s|
  s.name = "scruffy"
  s.version = Scruffy::VERSION
  s.description = "Scruffy is a Ruby library for generating high quality, good looking graphs. It is designed to be easy to use and highly customizable."
  s.authors = ["brasten", "Jeremy Green", "samhendley", "delano", "willbryant", "tlconner", "Jonas Nicklas"]
  s.email = ["brasten@nagilum.com", "david.parry@suranyami.com", "jagthedrummer@gmail.com", "tim@connorsoftware.com", "jonas.nicklas@gmail.com"]
  s.description = "Scruffy is a library for outputting graphs to image or SVG"

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.txt CHANGES.txt)

  s.homepage = "http://github.com/brasten/scruffy"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = "Scruffy is a library for outputting graphs to image or SVG"

  s.add_dependency 'builder', '>= 2.0'
  # This shouldn't be a dependency, as it's possible to use Scruffy without it.
#  s.add_dependency 'rmagick', '~> 2.0'
  s.add_development_dependency 'rspec', '~> 2.3'

end
