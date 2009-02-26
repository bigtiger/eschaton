module FreeEarthViewExt

  def include_free_earth_javascript(options = {})
    options.default! :include_jquery => true

    options.assert_valid_keys :include_jquery

    jquery_script = self.include_jquery_javascript if options[:include_jquery] == true
    free_earth_script = "<script type=\"text/javascript\" src=\"http://freeearth.poly9.com/api.js\"></script>"

    collect jquery_script, free_earth_script
  end
  
  # Creates a free earth map div with the given +options+. See MappingSharedViewExt#map_div for details.
  def free_earth_map(options = {})
    self.map_div options
  end  
  
  
end