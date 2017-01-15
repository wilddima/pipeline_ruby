module Pipeline
  # Class, which create new Pipeline::Element from each method in pipeline chain.
  #
  # @author WildDima
  class Chain
    # attr_reader :pipeline_block, :pipeline_argument, :pipeline_context
    attr_reader :pipeline

    def initialize(pipeline)
      @pipeline = pipeline
    end

    def call
      call_proxy
    end

    private

    def proxy
      Pipeline::Proxy
    end

    def new_proxy
      proxy.new(pipeline)
    end

    def call_proxy
      new_proxy.call
    end
  end
end
