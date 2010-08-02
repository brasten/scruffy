module Scruffy::Layers
  # ==Scruffy::Layers::MulitArea
  #
  # Author:: Martyn Taylor
  # Date:: July 30th 2010
  #
  # Multi Area graph.

  class MultiArea < Base

    attr_accessor :baselines
    attr_accessor :area_colors

    def initialize(options = {}, &block)
      super(options)
      @area_colors = options[:area_colors] ? options[:area_colors] : nil
      @baselines = options[:baselines] ? options[:baselines] : nil
    end

    # Render Multi Area graph.
    def draw(svg, coords, options={})
      # Check whether to use color from theme, or whether to use user defined colors from the area_colors array
      color_count = nil
      if @area_colors && @area_colors.size > 0
        area_color = @area_colors[0]
        color_count = 1
      else
        puts "Never Set Area Color"
        area_color = color
      end

      # Draw Bottom Level Polygons (Original Coords)
      draw_poly(svg, coords, area_color, options = {})

      # Draw Lower Area Polygons
      if @baselines
        # Get the Color of this Area
        puts "Drawing Baselines"
        @baselines.sort! {|x,y| y <=> x }
        @baselines.each do |baseline|
          if color_count
            area_color = area_colors[color_count]
            color_count = color_count + 1
            puts area_color.to_s
            if color_count >= area_colors.size
              color_count = 0
            end
          end

          lower_poly_coords = create_lower_polygon_coords(translate_number(baseline), coords, options)
          draw_poly(svg, lower_poly_coords, area_color, options = {})
        end
      end
    end

    private
    def draw_poly(svg, coords, color, options={})
      points_value1 = "0,#{height} #{stringify_coords(coords).join(' ')} #{width},#{height}"
      svg.polygon(:points => points_value1, :fill => color.to_s, :stroke => color.to_s, 'style' => "opacity: #{opacity}")
    end

    def calculate_intersection(baseline, point1, point2)
      x1 = point1[0]
      y1 = point1[1]
      x2 = point2[0]
      y2 = point2[1]

      # Check whether baseline intersects with the two point line from these coords
      if ((y2 >= baseline) && (y1 <= baseline)) || ((y1 >= baseline) && (y2 <= baseline))
        # Calculate point of intersection
        y = baseline.to_f
        m = (y2.to_f - y1.to_f) / (x2.to_f - x1.to_f)
        c = y1.to_f

        x = (y.to_f - c.to_f) / m.to_f
        return [x + x1, y]
      elsif (y2 <= baseline) && (y1 <= baseline)
        return nil
      else
        return [x2, y2]
      end
    end


    def create_lower_polygon_coords(baseline, coords, options={})
      lower_poly_coords = []
      if coords[0][1] <= baseline
        lower_poly_coords << [coords[0][0], baseline]
      else
        lower_poly_coords << coords[0]
      end

      coords.each_index do |index|
        if index + 1 < coords.size
          poi = calculate_intersection(baseline, coords[index], coords[index + 1])
          if poi
            lower_poly_coords << poi
            if(coords[index + 1][1] > baseline)
              lower_poly_coords << coords[index + 1]
            end
          end
        end
      end

      if coords.last[1] <= baseline
        lower_poly_coords << [coords.last[0], baseline]
      else
        lower_poly_coords << coords.last
      end

      return lower_poly_coords
    end

    def translate_number(baseline)
      relative_percent = ((baseline == min_value) ? 0 : ((baseline.to_f - min_value.to_f) / (max_value.to_f - min_value.to_f).to_f))
      return (height.to_f - (height.to_f * relative_percent))
    end
  end
end