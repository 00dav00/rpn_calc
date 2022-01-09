# frozen_string_literal: true

require_relative 'rpn_calculator'

# Class to parse input from console
class ConsoleInputParser
  def self.numeric?(input)
    sanitized = input.strip
    result = []

    result << (sanitized.to_i.to_s == sanitized)
    result << (sanitized.to_f.to_s == sanitized)

    result.reduce { |acc, r| acc || r }
  end

  def self.operator?(input)
    RpnCalculator::SUPPORTED_OPERATIONS.include?(input)
  end

  def self.parse(input)
    result = { operands: [], operators: [] }

    input.split(' ').each do |item|
      if numeric?(item)
        result[:operands] << item.to_f
      elsif operator?(item)
        result[:operators] << item
      else
        raise ArgumentError, "'#{item}' is not a valid number or operator"
      end
    end

    result
  end
end
