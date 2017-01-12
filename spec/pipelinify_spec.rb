require "spec_helper"

describe Pipelinify do
  it "has a version number" do
    expect(Pipelinify::VERSION).not_to be nil
  end

  context 'in class' do
    class Test
      include Pipelinify

      def upcase(arg)
        arg.upcase
      end

      def split(arg)
        arg.split
      end

      def add(arg)
        arg.map { |a| a + '_added*' }
      end

      def reverse(arg)
        arg.reverse
      end

      def join(arg)
        arg.join
      end

      def call(arg)
        pipeline(arg) do
          upcase >> split >> add >> reverse >> join
        end
      end
    end

    let(:test_klass) { Test }

    let(:normal_calculation) do
      test = test_klass.new
      test.join(test.reverse(test.add(test.split(test.upcase('qwe')))))
    end

    subject do
      test = test_klass.new
      test.call('qwe')
    end

    it { should eq(normal_calculation) }
  end
end
