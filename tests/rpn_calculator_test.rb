# frozen_string_literal: true

require_relative '../rpn_calculator'
require 'minitest/autorun'

describe RpnCalculator do
  describe '#can_resolve?' do
    it 'returns false when operands or operatos are empty' do
      calculator = RpnCalculator.new
      assert_equal(false, calculator.can_resolve?(operands: [1], operators: []))
      assert_equal(false, calculator.can_resolve?(operands: [], operators: ['+']))
    end

    it 'returns false when operands size is greater than operators size by more than 1' do
      calculator = RpnCalculator.new
      assert_equal(false, calculator.can_resolve?(operands: [1, 2, 3], operators: ['+']))
      assert_equal(false, calculator.can_resolve?(operands: [1, 2, 3, 4], operators: ['-']))
    end

    it 'returns false when operands size is less or equals to operators size' do
      calculator = RpnCalculator.new
      assert_equal(false, calculator.can_resolve?(operands: [1], operators: ['+']))
      assert_equal(false, calculator.can_resolve?(operands: [1], operators: ['-', '+']))
    end

    it 'returns true when operands size is greater than operators size' do
      calculator = RpnCalculator.new
      assert_equal(true, calculator.can_resolve?(operands: [1, 2], operators: ['+']))
      assert_equal(true, calculator.can_resolve?(operands: [1, 2, 3], operators: ['+', '-']))
    end
  end

  describe '#calc' do
    it 'returns the operation result' do
      calculator = RpnCalculator.new

      assert_equal(2, calculator.calc([1, 1], ['+']))
    end

    it 'raises an error if number of operands is not greater than operators by 1' do
      expect { RpnCalculator.new.calc([5, 5, 5], ['+']) }.must_raise(ArgumentError)
      expect { RpnCalculator.new.calc([15], ['+', '+', '+']) }.must_raise(ArgumentError)
      expect { RpnCalculator.new.calc([1], ['+']) }.must_raise(ArgumentError)
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
  end
end
