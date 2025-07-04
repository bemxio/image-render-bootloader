#!/usr/bin/python3

from pathlib import Path
from argparse import ArgumentParser

from PIL import Image

def parse_palette(palette_path: Path) -> list[int]:
    image = Image.open(palette_path)
    data = image.getdata()

    return [value for pixel in data for value in pixel]

def convert_image(input_path: Path, output_path: Path, palette_path: Path, screen_width: int, screen_height: int) -> None:
    image = Image.open(input_path)
    render = Image.new("RGB", (screen_width, screen_height), (0, 0, 0))

    mask = Image.new("P", (16, 16))
    palette = parse_palette(palette_path)

    mask.putpalette(palette)

    width = int(image.width * (screen_height / image.height))
    height = screen_height

    position = (screen_width - width) // 2

    image = image.convert("RGB")
    image = image.resize((width, height))

    render.paste(image, (position, 0))

    render = render.quantize(palette=mask, dither=Image.FLOYDSTEINBERG)
    data = bytes(render.getdata())

    with open(output_path, "wb") as file:
        file.write(data)

    #render.show()

if __name__ == "__main__":
    parser = ArgumentParser(description="A script for converting an image for use with the bootloader.")

    parser.add_argument("input_path", type=Path, help="The input path to the image.")
    parser.add_argument("--output_path", "-o", type=Path, help="The output path to the data file. Defaults to \"image.bin\".", default=Path("image.bin"))

    parser.add_argument("--palette_path", "-p", type=Path, help="The path to the image containing the available palette. Defaults to \"palette.png\".", default=Path("palette.png"))

    parser.add_argument("--screen_width", type=int, help="The width of the screen. Defaults to 320.", default=320)
    parser.add_argument("--screen_height", type=int, help="The height of the screen. Defaults to 200.", default=200)

    convert_image(**vars(parser.parse_args()))