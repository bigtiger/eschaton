module MappingShared
  
  # Provides helpers for various general map objects when working with urls.
  # This will allow converting to/from encoded url strings when working in rails actions.
  class UrlHelper

    # Encodes the given +location+
    def self.encode_location(location)
      if location.is_a?(Symbol) || location.is_a?(String)
        {:latitude => "##{location}.lat()", :longitude => "##{location}.lng()"}
      else
        {:latitude => location.latitude, :longitude => location.longitude}
      end
    end

  end
  
end