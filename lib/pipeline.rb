require_relative 'pipeline/version'

module Pipeline
  require_relative 'pipeline/chain'
  require_relative 'pipeline/element'

  def pipeline(arg, &block)
    raise unless block_given?
    Pipeline::Chain.new(pipeline_argument: arg, pipeline_block: block, pipeline_context: self)
                   .pipeline_argument
  end
end
