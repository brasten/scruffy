module Scruffy::Helpers
  
  module Marker
    
    def each_marker(markers, min, max, width, options, format_key)
       all_values = []

      (0...markers).each do |idx|
        percent = idx.to_f / (markers-1)
        all_values << min + (max - min) * percent
      end

      all_values.size.times do |idx|
        location = idx.to_f * width/(markers-1)
        marker_value = all_values[idx]
        marker_value = options[format_key].route_format(marker_value, idx, options.merge({:all_values => all_values})) if options[format_key]

        yield marker_value, location
      end  

    end
  end
end