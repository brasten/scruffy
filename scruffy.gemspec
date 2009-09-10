--- !ruby/object:Gem::Specification 
name: scruffy
version: !ruby/object:Gem::Version 
  version: 0.2.11
platform: ruby
authors: 
- Brasten Sager
- Jeremy Green
- samhendley
- delano
autorequire: 
bindir: bin
cert_chain: []

date: 2009-01-23 00:00:00 -05:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: builder
  type: :runtime
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: 2.0.0
    version: 
description: Scruffy is a Ruby library for generating high quality, good looking graphs. It is designed to be easy to use and highly customizable.
email: 
- brasten@nagilum.com
- david.parry@suranyami.com
executables: []

extensions: []

extra_rdoc_files: []

files: 
- lib/scruffy/rasterizers/rmagick_rasterizer.rb
- lib/scruffy/rasterizers/batik_rasterizer.rb
- lib/scruffy/version.rb
- lib/scruffy/layers/base.rb
- lib/scruffy/layers/area.rb
- lib/scruffy/layers/stacked.rb
- lib/scruffy/layers/pie_slice.rb
- lib/scruffy/layers/scatter.rb
- lib/scruffy/layers/bar.rb
- lib/scruffy/layers/sparkline_bar.rb
- lib/scruffy/layers/pie.rb
- lib/scruffy/layers/all_smiles.rb
- lib/scruffy/layers/average.rb
- lib/scruffy/layers/line.rb
- lib/scruffy/layers/box.rb
- lib/scruffy/rasterizers.rb
- lib/scruffy/renderers.rb
- lib/scruffy/themes.rb
- lib/scruffy/helpers/canvas.rb
- lib/scruffy/helpers/point_container.rb
- lib/scruffy/helpers/layer_container.rb
- lib/scruffy/helpers/meta.rb
- lib/scruffy/helpers/marker_helper.rb
- lib/scruffy/components.rb
- lib/scruffy/graph_state.rb
- lib/scruffy/components/style_info.rb
- lib/scruffy/components/value_markers.rb
- lib/scruffy/components/viewport.rb
- lib/scruffy/components/base.rb
- lib/scruffy/components/graphs.rb
- lib/scruffy/components/background.rb
- lib/scruffy/components/legend.rb
- lib/scruffy/components/data_markers.rb
- lib/scruffy/components/label.rb
- lib/scruffy/components/grid.rb
- lib/scruffy/components/title.rb
- lib/scruffy/graph.rb
- lib/scruffy/renderers/sparkline.rb
- lib/scruffy/renderers/base.rb
- lib/scruffy/renderers/reversed.rb
- lib/scruffy/renderers/split.rb
- lib/scruffy/renderers/cubed3d.rb
- lib/scruffy/renderers/standard.rb
- lib/scruffy/renderers/pie.rb
- lib/scruffy/renderers/empty.rb
- lib/scruffy/renderers/cubed.rb
- lib/scruffy/formatters.rb
- lib/scruffy/helpers.rb
- lib/scruffy/layers.rb
- lib/scruffy.rb
- LICENCE.txt
- README.txt
- CHANGES.txt
- Manifest.txt
has_rdoc: true
homepage: http://scruffy.rubyforge.org
post_install_message: 
rdoc_options: 
- --quiet
- --title
- scruffy documentation
- --opname
- index.html
- --line-numbers
- --main
- README.txt
- --inline-source
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
requirements: []

rubyforge_project: 
rubygems_version: 1.2.0
signing_key: 
specification_version: 2
summary: A powerful, clean graphing library for Ruby.
test_files: 
- test/graph_creation_test.rb
- test/test_helper.rb



