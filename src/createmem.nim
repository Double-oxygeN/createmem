import dom, htmlcanvas

const charWidth = 8

type
  uint4 = range[0b0000..0b1111]
  PaletteId = distinct uint4

  Color = tuple
    red, green, blue: uint4
  
  Palette = array[PaletteId, Color]

  Character = array[charWidth * charWidth, PaletteId]

proc download(data, fileName, mimeType: cstring) {.importc.}

proc newPalette: Palette =
  for i in 0b0000..0b1111:
    let
      l =  i div 0b1000
      r = (i div 0b0100) mod 0b10
      g = (i div 0b0010) mod 0b10
      b =  i             mod 0b10
    result[PaletteId(i)] = (
      red: (l * 0b0101 + r * 0b1010).uint4,
      green: (l * 0b0101 + g * 0b1010).uint4,
      blue: (l * 0b0101 + b * 0b1010).uint4)

proc toHex(n: uint4): string =
  result = case n
    of 10: "A"
    of 11: "B"
    of 12: "C"
    of 13: "D"
    of 14: "E"
    of 15: "F"
    else: $n

proc `$`(color: Color): string =
  result = toHex(color.red) & toHex(color.green) & toHex(color.blue)

proc `$`(palette: Palette): string =
  result = ""
  for i in 0b0000..0b1111:
    result &= $palette[PaletteId(i)] & "\p"

proc `$`(character: Character): string =
  result = ""
  for i in 0..<(charWidth * charWidth):
    result &= toHex(character[i].uint4) & "\p"

proc newCharacter: Character =
  for i in 0..<(charWidth * charWidth):
    result[i] = PaletteId(0)

proc drawCharacter(ctx: CanvasRenderingContext2D, ch: Character, pal: Palette, x, y, size: float) =
  for row in 0..<charWidth:
    for column in 0..<charWidth:
      ctx.fillStyle = "#" & $pal[ch[row * charWidth + column]]
      ctx.fillRect(x + column.toFloat() * size, y + row.toFloat() * size, size, size)

proc drawPalette(ctx: CanvasRenderingContext2D, pal: Palette, x, y, width, height: float) =
  for i in 0b0000..0b1111:
    ctx.fillStyle = "#" & $pal[PaletteId(i)]
    ctx.fillRect(x + (i and 0b0111).toFloat() * width, y + (i div 0b1000).toFloat() * height, width, height)

proc drawCursor(ctx: CanvasRenderingContext2D, cursor: PaletteId, x, y, width, height: float) =
  ctx.lineWidth = 3
  ctx.strokeStyle = "#ff6"
  ctx.strokeRect(x + (cursor.int and 0b0111).toFloat() * width, y + (cursor.int div 0b1000).toFloat() * height, width, height)

window.addEventListener("DOMContentLoaded") do (ev0: Event):
  let
    canvas = document.getElementById("main-canvas").CanvasElement
    ctx = canvas.getContext2D()

    dlPaletteButton = document.getElementById("palette.mem")
    dlCharacterButton = document.getElementById("character.mem")

    paletteColorInput = document.getElementById("palette-color")

  var
    palette = newPalette()
    character = newCharacter()

    cursor = PaletteId(0)
    isMouseDown = false

  # background
  ctx.fillStyle = "#444"
  ctx.fillRect(0, 0, 400, 400)

  # character
  ctx.drawCharacter(character, palette, 60, 10, 35)

  # palette
  ctx.drawPalette(palette, 20, 320, 45, 30)
  ctx.drawCursor(cursor, 20, 320, 45, 30)

  # set download buttons
  dlPaletteButton.addEventListener("click") do (ev: Event):
    download($palette, "palette.mem", "text/plain")

  dlCharacterButton.addEventListener("click") do (ev: Event):
    download($character, "character.mem", "text/plain")

  canvas.addEventListener("mouseup") do (ev: Event):
    let
      mouseX = ev.offsetX
      mouseY = ev.offsetY

    if (mouseX in 60..<340) and (mouseY in 10..<290):
      # mouse up on a character rect
      let pos = ((mouseX - 60) div 35) + ((mouseY - 10) div 35) * charWidth
      character[pos] = cursor

      ctx.drawCharacter(character, palette, 60, 10, 35)

    elif (mouseX in 20..<380) and (mouseY in 320..<380):
      # mouse up on a palette rect
      let pos = ((mouseX - 20) div 45) + ((mouseY - 320) div 30) * 0b1000
      cursor = PaletteId(pos)

      ctx.drawPalette(palette, 20, 320, 45, 30)
      ctx.drawCursor(cursor, 20, 320, 45, 30)

    isMouseDown = false

  canvas.addEventListener("mousemove") do (ev: Event):
    let
      mouseX = ev.offsetX
      mouseY = ev.offsetY

    if isMouseDown and (mouseX in 60..<340) and (mouseY in 10..<290):
      # mouse move on a character rect
      let pos = ((mouseX - 60) div 35) + ((mouseY - 10) div 35) * charWidth
      character[pos] = cursor

      ctx.drawCharacter(character, palette, 60, 10, 35)

  canvas.addEventListener("mousedown") do (ev: Event):
    isMouseDown = true

