#16-bit Basic Processor (Verilog + Vivado)

This is a Verilog implementation of a microprogrammed 16-bit processor with:


- **16-bit data path**: Registers like AC, MDR, and RI operate on 16 bits.
- **12-bit address bus**: Supports 4096 memory locations.
- **Microprogrammed Control Unit**: Uses control signals (F1–F49) for micro-operation sequencing.
- **25 microinstruction cycles**, including:
  - Fetch cycle
  - Indirect addressing cycle
  - Execution cycles for:
    - 7 memory-reference instructions (IRM)
    - 12 register-reference instructions (IRR)
    - 4 input/output instructions (IES) + LDI
- **Preloaded RAM**: Includes sample programs to test instruction ( LDA, ADD, OUT, HLT).
- **Timing signal generator** : its a 4-bit shift register

## How to Run

1. Clone this repository
2. Open `project_Basic_processor.xpr` in Vivado.
3. Run simulation for testbench  `PB_TOP_tb`)

## 🐞 Issue: Incorrect MDR Data During Execution
### ❌ Problem Description
During instruction execution, the MDR Instead of loading 0005, MDR contains 9101 (stale instruction value).
As a result, the ALU performs an incorrect addition, causing AC to be corrupted. 

### ✅ LDA Instruction: Works Fine

- Example: `mem[0x000] = 16'hA100;` (LDA 0x100)
- The instruction fetch and operand load both complete successfully.
- AC is correctly loaded with `mem[0x100]`.

### ❌ Failing Instruction Example: `ADD` (Opcode 9)

When executing:
```verilog
mem[0x000] = 16'h9101; // ADD from address 0x101
mem[0x101] = 16'h0005; // Expected operand
```
