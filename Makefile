# constants
AS = nasm
ASFLAGS = -f bin

PYTHON = python3

QEMU = qemu-system-i386
QEMUFLAGS = -m 1M

SRC_DIR = src
BUILD_DIR = build

SOURCES = $(sort $(wildcard $(SRC_DIR)/*.asm))
EXECUTABLE = bootloader.bin

IMAGE_PATH = image.png

# targets
all: $(BUILD_DIR)/$(EXECUTABLE)

run: $(BUILD_DIR)/$(EXECUTABLE)
	$(QEMU) $(QEMUFLAGS) -drive format=raw,file=$^ 

clean:
	rm -rf $(BUILD_DIR)

# rules
$(BUILD_DIR)/$(EXECUTABLE): $(BUILD_DIR)/code.bin $(BUILD_DIR)/data.bin
	cat $^ > $@

$(BUILD_DIR)/code.bin: $(SOURCES) | $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(BUILD_DIR)/data.bin: $(IMAGE_PATH) | $(BUILD_DIR)
	$(PYTHON) $(SRC_DIR)/converter/main.py $< $@

$(BUILD_DIR):
	mkdir -p $@