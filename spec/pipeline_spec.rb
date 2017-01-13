require "spec_helper"

describe Pipeline do
  it "has a version number" do
    expect(Pipeline::VERSION).not_to be nil
  end

  context 'in class' do
    class Test
      include Pipeline

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

      def pipeline_call(arg)
        pipeline(arg) do
          upcase >>
          split >>
          add >>
          reverse >>
          join >>
          upcase >>
          split >>
          add >>
          reverse >>
          join >>
          upcase >>
          split >> 
          add >>
          reverse >>
          join
        end
      end

      def normal_call(arg)
        join(
          reverse(
            add(
              split(
                upcase(
                  join(
                    reverse(
                      add(
                        split(
                          upcase(
                            join(
                              reverse(
                                add(
                                  split(
                                    upcase(arg)
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      end
    end

    let(:test_klass) { Test }

    let(:normal_calculation) do
      test = test_klass.new
      test.normal_call('qwe')
    end

    subject do
      test = test_klass.new
      test.pipeline_call('qwe')
    end

    it { should eq(normal_calculation) }
  end
end
