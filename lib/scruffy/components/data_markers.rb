module Scruffy
  module Components

    class DataMarkers < Base
      
      include Scruffy::Helpers::Marker
      
      attr_accessor :markers
      
      def draw(svg, bounds, options={})
        if options[:calculate_markers] && (options[:point_markers].nil? || options[:point_markers].empty?)
          markers = (options[:markers] || self.markers) || 5
          options[:point_markers] = []
          each_marker(markers, options[:min_key], options[:max_key], bounds[:width], options, :key_formatter) do |label, x|
            options[:point_markers] << label
          end
        end
        unless options[:point_markers].nil?
          point_distance = bounds[:width] / (options[:point_markers].size - 1).to_f
    
          (0...options[:point_markers].size).map do |idx| 
            x_coord = point_distance * idx
            svg.text(options[:point_markers][idx],
              :x => x_coord,
              :y => bounds[:height], 
              'font-size' => relative(90),
              'font-family' => options[:theme].font_family,
              :fill => (options[:theme].marker || 'white').to_s, 
              'text-anchor' => 'middle') unless options[:point_markers][idx].nil?
          end
        end
      end   # draw
      
    end   # class

  end
end