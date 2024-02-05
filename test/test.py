# SPDX-FileCopyrightText: © 2024 Gonsolo
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_multiply(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    # Set the input values, wait for valid output, and check the output
    dut._log.info("Test")
    dut.ui_in.value = 0x40
    dut.uio_in.value = 0x40

    while dut.uio_out.value[0] != 1:
        await ClockCycles(dut.clk, 1)
        #print(dut.uio_out.value[0])

    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0x40
