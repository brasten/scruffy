module Scruffy
  module Components
    class ValueMarkers < Base
      
      include Scruffy::Helpers::Marker
      
      attr_accessor :markers

      def draw(svg, bounds, options={})
        markers = (options[:markers] || self.markers) || 5
        
        each_marker(markers, options[:min_value], options[:max_value], bounds[:height], options, :value_formatter) do |label, y|

          svg.text( label, 
            :x => bounds[:width], 
            :y => (bounds[:height] - y), 
            'font-size' => options[:theme].marker_font_size || relative(8),
            'font-family' => options[:theme].font_family,
            :fill => ((options.delete(:marker_color_override) || options[:theme].marker) || 'white').to_s,
            'text-anchor' => 'end')
        end
      end
    end
  end
end