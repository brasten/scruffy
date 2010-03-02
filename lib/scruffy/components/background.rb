module Scruffy
  module Components
    class Background < Base
      def draw(svg, bounds, options={})
        fill = nil
        case options[:theme].background
        when Symbol, String
          fill = options[:theme].background.to_s
        when Array
          fill = "url(#BackgroundGradient) #{options[:theme].background[0]}" # the second part is a fallback for Firefox, which does support gradient fills, but unfortunately can't handle url(#fragment) references for SVGs loaded from a data: URI (whereas it does work ok for external images); if we don't specify a solid fallback color it fills black!
          svg.defs {
            svg.linearGradient(:id=>'BackgroundGradient', :x1 => '0%', :y1 => '0%', :x2 => '0%', :y2 => '100%') {
              svg.stop(:offset => '5%', 'stop-color' => options[:theme].background[0])
              svg.stop(:offset => '95%', 'stop-color' => options[:theme].background[1])
            }
          }
        end

        # Render background (maybe)
        svg.rect(:width => bounds[:width], :height => bounds[:height], :x => "0", :y => "0", :fill => fill) unless fill.nil?
      end
    end
  end
end