


ASRCS := $(wildcard *.s)
AOBJ := $(ASRCS:%.s=%.out)
BINS := $(AOBJ:%.out=%.bin)

GCC := riscv64-linux-gnu

all: ${AOBJ} ${BINS}

obj: ${OBJ}

bin: ${BINS}

%.out: %.c
	$(GCC)-gcc -ffreestanding -nostartfiles -nostdlib -nodefaultlibs -Wl,-T,linker.ld $< -o $@ -march=rv32i
	$(GCC)-objdump $@ -d

%.out: %.s
	$(GCC)-as $< -o $@ -march=rv32i -mabi=ilp32
	$(GCC)-objdump $@ -d

%.bin: %.out
	$(GCC)-objcopy -O binary $< $@