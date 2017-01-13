module Pipeline
  class Operator
    attr_reader :block, :arg, :context

    def initialize(arg:, block:, context:)
      @arg = arg
      @block = block
      @context = context
      self.instance_eval(&block)
    end

    private

    def method_missing(m, *args, &block)
      pipeline = Pipeline::Caller.new(arg: context.send(m, arg), func: m, context: context)
      @arg = pipeline.arg
      pipeline
    end
  end
end