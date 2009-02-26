module MappingShared
  
  # Provides translation to the relevant general mapping objects when working with method options.
  class OptionsHelper # :nodoc:

    def self.to_content(options)
      if options[:partial]
        Eschaton.current_view.render options
      # TODO Support URLs in general, find a way to assign
      #elsif options[:url]
      #  if options[:include_location] == true
      #    options[:url][:location] = MappingShared::UrlHelper.encode_location(options[:location])
      #  end
      #  script = Eschaton.global_script
      #  #script.declare_variables :url_data => nil
      #  script << "url_data = null;"
      #  script.get(options[:url]) do |data|
      #    script << "alert(data);"
      #  end

      #  :url_data
      elsif options[:javascript]
        Eschaton.global_script << "var javascript = #{options[:javascript]};"

        :javascript
      else
        options[:text]
      end
    end
     
    def self.to_location(mapping_module, options)
      if options.is_a?(mapping_module::Location) || options.is_a?(Symbol) || options.is_a?(String)
        options
      elsif options.is_a?(Array)
        mapping_module::Location.new :latitude => options.first, :longitude => options.second        
      elsif options.is_a?(Hash)
        mapping_module::Location.new options
      end
    end

  end

end