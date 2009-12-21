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
            options[:point_markers] << [x, label]
          end
        end
        unless options[:point_markers].nil?
          dx = bounds[:width].to_f / (options[:max_key] - options[:min_key] + 1)
          (0...options[:point_markers].size).map do |idx| 
            x_coord = dx * (options[:point_markers][idx].first - options[:min_key]) + dx/2
            if options[:point_markers_ticks]
              svg.line(:x1 => x_coord, :y1 => 0, :x2 => x_coord, :y2 => -3, :style => "stroke:#{(options[:theme].marker || 'white').to_s}; stroke-width:1")
            end

            svg.text(options[:point_markers][idx].last,
              :x => 0,
              :y => 0, 
              'font-size' => options[:theme].marker_font_size || relative(90),
              'font-family' => options[:theme].font_family,
              :transform => "translate(#{x_coord},#{bounds[:height]}) rotate(#{options[:point_markers_rotation] || 0})",
              :fill => (options[:theme].marker || 'white').to_s, 
              'text-anchor' => 'middle') unless options[:point_markers][idx].nil?
          end
        end
      end   # draw
      
    end   # class

  end
end