module Scruffy
  module Components
    class Grid < Base
      attr_accessor :markers
      
      include Scruffy::Helpers::Marker
      
      def draw(svg, bounds, options={})
        markers = (options[:markers] || self.markers) || 5
        
        stroke_width = options[:stroke_width]
        
        each_marker(markers, options[:min_value], options[:max_value], bounds[:height], options, :value_formatter) do |label, y|
          svg.line(:x1 => 0, :y1 => y, :x2 => bounds[:width], :y2 => y, :style => "stroke: #{options[:theme].marker.to_s}; stroke-width: #{stroke_width};")
        end
      end
    end
    
    class VGrid < Base
      attr_accessor :markers
      
      include Scruffy::Helpers::Marker
      
      def draw(svg, bounds, options={})
        markers = (options[:key_markers] || self.markers) || 5
        
        stroke_width = options[:stroke_width]
        
        each_marker(markers, options[:min_key], options[:max_key], bounds[:width], options, :key_formatter) do |label, x|
          svg.line(:x1 => x, :y1 => 0, :x2 => x, :y2 => bounds[:height], :style => "stroke: #{options[:theme].marker.to_s}; stroke-width: #{stroke_width};")
        end
      end
    end
  end
end

