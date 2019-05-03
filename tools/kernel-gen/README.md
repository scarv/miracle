
# Instruction Stream Generation

*Notes on building a tool to generate instruction streams for the
experiments in this project.*

---

- All of listed potential [target platforms](../targets/README.md)
  are RISC architectures with very similar sets of core instructions.
- Specifically, the instructions are similar enough in form and function
  to allow a very generic template to be transformed into an architecture
  specific instruction sequence very easily.

Instruction | ARM M0           | Microblaze         | RISC-V
------------|------------------|--------------------|--------------------
load byte   | `ldr rd,rn,imm`  | `lbui rd,ra,imm`   | `lbu rd,rs1,imm`
load half   | `ldrh rd,rn,imm` | `lhui rd,ra,imm`   | `lhu rd,rs1,imm`
load word   | `ldrb rd,rn,imm` | `lwi  rd,ra,imm`   | `lw  rd,rs1,imm`
store byte  | `str rd,rn,imm`  | `sbi rd,ra,imm`    | `sb  rs1,rs2,imm`
store half  | `strh rd,rn,imm` | `shi rd,ra,imm`    | `sh  rs1,rs2,imm`
store word  | `strb rd,rn,imm` | `swi rd,ra,imm`    | `sw  rs1,rs2,imm`
xor         | `eors rd,rd,rm`  | `xor rd,rs1,rs2`   | `xor rd,rs1,rs2`
xori        | N/A              | `xori rd,rs1,imm`  | `xori rd,rs1,imm`
add         | `add rd,rn,rm`   | `add rd,ra,rb`     | `add rd,rs1,rs2`
addi        | `adds rd,rd,im`  | `addi rd,ra,imm`   | `add rd,rs1,imm`
shift left  | `lsls rd,rd,rs`  | `sll rd,ra,rb`     | `sll rd,rs1,rs2`
shift right | `lsrs rd,rd,rs`  | `srl rd,ra,rb`     | `srl rd,rs1,rs2`
rotate      | `rors rd,rd,rs`  | N/A                | N/A
nop         | `nop`            | `nop`              | `nop`
multiply    | `muls rd,rm,rd`  | `mul rd,ra,rb`     | `mul rd,rs1,rs2`

We can build a very simple macro/template based approach for creating
instruction stream templates, and then post-processing them for a
particular architecture.

