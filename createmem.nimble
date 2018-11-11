# Package

version       = "0.1.0"
author        = "Double-oxygeN"
description   = "Verilog memory file creator"
license       = "Apache-2.0"
srcDir        = "src"
bin           = @["createmem"]


# Dependencies

requires "nim >= 0.19.0"

# Tasks

task b, "build":
  exec "nim js -d:release --opt:speed -o:build/createmem.js src/createmem.nim"

