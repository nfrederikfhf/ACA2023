addi x1, x0, 1 #0
addi x2, x0, 1 #4
add x3, x1, x2 # 8
beq x1, x2, +16 # 12
jal x0, 0 # 16
nop # 20
nop # 24
nop # 28
addi x4, x0, 6
sw x1, 0(x2)
lw x3, 0(x2)
