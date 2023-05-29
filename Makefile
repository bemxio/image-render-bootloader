# constants
AS = nasm
ASFLAGS = -f bin

PYTHON = python3

VM = qemu-system-i386
VMFLAGS = -m 1M

SRC_DIR = src
BUILD_DIR = build

SOURCES = $(sort $(wildcard $(SRC_DIR)/*.asm))

IMAGE_PATH = image.png
FILE_NAME = renderer.bin

# targets
all: $(BUILD_DIR)/$(FILE_NAME)

run: $(BUILD_DIR)/$(FILE_NAME)
	$(VM) $(VMFLAGS) -hda $<

clean:
	rm -rf $(BUILD_DIR)

# rules
$(BUILD_DIR)/$(FILE_NAME): $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/image.bin
	cat $^ > $@

$(BUILD_DIR)/bootloader.bin: $(SOURCES)
	mkdir -p $(BUILD_DIR)

	$(AS) $(ASFLAGS) $< -o $@

$(BUILD_DIR)/image.bin: $(IMAGE_PATH)
	$(PYTHON) -m pip install -r $(SRC_DIR)/converter/requirements.txt

	$(PYTHON) $(SRC_DIR)/converter/main.py $< $@