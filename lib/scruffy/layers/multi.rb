module Scruffy::Layers
  # ==Scruffy::Layers::Multi
  #
  # Author:: Jeremy Green
  # Date:: July 29th, 2009
  #
  # Based on:: Scruffy::Layers::Stacked by
  # Author:: Brasten Sager
  # Date:: August 12th, 2006
  #
  # Provides a generic way for displaying multiple bar graphs side by side.  
  class Multi < Base
    include Scruffy::Helpers::LayerContainer
    
    # Returns new Multi graph.
    #
    # You can provide a block for easily adding layers during (just after) initialization.
    # Example:
    #   Multi.new do |multi|
    #     multi << Scruffy::Layers::Line.new( ... )
    #     multi.add(:bar, 'My Bar', [...])
    #   end
    #
    # The initialize method passes itself to the block, and since multi is a LayerContainer,
    # layers can be added just as if they were being added to Graph.
    def initialize(options={}, &block)
      super(options)

      block.call(self)    # Allow for population of data with a block during initialization.
    end
    
    # Overrides Base#render to fiddle with layers' points to achieve a multi effect.
    def render(svg, options = {})
      #TODO ensure this works with new points
      #current_points = points
      layers.each_with_index do |layer,i|
        
        #real_points = layer.points
        #layer.points = current_points
        layer_options = options.dup
        layer_options[:color] = layer.preferred_color || layer.color || options[:theme].next_color          
        layer_options[:num_bars] = layers.size
        layer_options[:position] = i
        layer.render(svg, layer_options)
        options.merge(layer_options)
        #layer.points = real_points
        
        #layer.points.each_with_index { |val, idx| current_points[idx] -= val }
      end
    end

    # A multi graph has many data sets.  Return legend information for all of them.
    def legend_data
      if relevant_data?
        retval = []
        layers.each do |layer|
          retval << layer.legend_data
        end
        retval
      else
        nil
      end
    end

    # TODO, special points accessor  
    

    def points=(val)
      throw ArgumentsError, "Multi layers cannot accept points, only other layers."
    end
  end
end