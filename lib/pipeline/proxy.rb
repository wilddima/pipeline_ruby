module Pipeline
  # Proxy
  class Proxy < BasicObject
    attr_reader :pipeline_block, :pipeline_argument, :pipeline_context

    def initialize(pipeline_argument:, pipeline_block:, pipeline_context:)
      @pipeline_argument = pipeline_argument
      @pipeline_block = pipeline_block
      @pipeline_context = pipeline_context
    end

    def call
      instance_eval(&pipeline_block).argument
    end

    private

    def method_missing(method_name, *args, &block)
      super unless respond_to_missing? method_name, true
      pipeline = pipeline_element.new(
        argument: pipeline_context.send(method_name, pipeline_argument),
        method_name: method_name,
        context: pipeline_context
      )
      @pipeline_argument = pipeline.argument
      pipeline
    end

    def respond_to_missing?(method_name, include_private = false)
      pipeline_context.respond_to?(method_name, include_private) || super
    end

    def pipeline_element
      ::Pipeline::Element
    end
  end
end
