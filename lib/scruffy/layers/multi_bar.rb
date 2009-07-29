module Scruffy::Layers
  # ==Scruffy::Layers::MultiBar
  #
  # Author:: Jeremy Green
  # Date:: July 29th, 2009
  #
  # Based on:: Scruffy::Layers::Bar by
  # Author:: Brasten Sager
  # Date:: August 6th, 2006
  #
  # Standard multi_bar graph.  
  class MultiBar < Base
  
    # Draw multi_bar graph.
    def draw(svg, coords, options = {})
      coords.each do |coord|
        x, y, bar_height = (coord.first-(@bar_width * 0.5)), coord.last, (height - coord.last)

        #svg.g(:transform => "translate(-#{relative(0.5)}, -#{relative(0.5)})") {
        #  svg.rect( :x => x, :y => y, :width => @bar_width + relative(1), :height => bar_height + relative(1), 
        #            :style => "fill: black; fill-opacity: 0.15; stroke: none;" )
        #  svg.rect( :x => x+relative(0.5), :y => y+relative(2), :width => @bar_width + relative(1), :height => bar_height - relative(0.5), 
        #            :style => "fill: black; fill-opacity: 0.15; stroke: none;" )
        #
        #}
        
        svg.rect( :x => x, :y => y, :width => @bar_width, :height => bar_height, 
                  :fill => color.to_s, 'style' => "opacity: #{opacity}; stroke: none;" )
      end
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
        @point_width = (width / points.size)
        @point_space = @point_width * 0.1
        @point_width = @point_width - @point_space
        @bar_width = @point_width/options[:num_bars]
        @bar_space = @bar_width * 0.1
        @bar_width = @bar_width * 0.9
        
        #options[:point_distance] = (width - (width / points.size)) / (points.size - 1).to_f
          
        #TODO more array work with index, try to rework to be accepting of hashes
        coords = (0...points.size).map do |idx| 
          
          x_coord = (@point_width * idx) + @point_space/2 + @point_space*idx + @bar_width * options[:position] + @bar_width/2 +  @bar_space*(options[:position].to_f - 0.5)

          relative_percent = ((points[idx] == min_value) ? 0 : ((points[idx] - min_value) / (max_value - min_value).to_f))
          y_coord = (height - (height * relative_percent))
          [x_coord, y_coord]
        end
        coords
      end
  end
end