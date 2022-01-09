# frozen_string_literal: true

require_relative 'console_input_parser'
require_relative 'rpn_calculator'

# Class to process console input, will store memo and/or calculate result
class ConsoleInputProcessor
  attr_accessor :memo

  def initialize
    @memo = ''
    @calculator = RpnCalculator.new
  end

  def process!(input)
    result = ''
    parsed_input = ConsoleInputParser.parse(input)
    terms = combine_input_with_memo(parsed_input)

    if multiple_terms?(parsed_input)
      result = calc(terms)
      save_memo!(result)
    elsif @calculator.can_resolve?(**terms)
      result = calc(terms)
      save_memo!(result)
    else
      result = ConsoleInputParser.numeric?(input) ? input.to_f.to_s : input
      save_memo!(terms)
    end

    result
  end

  private

  def save_memo!(value)
    @memo = if value.instance_of?(Hash)
              value.values.map { |v| v.join(' ') }.join(' ')
            else
              value.to_s
            end.strip
  end

  def multiple_terms?(parsed_input)
    parsed_input.values.map(&:size).reduce(:+) > 1
  end

  def combine_input_with_memo(parsed_input)
    parsed_memo = ConsoleInputParser.parse(@memo)

    {
      operands: parsed_input[:operands] + parsed_memo[:operands],
      operators: parsed_memo[:operators] + parsed_input[:operators]
    }
  end

  def calc(terms)
    @calculator.calc(terms[:operands], terms[:operators]).to_s
  end
end
