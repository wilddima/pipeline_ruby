module Pipeline
  # Element
  #
  # @author WildDima
  class Element
    attr_reader :argument, :method_name, :context

    def initialize(argument:, method_name:, context:)
      @argument = argument
      @method_name = method_name
      @context = context
    end

    # Create new Element object, where pass as argument, calculated by context#send value
    def >>(other)
      self.class.new(
        argument: context.send(other.to_sym, argument),
        method_name: other,
        context: context
      )
    end

    # Return method name
    #
    # @example
    #    el = Element.new(argument: 'qwe',method_name: :upcase, context: Test.new)
    #    el.to_sym # => :upcase
    def to_sym
      method_name
    end
  end
end
