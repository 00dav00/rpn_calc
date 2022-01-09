# frozen_string_literal: true

require_relative 'console_input_processor'

processor = ConsoleInputProcessor.new

loop do
  print '> '
  STDOUT.flush
  input = gets.chomp

  break if input == 'q'

  begin
    p processor.process!(input)
  rescue ArgumentError => e
    p e.message
  end
end
