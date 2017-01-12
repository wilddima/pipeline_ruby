require_relative "pipelinify/version"

module Pipelinify
  require_relative 'pipelinify/operator'
  require_relative 'pipelinify/pipeline'

  def pipeline(arg, &block)
    raise unless block_given?
    Operator.new(arg: arg, block: block, context: self).call!
  end
end
