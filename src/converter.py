#!/usr/bin/python3

import json
from pathlib import Path
from argparse import ArgumentParser

from PIL import Image

def main(input_path: Path, output_path: Path, palette_path: Path, screen_width: int, screen_height: int):
    image = Image.open(input_path)

    render = Image.new("RGB", (screen_width, screen_height), (0, 0, 0))
    mask = Image.new("P", (16, 16))

    with open(palette_path, "r", encoding="utf-8") as file:
        mask.putpalette(json.load(file))

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
    parser.add_argument("--output_path", "-o", type=Path, help="The output path to the data file.", default=Path("image.bin"))

    parser.add_argument("--palette_path", type=Path, help="The path to the JSON file containing palette values.", default=Path("palette.json"))

    parser.add_argument("--screen_width", type=int, help="The width of the screen.", default=320)
    parser.add_argument("--screen_height", type=int, help="The height of the screen.", default=200)

    args = parser.parse_args()

    main(args.input_path, args.output_path, args.palette_path, args.screen_width, args.screen_height)