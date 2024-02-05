<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

It multiplies two float values. Currently only the first byte of two input summands are read, the rest is fixed.
Then the first byte of the output is written.

## How to test

The cocotb test writes two values, waits for the output valid bit and checks the result.

## External hardware

None.

