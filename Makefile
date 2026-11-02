# ==============================================================================
# Makefile for Azmain's Bare-Metal Profile Bootloader & OS Image
# ==============================================================================

ASM = nasm
QEMU = qemu-system-x86_64
SRC_DIR = src
BUILD_DIR = build
TARGET = $(BUILD_DIR)/boot.img

.PHONY: all clean run record

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/stage1.bin: $(SRC_DIR)/stage1_mbr.asm | $(BUILD_DIR)
	$(ASM) -f bin $< -o $@
	@echo "[+] Compiled Stage 1 MBR ($$(wc -c < $@) bytes, must be 512)"

$(BUILD_DIR)/stage2.bin: $(SRC_DIR)/stage2_payload.asm | $(BUILD_DIR)
	$(ASM) -f bin $< -o $@
	@echo "[+] Compiled Stage 2 Payload ($$(wc -c < $@) bytes)"

$(TARGET): $(BUILD_DIR)/stage1.bin $(BUILD_DIR)/stage2.bin
	cat $^ > $@
	@echo "[+] Assembled Bootable OS Image: $@ ($$(wc -c < $@) bytes)"

run: $(TARGET)
	@echo "[*] Booting in QEMU (Press Ctrl+A then X to exit)..."
	$(QEMU) -drive format=raw,file=$(TARGET),if=floppy -nographic -serial stdio

# Headless record mode used by CI
record: $(TARGET)
	@mkdir -p assets
	timeout --preserve-status 6s $(QEMU) -drive format=raw,file=$(TARGET),if=floppy -nographic -serial stdio

clean:
	rm -rf $(BUILD_DIR)
