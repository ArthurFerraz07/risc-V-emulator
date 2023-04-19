# frozen_string_literal: true

require './double_word'
require 'awesome_print'

# This module implements an arithmetic logic unit.
# Double words have 64 bits
module ALU
  # Cast an integer number to double word
  def integer_to_double_word(number)
    raise 'number should be in interval -(2^64) ~ (2^64)-1' unless DoubleWord.representable_integer?(number)

    negative_number = number.negative?
    number = -number if negative_number

    rounds = 0
    str_result = String.new('')

    div = number
    while div != 0
      rounds += 1
      div, rest = division_with_rest(div)
      str_result = "#{rest}#{str_result}"
      p rounds
    end

    str_result = '0' * (64 - rounds) + str_result

    result = DoubleWord.new(str_result)

    result = negate_double_word(result) if negative_number

    result
  end

  # Cast a float number to double word based on IEEE convention
  def float_to_double_word(number)
    raise 'implementation pending'
  end

  # Cast a number to double word
  def number_to_double_word(number)
    case number.class
    when Integer
      integer_to_double_word(number)
    when Float
      float_to_double_word(number)
    when DoubleWord
      number
    else
      raise "#{number.class} class not suported"
    end
  end

  # Cast a double word to number
  def double_word_to_number(word)
    raise 'implementation pending'
  end

  # Binary sum
  def binary_sum(dword_a, dword_b, allow_overflow: false)
    str_result = String.new('')
    carry = '0'
    64.times do |round|
      raise 'overflow deetected' if !allow_overflow && carry == '1' && round == 63

      i = 63 - round

      bit_a = dword_a.bits[i]
      bit_b = dword_b.bits[i]

      tmp_result = bit_xor(bit_a, bit_b)
      result = bit_xor(tmp_result, carry)

      new_carry = bit_or(
        bit_and(bit_a, bit_b),
        bit_and(carry, tmp_result)
      )

      carry = new_carry

      str_result = result + str_result
    end

    DoubleWord.new(str_result)
  end

  # Binary multiply
  def binary_mul(dword_a, dword_b)
    raise 'implementation pending'
  end

  # Binary division
  def binary_div(dword_a, dword_b)
    raise 'implementation pending'
  end

  # division with rest
  def division_with_rest(number)
    [number / 2, number % 2]
  end

  # negate str binary number
  def negate_double_word(dword)
    new_bits = dword.bits.split('').map { |bit| bit_negate(bit) }.join

    binary_sum(DoubleWord.new(new_bits), integer_to_double_word(1), allow_overflow: true)
  end

  # and operation
  def bit_and(bit_a, bit_b)
    bit_a == '1' && bit_b == '1' ? '1' : '0'
  end

  # bit_or operation
  def bit_or(bit_a, bit_b)
    bit_a == '1' || bit_b == '1' ? '1' : '0'
  end

  # xor operation
  def bit_xor(bit_a, bit_b)
    (bit_a == '1' && bit_b == '0') || (bit_a == '0' && bit_b == '1') ? '1' : '0'
  end

  # negate bit
  def bit_negate(bit)
    bit == '1' ? '0' : '1'
  end
end
