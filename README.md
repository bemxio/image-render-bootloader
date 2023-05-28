# image-render-bootloader
A bootloader designed to render an image in 256-color VGA mode. 

Uses Floyd-Steinberg dithering to convert a regular RGB image into the data that can be displayed in 256-color VGA mode.

## Usage
To build the bootloader in the easiest way, just follow the instructions below.
You can do it the manual way with an assembler and GIMP but then, you're on your own.

### Installing dependencies
For Windows, you can install [`scoop`](https://scoop.sh/) and run:
```powershell
scoop install nasm make python
```

As for Linux, all of the packages should be in your default package manager. Here's an example for Ubuntu:
```bash
sudo apt install nasm make python3
```

If you want to run the bootloader, you need to install QEMU as well, which can be done with either `scoop install qemu` or `sudo apt install qemu`, depending on your operating system.

### Building
Before building the bootloader, you will need to do a couple of things. 

1. Download the image to be displayed, it can be anything you like. Just remember that the color palette is limited to 256 colors, thus some colors might not look that good.
2. Open the [`Makefile`](Makefile) and edit variables according to your configuration. The one you will most likely need to change is `IMAGE_PATH`, which should be set to the path of the image you downloaded in the previous step.
3. Simply run `make` in the root directory of the project.

This will build the bootloader in the `build/renderer.bin` file.
If you installed QEMU and want to run the bootloader, you can do so by running `make run` in the root directory of the project.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.