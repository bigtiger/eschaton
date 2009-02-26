module FreeEarth # :nodoc:

  # see http://freeearth-origin.poly9.com/api/reference/FE/Map.html
  class Map < MapObject

    def initialize(options = {})
      options.default! :var => 'map'

      super

      options.assert_valid_keys :center

      self.center = options[:center]
      
      if self.create_var?
        self << "function onFEMapLoad(){"
        self << self.onload_event
        self << "}"
        
        self <<"var #{self.var} = new FE.Map(document.getElementById('#{self.var}'));
                map.onLoad = onFEMapLoad;"

        self.load!
      end 
    end
    
    def center=(location)
      location = MappingShared::OptionsHelper.to_location(FreeEarth, location)

      self.onload_event << "this.setTargetLatLng(#{location.to_js});"
    end

    def center
      "#{self}.getCamera().getTargetLatLng()"
    end    
    
    def onload_event
      @onload_expander ||= ScriptExpander.new
    end
    
  end
  
end
