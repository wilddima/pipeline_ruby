module Pipelinify
  class Pipeline
    attr_reader :arg, :func, :context

    def initialize(arg:, func:, context:)
      @arg = arg
      @func = func
      @context = context
    end

    def >>(func)
      Pipelinify::Pipeline.new arg: context.send(func.to_sym, arg), func: func, context: context
    end

    def to_sym
      func
    end
  end
end