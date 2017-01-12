require_relative "pipeline/version"

module Pipeline
  require_relative 'pipeline/operator'
  require_relative 'pipeline/caller'

  def pipeline(arg, &block)
    raise unless block_given?
    Operator.new(arg: arg, block: block, context: self).arg
  end
end
