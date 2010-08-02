module Scruffy::Renderers
  # ===Scruffy::Renderers::Basic
  #
  # Author:: Martyn Taylor
  # Date:: July 30th 2010
  #
  # The Basic Renderer Creates a Blank Graph with everything ready for adding components
  class Basic < Base

    def define_layout
      components << Scruffy::Components::Background.new(:background, :position => [0,0], :size =>[100, 100])
      components << Scruffy::Components::Viewport.new(:view, :position => [2, 26], :size => [89, 66]) do |graph|
          graph << Scruffy::Components::Graphs.new(:graphs, :position => [3, 0], :size => [80, 89])
          graph << Scruffy::Components::ValueMarkers.new(:values, :position => [0, 0], :size => [1, 89])
          graph << Scruffy::Components::Axis.new(:values, :position => [3, 0], :size => [80, 89])
      end
      yield(self.components) if block_given?
    end
  end
end