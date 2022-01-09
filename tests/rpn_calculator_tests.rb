# frozen_string_literal: true

require_relative '../rpn_calculator'
require 'minitest/autorun'

describe RpnCalculator do
  describe '#calc' do
    it 'initializes the memo with 0' do
      calculator = RpnCalculator.new
      assert_equal(0, calculator.memo)
    end

    it 'stores the result of calculations in memo' do
      calculator = RpnCalculator.new
      calculator.calc([1, 1], ['+'])

      assert_equal(2, calculator.memo)
    end

    it 'raises an error if number of operands is not equal to number of operators - 1' do
      expect { RpnCalculator.new.calc([5, 5, 5], ['+']) }.must_raise(ArgumentError)
      expect { RpnCalculator.new.calc([15, 5], ['+', '+', '+']) }.must_raise(ArgumentError)
    end

    describe 'performs basic operations' do
      it 'returns the result for sum operations when params are correct' do
        assert_equal(5, RpnCalculator.new.calc([3, 2], ['+']))
        assert_equal(15, RpnCalculator.new.calc([5, 5, 5], ['+', '+']))
      end

      it 'returns the result for subtract operations when params are correct' do
        assert_equal(-1.5, RpnCalculator.new.calc([2, 3.5], ['-']))
        assert_equal(-10, RpnCalculator.new.calc([5, 20, 5], ['-', '-']))
      end

      it 'returns the result for multiplication operations when params are correct' do
        assert_equal(-6, RpnCalculator.new.calc([3, -2], ['*']))
        assert_equal(5.0, RpnCalculator.new.calc([1, 2, 2.5], ['*', '*']))
      end

      it 'returns the result for division operations when params are correct' do
        assert_equal(2.5, RpnCalculator.new.calc([5.0, 2.0], ['/']))
        assert_equal(-1, RpnCalculator.new.calc([3, 15, -5], ['/', '/']))
        # NOTE: Division by 0
      end

      it 'returns the result for combined operations when params are correct' do
        assert_equal(-13.0, RpnCalculator.new.calc([5.0, 5.0, 5.0, 8.0], ['+', '+', '-']))
      end
    end

    describe 'when there is the same number of operands and operators' do
      it 'uses memo to calculate the result' do
        calculator = RpnCalculator.new
        calculator.calc([1], ['+'])

        assert_equal(1, calculator.memo)

        calculator = RpnCalculator.new
        calculator.calc([1], ['*'])

        assert_equal(0, calculator.memo)
      end
    end

    describe 'when there is operators - 1 operands' do
      it 'returns the same number when only 1 is sent' do
        assert_equal(5, RpnCalculator.new.calc([5], []))
        assert_equal(-5, RpnCalculator.new.calc([-5], []))
      end

      it 'performs the operation ignoring memo' do
        calculator = RpnCalculator.new
        calculator.memo = 50

        assert_equal(50, calculator.memo)
        assert_equal(10, calculator.calc([5, 5], ['+']))
      end
    end
  end
end

