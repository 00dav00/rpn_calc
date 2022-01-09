# frozen_string_literal: true

require_relative '../console_input_processor'
require 'minitest/autorun'

describe ConsoleInputProcessor do
  it 'initializes with empty memo' do
    procesor = ConsoleInputProcessor.new
    assert_equal('', procesor.memo)
  end

  describe '.process!' do
    describe 'when input contains multiple terms' do
      it 'performs the operation memo and stores result in memo' do
        processor = ConsoleInputProcessor.new

        assert_equal('-13.0', processor.process!('5 5 5 8 + + -'))
        assert_equal('-13.0', processor.memo)
        assert_equal('0.0', processor.process!('13 +'))
        assert_equal('0.0', processor.memo)
      end

      it 'raises an error when operation terms are not correct without erasing memo' do
        processor = ConsoleInputProcessor.new
        processor.memo = '10 1'

        expect { processor.process!('1 2 3 +') }.must_raise(ArgumentError)
        assert_equal('10 1', processor.memo)
      end
    end

    describe 'when input contains a single term' do
      it 'adds term to memo when new input does not make it processable' do
        processor = ConsoleInputProcessor.new
        processor.memo = '-3'

        assert_equal('-2.0', processor.process!('-2'))
        assert_equal('-2.0 -3.0', processor.memo)

        processor = ConsoleInputProcessor.new
        processor.memo = '10 1 3'

        assert_equal('+', processor.process!('+'))
        assert_equal('10.0 1.0 3.0 +', processor.memo)
      end

      it 'performs calculation and stores result in memo when new input makes it processable' do
        processor = ConsoleInputProcessor.new
        processor.memo = '-3 -2'

        assert_equal('6.0', processor.process!('*'))
        assert_equal('6.0', processor.memo)

        processor = ConsoleInputProcessor.new
        processor.memo = '10 1 3 +'

        assert_equal('14.0', processor.process!('+'))
        assert_equal('14.0', processor.memo)
      end
    end
  end
end
