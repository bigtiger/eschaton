module MappingSharedViewExt

  # Creates a general purpose map div with the given +options+, this is used in the view to display the map.
  #
  # ==== Options:
  # * +id+ - Optional. The id of the map the default being +map+
  # * +fullscreen+ - Optional. A value indicating if the map should be fullscreen and take up all the space in the browser window.
  # * +width+ - Optional. The width of the map in pixels.
  # * +height+ - Optional. The height of the map in pixels.
  # * +style+ - Optional. Extra style attributes to be added to the map provided as standard CSS.
  #
  # ==== Examples:
  #   map_div :fullscreen => true
  #   map_div :width => 600, :height => 650
  #   map_div :width => 600, :height => 650, :style => 'border: 1px dashed black; margin: 10px'
  #   map_div :id => 'my_cool_map'
  def map_div(options = {})
    options.assert_valid_keys :id, :fullscreen, :width, :height, :style
    
    options[:id] ||= 'map'
    
    map_style = options[:style] || ""
    
    if options.extract(:fullscreen)
      map_style << "position: absolute; top: 0; left: 0;
                    height: 100%; width: 100%;
                    overflow: hidden;"
    else
      map_style << "width: #{map_size(options.extract(:width))};" if options[:width]
      map_style << "height: #{map_size(options.extract(:height))};" if options[:height]
    end
    
    options[:style] = map_style
    
    content_tag :div, 'loading map...', options
  end  
  
end