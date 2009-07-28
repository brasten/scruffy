(in /home/jgreen/Desktop/rails_projects/scruffy)
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{scruffy}
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brasten Sager"]
  s.date = %q{2009-07-28}
  s.description = %q{Scruffy is a Ruby library for generating high quality, good looking graphs. It is designed to be easy to use and highly customizable.}
  s.email = [["brasten@nagilum.com", "david.parry@suranyami.com"]]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "website/index.txt"]
  s.files = ["CHANGES", "History.txt", "License.txt", "MIT-LICENSE", "Manifest.txt", "PostInstall.txt", "README", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "lib/scruffy.rb", "lib/scruffy/components.rb", "lib/scruffy/components/background.rb", "lib/scruffy/components/base.rb", "lib/scruffy/components/data_markers.rb", "lib/scruffy/components/graphs.rb", "lib/scruffy/components/grid.rb", "lib/scruffy/components/label.rb", "lib/scruffy/components/legend.rb", "lib/scruffy/components/style_info.rb", "lib/scruffy/components/title.rb", "lib/scruffy/components/value_markers.rb", "lib/scruffy/components/viewport.rb", "lib/scruffy/formatters.rb", "lib/scruffy/graph.rb", "lib/scruffy/graph_state.rb", "lib/scruffy/helpers.rb", "lib/scruffy/helpers/canvas.rb", "lib/scruffy/helpers/layer_container.rb", "lib/scruffy/helpers/meta.rb", "lib/scruffy/helpers/point_container.rb", "lib/scruffy/layers.rb", "lib/scruffy/layers/all_smiles.rb", "lib/scruffy/layers/area.rb", "lib/scruffy/layers/average.rb", "lib/scruffy/layers/bar.rb", "lib/scruffy/layers/base.rb", "lib/scruffy/layers/line.rb", "lib/scruffy/layers/pie.rb", "lib/scruffy/layers/pie_slice.rb", "lib/scruffy/layers/scatter.rb", "lib/scruffy/layers/sparkline_bar.rb", "lib/scruffy/layers/stacked.rb", "lib/scruffy/rasterizers.rb", "lib/scruffy/rasterizers/batik_rasterizer.rb", "lib/scruffy/rasterizers/rmagick_rasterizer.rb", "lib/scruffy/renderers.rb", "lib/scruffy/renderers/base.rb", "lib/scruffy/renderers/cubed.rb", "lib/scruffy/renderers/cubed3d.rb", "lib/scruffy/renderers/empty.rb", "lib/scruffy/renderers/pie.rb", "lib/scruffy/renderers/reversed.rb", "lib/scruffy/renderers/sparkline.rb", "lib/scruffy/renderers/split.rb", "lib/scruffy/renderers/standard.rb", "lib/scruffy/themes.rb", "lib/scruffy/version.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "spec/scruffy/graph_spec.rb", "spec/scruffy/layers/base_spec.rb", "spec/scruffy/layers/line_spec.rb", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/website.rake", "test/graph_creation_test.rb", "test/test_helper.rb", "website/images/blank.gif.html", "website/images/graphs/all_smiles.png", "website/images/graphs/bar_test.png", "website/images/graphs/bar_test.svg", "website/images/graphs/line_test.png", "website/images/graphs/line_test.svg", "website/images/graphs/multi_test.png", "website/images/graphs/multi_test.svg", "website/images/graphs/pie_test.png", "website/images/graphs/pie_test.svg", "website/images/graphs/split_test.png", "website/images/graphs/split_test.svg", "website/images/graphs/stacking_test.png", "website/images/graphs/stacking_test.svg", "website/images/header.png", "website/images/header_gradient.png", "website/images/overlay.png", "website/images/scruffy.png", "website/index.html", "website/index.txt", "website/javascripts/application.js", "website/javascripts/controls.js", "website/javascripts/dragdrop.js", "website/javascripts/effects.js", "website/javascripts/lightbox.js", "website/javascripts/prototype.js", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/lightbox.css", "website/stylesheets/screen.css", "website/stylesheets/scruffy.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://scruffy.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{scruffy}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A powerful, clean graphing library for Ruby.}
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
