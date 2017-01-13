module Pipeline
  class Chain
    attr_reader :pipeline_block, :pipeline_argument, :pipeline_context

    def initialize(pipeline_argument:, pipeline_block:, pipeline_context:)
      @pipeline_argument = pipeline_argument
      @pipeline_block = pipeline_block
      @pipeline_context = pipeline_context
      instance_eval(&pipeline_block)
    end

    private

    def method_missing(method_name)
      super unless respond_to?(method_name)
      pipeline = Pipeline::Element.new(
        argument: pipeline_context.send(method_name, pipeline_argument),
        method_name: method_name,
        context: pipeline_context
      )
      @pipeline_argument = pipeline.argument
      pipeline
    end

    def respond_to_missing?(method_name, include_private = false)
      pipeline_context.respond_to?(method_name, true) || super
    end
  end
end
