require_relative 'pipeline/version'
# Pipeline
#
# @author WildDima
module Pipeline
  require_relative 'pipeline/chain'
  require_relative 'pipeline/element'
  require_relative 'pipeline/proxy'
  # create new Pipeline::Chain, and return result of calculation
  #
  # @example
  #    pipeline('qwe') do
  #      upcase >> split >> reverse >> join
  #    end
  #    # or
  #    pipeline('qwe') { upcase >> split >> reverse >> join }
  def pipeline(arg, &block)
    raise unless block_given?
    Pipeline::Chain.new(pipeline_argument: arg,
                        pipeline_block: block,
                        pipeline_context: self).call
  end
end
