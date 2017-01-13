module Pipeline
  class Element
    attr_reader :argument, :method_name, :context

    def initialize(argument:, method_name:, context:)
      @argument = argument
      @method_name = method_name
      @context = context
    end

    def >>(other)
      self.class.new(
        argument: context.send(other.to_sym, argument),
        method_name: other,
        context: context
      )
    end

    def to_sym
      method_name
    end
  end
end
