# frozen_string_literal: true

require './alu'
require './double_word'
require './memory'

# This class describes a risc V emulator
class Emulator
  include ALU
  # define the 32 registers

  # x1 (ra): return addres_regs
  # x2 (sp): stack pointer
  # x3 (gp): global pointer
  # x4 (tp): thread pointer
  # x8 (s0/fp): frame pointer / saved register0
  # x9, x18 – x27 (s1-s11): saved registers
  # x10 – x11 (a0, a1): function arguments/results
  # x12 – x17 (a2-a7): function arguments

  # x0 (zero): the constant value 0
  attr_reader :x0

  # x5 – x7, x28 – x31 (t0-t6): temporaries
  attr_accessor :x5, :x6, :x7, :x28, :x29, :x30, :x31

  attr_reader :memory

  # The default memory size is 1024 positions
  def initialize(memory_size = 2**6)
    @x0 = 0
    @memory = Memory.new(memory_size)
  end

  # add risc-v operation. receives two registers and sum them values
  # add x5, x20, x21
  def add(res_reg, reg_a, reg_b)
    send("#{res_reg}=", send(reg_a) + send(reg_b))
  end

  # addi risc-v operation. receives a register and an immediate and sum them values
  # addi x5, x20, 10
  def addi(res_reg, reg_a, immediate)
    send("#{res_reg}=", send(reg_a) + immediate)
  end

  # sub risc-v operation. receives two registers and sub them values
  # sub x5, x20, x21
  def sub(res_reg, reg_a, reg_b)
    send("#{res_reg}=", send(reg_a) - send(reg_b))
  end

  # ld risc-v operation. receives two registers and a offset
  # ld x5, 8(x6)
  def ld(res_reg, offset, _reg_base = nil)
    # the position value is not have been calculated correctly, because the registers are storing the values, not the momory position
    position = offset
    send("#{res_reg}=", memory.load_value(position))
  end

  # sd risc-v operation. receives two registers and a offset
  # sd x5, 8(x6)
  def sd(res_reg, offset, _reg_base = nil)
    # the position value is not have been calculated correctly, because the registers are storing the values, not the momory position
    position = offset
    memory.store_value(position, send(res_reg))
  end
end
