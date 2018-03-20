## PNG with indexed color to HTML table

This simple script takes a indexed png image and converts to a html table using the color palette in palette_hama.yml

Usage

```
./hama_pngtohtml IMAGE.png [PALETTE_ALTERNATIVE.yml] > test.html
```

You can use an alternative palette using the specified parameter.
The content of that yml file should be:

```
# Source Color to map: corresponding_hama_code in palette_hama.yml
'#FFFFFF': 1
```

This is useful when your image does not have the exact same colors that the provided palette or you want to group different colors under the same hama code.

IMPORTANT: If you provide a alternative palette, all png colors must be in the file.

## Build

```
// This is only compatible with ImageMagick v6
$ brew install imagemagick@6 // OSX
$ bundle install
```
