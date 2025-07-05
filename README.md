# image-render-bootloader
A [16-bit real mode](https://en.wikipedia.org/wiki/Real_mode) program running inside the [bootsector](https://en.wikipedia.org/wiki/Boot_sector), designed to render an image in a standard 320x200 256-color video mode. Written in Assembly (Intel syntax), designed to be simple and lightweight. Uses Python with [Pillow](https://pillow.readthedocs.io/en/stable/) and [Floyd-Steinberg dithering](https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering) for image conversion.

## Usage
To build the project in the intended way, simply follow the instructions below.

You can do it the manual way with an assembler, a converter that will genenerate the image data for you and an emulator of your choice too, but then, you're on your own.

### Dependencies
#### Windows
For Windows, you can install [Scoop](https://scoop.sh/) and use it to install the necessary packages:
```powershell
scoop install nasm python make
```

After that, use [`pip`](https://pip.pypa.io/en/stable/) to install Pillow:
```bash
python -m pip install Pillow
```

#### Linux
As for Linux, all of the packages, including Pillow, should be in your default package manager. Here's an example for Debian-based distributions:
```bash
sudo apt install nasm python3 python3-pil make
```

If you want to run the project, you'll need to install [QEMU](https://www.qemu.org/) as well, which can be done with either `scoop install qemu` or `sudo apt install qemu-system-x86`, depending on your OS.

### Building
Before building the project, you will need to do a couple of things. 

1. Get the image you want to render and put it inside the root directory of the project. It can be anything you want, just remember that the color palette is limited to 256 colors, thus some images might not look that good.
2. Open the [`Makefile`](Makefile) and edit variables accordingly. The one you will most likely need to change is `IMAGE_PATH`, which should be set to the path of the image you downloaded in the previous step.
3. Simply run `make` in the root directory of the project.

This will output the final image inside the `build/image.img` file.
If you've installed QEMU and want to run the project, you can do so by running `make run` in the root directory of the project.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Contributions are welcome, really welcome, in fact! If you want to contribute, whether it's just a simple bug fix or a whole new feature, feel free to do so.