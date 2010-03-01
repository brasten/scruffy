module Scruffy::Rasterizers

  # == MiniMagickRasterizer
  #
  # Author:: Tim Connor
  # Date:: Feb 9th, 2010
  #
  # The MiniMagickRasterizer converts SVG graphs to images using MiniMagick.
  class MiniMagickRasterizer
    def rasterize(svg, options={})
      require 'mini_magick'

      image = MiniMagick::Image::from_blob(svg)

      image.format(options[:as]) do |cmd|
        cmd.background "#0000" # Transparent background
      end if options[:as]
      
      image.write(options[:to]) if options[:to]
      image.to_blob

    end
  end
end