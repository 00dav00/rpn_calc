# frozen_string_literal: true

# Class to process proccess operations in RPN notation
class RpnCalculator
  SUPPORTED_OPERATIONS = '+-*/'

  attr_accessor :operand_memo, :operator_memo

  def calc(operands, operators)
    validate_params!(operands, operators)

    acc = operands.pop

    operands.reverse.each_with_index do |number, index|
      acc = [number, acc].reduce(operators[index].to_sym)
    end

    @operand_memo = acc
  end

  def can_resolve?(operands:, operators:)
    return false if operands.empty? || operators.empty?

    operands.size == operators.size + 1
  end

  private

  def validate_params!(operands, operators)
    return if can_resolve?(operands: operands, operators: operators)

    raise ArgumentError, 'Invalid number of operands or operators'
  end
end
