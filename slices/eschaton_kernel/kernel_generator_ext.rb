module KernelGeneratorExt

  # Declares the variables in javascript.
  #
  #  declare_variables :url_data => 'nil' #=> 'var url_data = null;
  #  declare_variables :url_data => 'nil',
  #                    :name => 'yawningman' #=> var url_data = null; var name = 'yawningman';
  def declare_variables(names_and_values)
    names_and_values.each do |name, value|
      self << "var #{name} = #{value.to_js};"
    end
  end

  # Evaluates the +script+ as javascript on the client.
  def eval(script)
    self << "eval(#{script.to_js});"
  end

  # Writes out a comment with the given +message+.
  #
  #  comment 'this code is awesome!' #=> '/* this code is awesome! */'
  def comment(message)
    self << "/* #{message} */"
  end
  
  # Writes out a javascript "if" statement using the given +condition+. Any code generated within the block will be placed
  # inside the "if" statement.
  #
  #  ==== Examples:
  #
  #  script.if("x == 1") do
  #    script.alert("x is 1!")
  #  end
  def if(condition)
    self << "if(#{condition}){"
    yield self
    self << "}"
  end
    
  # Writes out a javascript "unless" statement using the given +condition+. Any code generated within the block will be placed
  # inside the "unless" statement.
  #
  #  ==== Examples:
  #
  #  script.unless("x == 1") do
  #    script.alert("x is not 1!")
  #  end
  def unless(condition)
    self << "if(!(#{condition})){"
    yield self
    self << "}"
  end

  # Merges the content of +other_generator+ with this generator. The given +options+ are the same as supported by generate.
  def merge(other_generator, options = {})
    self << other_generator.generate(options)
  end

  # Returns script that has been generated and allows for addtional +options+ regarding generation than the default +to_s+ method.
  #
  # ==== Options:
  # * +error_wrapping+ - Optional. Indicates if the script should be wrapped in try..catch blocks, defaulted to +false+.
  # * +strip_each_line+ - Optional. Indicates if leading and trailing whitespace should be stripped from each line, defaulted to +true+.
  # * +inline+ - Optional. Indicates if new lines should be stripped from the generated script, defaulted to +false+.
  def generate(options = {})
    options.default! :error_wrapping => false, :strip_each_line => true, :inline => false
    options.assert_valid_keys :error_wrapping, :strip_each_line, :inline,
    
    reset_rjs_debug = ActionView::Base.debug_rjs
    
    ActionView::Base.debug_rjs = options[:error_wrapping]
    
    output = self.to_s

    output.strip_each_line! if options[:strip_each_line]
    output.gsub!("\n", ' ') if options[:inline]

    ActionView::Base.debug_rjs = reset_rjs_debug
    
    output
  end  
  
end