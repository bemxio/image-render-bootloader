# constants
AS = nasm
ASFLAGS = -f bin

PYTHON = python3

QEMU = qemu-system-i386
QEMUFLAGS = -m 1M

GDB = gdb

SRC_DIR = src
BUILD_DIR = build

SOURCES = $(sort $(wildcard $(SRC_DIR)/*.asm))
EXECUTABLE = bootloader.bin

PALETTE_PATH = $(SRC_DIR)/palette.json
IMAGE_PATH = image.png

# targets
all: $(BUILD_DIR)/$(EXECUTABLE)

run: $(BUILD_DIR)/$(EXECUTABLE)
	$(QEMU) $(QEMUFLAGS) -drive format=raw,file=$^ 

debug: $(BUILD_DIR)/$(EXECUTABLE)
	$(QEMU) $(QEMUFLAGS) -S -gdb tcp::2137 -drive format=raw,file=$^ &
	$(GDB) $^ -ex "target remote localhost:2137"

clean:
	rm -rf $(BUILD_DIR)

# rules
$(BUILD_DIR)/$(EXECUTABLE): $(BUILD_DIR)/code.bin $(BUILD_DIR)/data.bin
	cat $^ > $@

$(BUILD_DIR)/code.bin: $(SOURCES) | $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(BUILD_DIR)/data.bin: $(IMAGE_PATH) $(PALETTE_PATH) | $(BUILD_DIR)
	$(PYTHON) $(SRC_DIR)/converter.py --palette_path $(PALETTE_PATH) $< -o $@

$(BUILD_DIR):
	mkdir -p $@