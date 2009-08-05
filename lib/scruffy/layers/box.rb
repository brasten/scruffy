module Scruffy::Layers
  # ==Scruffy::Layers::Box
  #
  # Author:: Brasten Sager
  # Date:: August 6th, 2006
  #
  # Standard bar graph.  
  class Box < Base
  
    # Draw box plot.
    def draw(svg, coords, options = {})
      coords.each_with_index do |coord,idx|
        x, y, bar_height = (coord.first), coord.last, 1#(height - coord.last)
        
          valh = max_value + min_value * -1 #value_height
          maxh = max_value * height / valh #positive area height
          minh = min_value * height / valh #negative area height
          #puts "height = #{height} and max_value = #{max_value} and min_value = #{min_value} and y = #{y} and point = #{points[idx]}"
          
          #if points[idx] > 0
          #  bar_height = points[idx]*maxh/max_value
          #else
          #  bar_height = points[idx]*minh/min_value
          #end
        
        #puts " y = #{y} and point = #{points[idx]}"  
        #svg.g(:transform => "translate(-#{relative(0.5)}, -#{relative(0.5)})") {
        #  svg.rect( :x => x, :y => y, :width => @bar_width + relative(1), :height => bar_height + relative(1), 
        #            :style => "fill: black; fill-opacity: 0.15; stroke: none;" )
        #  svg.rect( :x => x+relative(0.5), :y => y+relative(2), :width => @bar_width + relative(1), :height => bar_height - relative(0.5), 
        #            :style => "fill: black; fill-opacity: 0.15; stroke: none;" )
        #
        #}
        
        svg.line(:x1=>x+@bar_width/2,:x2=>x+@bar_width/2,:y1=>y[0],:y2=>y[4], :style => "stroke:#{(outline.to_s || options[:theme].marker || 'white').to_s}; stroke-width:1")
        svg.line(:x1=>x+@bar_width/4,:x2=>x+@bar_width/4*3,:y1=>y[0],:y2=>y[0], :style => "stroke:#{(outline.to_s || options[:theme].marker || 'white').to_s}; stroke-width:1")
        svg.line(:x1=>x+@bar_width/4,:x2=>x+@bar_width/4*3,:y1=>y[4],:y2=>y[4], :style => "stroke:#{(outline.to_s || options[:theme].marker || 'white').to_s}; stroke-width:1")
        svg.rect( :x => x, :y => y[1], :width => @bar_width, :height => (y[1]-y[3])*-1, 
                  :fill => color.to_s, 'style' => "opacity: #{opacity}; stroke:#{(outline.to_s || options[:theme].marker || 'white').to_s}; stroke-width:1;" )
        svg.line(:x1=>x,:x2=>x+@bar_width,:y1=>y[2],:y2=>y[2], :style => "stroke:#{(outline.to_s || options[:theme].marker || 'white').to_s}; stroke-width:1")
        #svg.rect( :x => x, :y => y, :width => @bar_width, :height => bar_height, 
        #          :fill => color.to_s, 'style' => "opacity: #{opacity}; stroke: none;" )
      end
    end


  # Returns the highest value in any of this container's layers.
    #
    # If padding is set to :padded, a 15% padding is added to the highest value.
    def top_value(padding=nil) # :nodoc:
      topval = points[0].max
      points.each do |point_set|
        topval = ( (topval < point_set.max) ? point_set.max : topval )
      end
      #topval = layers.inject(0) { |max, layer| (max = ((max < layer.top_value) ? layer.top_value : max)) unless layer.top_value.nil?; max }
      below_zero = (topval <= 0)
      topval = padding == :padded ? (topval + ((topval - bottom_value(nil)) * 0.15)) : topval
      (below_zero && topval > 0) ? 0 : topval
    end

    # Returns the lowest value in any of this container's layers.
    #
    # If padding is set to :padded, a 15% padding is added below the lowest value.
    # If the lowest value is greater than zero, then the padding will not cross the zero line, preventing
    # negative values from being introduced into the graph purely due to padding.
    def bottom_value(padding=nil) # :nodoc:
      botval = points[0].min
      points.each do |point_set|
        botval = ( (botval>point_set.min) ? point_set.min : botval )
      end
      #botval = layers.inject(0) do |min, layer| 
      #  (min = ((min > layer.bottom_value) ? layer.bottom_value : min)) unless layer.bottom_value.nil?
      #  min 
      #end
      above_zero = (botval >= 0)
      botval = (botval - ((top_value(nil) - botval) * 0.15)) if padding == :padded
    
      # Don't introduce negative values solely due to padding.
      # A user-provided value must be negative before padding will extend into negative values.
      (above_zero && botval < 0) ? 0 : botval
    end

    protected
    
      # Due to the size of the bar graph, X-axis coords must 
      # be squeezed so that the bars do not hang off the ends
      # of the graph.
      #
      # Unfortunately this just mean that bar-graphs and most other graphs
      # end up on different points.  Maybe adding a padding to the coordinates
      # should be a graph-wide thing?
      #
      # Update : x-axis coords for lines and area charts should now line
      # up with the center of bar charts.
      
      def generate_coordinates(options = {})
        @bar_width = (width / points.size) * 0.9
        options[:point_distance] = (width - (width / points.size)) / (points.size - 1).to_f

        #TODO more array work with index, try to rework to be accepting of hashes
        coords = (0...points.size).map do |idx| 
          x_coord = (options[:point_distance] * idx) + (width / points.size * 0.5) - (@bar_width * 0.5)
          y_coords = []
          points[idx].each do |point| 
            relative_percent = ((point == min_value) ? 0 : ((point - min_value) / (max_value - min_value).to_f))
            y_coord = (height - (height * relative_percent))
            y_coords << y_coord
          end
          [x_coord, y_coords]
        end
        coords
      end
  end
end