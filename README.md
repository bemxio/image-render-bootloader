# image-render-bootloader
A [16-bit real mode](https://en.wikipedia.org/wiki/Real_mode) program running inside the [bootsector](https://en.wikipedia.org/wiki/Boot_sector), designed to render an image using [VBE](https://en.wikipedia.org/wiki/VESA_BIOS_Extensions)'s 800x600 24-bit color mode. Written in Assembly (Intel syntax), designed to be simple and lightweight. Uses [FFmpeg](https://ffmpeg.org/) for image conversion.

## Usage
To build the project in the intended way, simply follow the instructions below.

You can do it the manual way with an assembler, a converter that will genenerate the image data for you and an emulator of your choice too, but then, you're on your own.

### Dependencies
#### Windows
For Windows, you can install [Scoop](https://scoop.sh/) and use it to install the necessary packages:
```powershell
scoop install nasm ffmpeg make
```

#### Linux
As for Linux, all of the packages should be in your default package manager. Here's an example for Debian-based distributions:
```bash
sudo apt install nasm ffmpeg make
```

If you want to run the project, you'll need to install [QEMU](https://www.qemu.org/) as well, which can be done with either `scoop install qemu` or `sudo apt install qemu-system-x86`, depending on your OS.

### Building
Before building the project, you will need to do a couple of things. 

1. Get the image you want to render and put it inside the root directory of the project. It can be anything you want, as long as the format is supported by FFmpeg.
2. Open the [`Makefile`](Makefile) and edit variables accordingly. The one you will most likely need to change is `IMAGE_PATH`, which should be set to the path of the image you downloaded in the previous step.
3. Simply run `make` in the root directory of the project.

This will output the final image inside the `build/image.img` file.
If you've installed QEMU and want to run the project, you can do so by running `make run` in the root directory of the project.

## Compatibility
The code makes a lot of assumptions about the environment it runs in, without checking if they are true, for simplicity's sake. As such, there might be some adjustments needed in order to run it on a real machine.

So far, it has been tested on:
- QEMU 10.0.0
- VirtualBox 7.1.10 (after converting the image to VDI)

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Contributions are welcome, really welcome, in fact! If you want to contribute, whether it's just a simple bug fix or a whole new feature, feel free to do so.