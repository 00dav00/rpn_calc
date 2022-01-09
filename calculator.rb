# frozen_string_literal: true

require_relative 'rpn_calculator'
require_relative 'console_input_parser'

calculator = RpnCalculator.new

loop do
  print '> '
  STDOUT.flush
  input = gets.chomp

  break if input == 'q'

  begin
    parsed_input = ConsoleInputParser.parse(input)
    p calculator.calc(parsed_input[:operands], parsed_input[:operators])
  rescue ArgumentError => e
    p e.message
  end
end
