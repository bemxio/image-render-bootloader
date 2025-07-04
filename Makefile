# constants
AS = nasm
ASFLAGS = -f bin

PYTHON = python3

QEMU = qemu-system-i386
QEMUFLAGS = -monitor stdio

SRC_DIR = src
BUILD_DIR = build

SOURCES = $(sort $(wildcard $(SRC_DIR)/*.asm))
EXECUTABLE = image.img

IMAGE_PATH = image.png
PALETTE_PATH = palette.png

# phony
.PHONY: all run clean

# targets
all: $(BUILD_DIR)/$(EXECUTABLE)

run: $(BUILD_DIR)/$(EXECUTABLE)
	$(QEMU) $(QEMUFLAGS) -drive format=raw,file=$<

clean:
	$(RM) -r $(BUILD_DIR)

# rules
$(BUILD_DIR)/$(EXECUTABLE): $(BUILD_DIR)/bootsector.bin $(BUILD_DIR)/data.bin
	cat $^ > $@

$(BUILD_DIR)/bootsector.bin: $(SOURCES) | $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(BUILD_DIR)/data.bin: $(IMAGE_PATH) $(PALETTE_PATH) | $(BUILD_DIR)
	$(PYTHON) $(SRC_DIR)/converter.py -p $(PALETTE_PATH) $< -o $@

$(BUILD_DIR):
	mkdir -p $@