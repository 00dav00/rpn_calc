# frozen_string_literal: true

require_relative '../console_input_parser'
require 'minitest/autorun'

describe ConsoleInputParser do
  describe '.is_numeric?' do
    it 'returns true for positive and negative integers and ignore spaces' do
      assert_equal(true, ConsoleInputParser.numeric?('5'))
      assert_equal(true, ConsoleInputParser.numeric?('0 '))
      assert_equal(true, ConsoleInputParser.numeric?('-15'))
    end

    it 'returns true for positive and negative floats and ignore spaces' do
      assert_equal(true, ConsoleInputParser.numeric?('5.4'))
      assert_equal(true, ConsoleInputParser.numeric?('0.1'))
      assert_equal(true, ConsoleInputParser.numeric?('-15.7 '))
    end

    it 'returns false for other chars' do
      assert_equal(false, ConsoleInputParser.numeric?('x'))
      assert_equal(false, ConsoleInputParser.numeric?('+'))
      assert_equal(false, ConsoleInputParser.numeric?('*'))
      assert_equal(false, ConsoleInputParser.numeric?(' '))
    end
  end

  describe '.operator?' do
    it 'returns true for supported operations' do
      assert_equal(true, ConsoleInputParser.operator?('+'))
      assert_equal(true, ConsoleInputParser.operator?('-'))
      assert_equal(true, ConsoleInputParser.operator?('*'))
      assert_equal(true, ConsoleInputParser.operator?('/'))
    end

    it 'returns false other characters' do
      assert_equal(false, ConsoleInputParser.operator?('%'))
      assert_equal(false, ConsoleInputParser.operator?('x'))
    end
  end

  describe '.parse' do
    it 'returns a list of operands and operators when input is correct' do
      assert_equal({ operands: [1.0], operators: ['+'] }, ConsoleInputParser.parse('1 +'))
      assert_equal({ operands: [1.0], operators: ['+'] }, ConsoleInputParser.parse('1     + '))
      assert_equal(
        { operands: [1.0, 2.0, 3.1, -4.0], operators: ['+', '-', '*', '/'] },
        ConsoleInputParser.parse('1 2 3.1 -4 + - * /')
      )
    end

    it 'raises an error if there is a character that is not an operand nor an operator' do
      expect { ConsoleInputParser.parse('1 x') }.must_raise(ArgumentError)
      expect { ConsoleInputParser.parse('1 - x') }.must_raise(ArgumentError)
    end
  end
end
