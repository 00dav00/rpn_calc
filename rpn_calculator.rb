# frozen_string_literal: true

# Class to process proccess operations in RPN notation
class RpnCalculator
  SUPPORTED_OPERATIONS = '+-*/'

  attr_accessor :memo

  def initialize
    @memo = 0
  end

  def calc(operands, operators)
    validate_params!(operands, operators)

    acc = operands.size == operators.size ? @memo : operands.pop

    operands.reverse.each_with_index do |number, index|
      acc = [number, acc].reduce(operators[index].to_sym)
    end

    @memo = acc
  end

  def validate_params!(operands, operators)
    message = 'Invalid number of operands or operators'

    raise ArgumentError, message if operands.size < operators.size
    raise ArgumentError, message if operands.size > operators.size + 1
  end
end
