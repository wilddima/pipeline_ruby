module Pipelinify
  class Operator
    attr_reader :block, :arg, :context

    def initialize(arg:, block:, context:)
      @arg = arg
      @block = block
      @context = context
    end

    def call!
      self.instance_eval(&block).arg
    end

    def method_missing(m, *args, &block)
      pipeline = Pipelinify::Pipeline.new(arg: context.send(m, arg), func: m, context: context)
      @arg = pipeline.arg
      pipeline
    end
  end
end