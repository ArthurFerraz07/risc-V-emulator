# frozen_string_literal: true

class Emulator
  # define the 32 registers
  # x0 (zero): the constant value 0
  # x1 (ra): return address
  # x2 (sp): stack pointer
  # x3 (gp): global pointer
  # x4 (tp): thread pointer
  # x5 – x7, x28 – x31 (t0-t6): temporaries
  # x8 (s0/fp): frame pointer / saved register0
  # x9, x18 – x27 (s1-s11): saved registers
  # x10 – x11 (a0, a1): function arguments/results
  # x12 – x17 (a2-a7): function arguments

  attr_accessor(*32.times.map { |i| :"x#{i}" })



end
