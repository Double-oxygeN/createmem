import dom

type
  CanvasElement* = ref CanvasElementObj
  CanvasElementObj {.importc.} = object of dom.Element

  CanvasRenderingContext2D* = ref CanvasRenderingContext2DObj
  CanvasRenderingContext2DObj {.importc.} = object
    canvas*: CanvasElement
    fillStyle*: cstring
    font*: cstring
    globalAlpha*: range[0.0..1.0]
    globalCompositeOperation*: cstring
    lineWidth*: cdouble
    lineCap*: cstring
    lineJoin*: cstring
    miterLimit*: cdouble
    lineDashOffset*: cdouble
    shadowBlur*: range[0.0..Inf]
    shadowOffsetX*: cdouble
    shadowOffsetY*: cdouble
    strokeStyle*: cstring
    textAlign*: cstring
    textBaseline*: cstring

  TextMetrics* = ref TextMetricsObj
  TextMetricsObj {.importc.} = object
    width*: cdouble

proc getContext2D*(cv: CanvasElement): CanvasRenderingContext2D =
  {.emit: "`result` = `cv`.getContext('2d');".}

proc clearRect*(ctx: CanvasRenderingContext2D; x, y, width, height: float) =
  {.emit: "`ctx.clearRect(`x`, `y`, `width`, `height`);`".}

proc fillRect*(ctx: CanvasRenderingContext2D; x, y, width, height: float) =
  {.emit: "`ctx`.fillRect(`x`, `y`, `width`, `height`);".}

proc strokeRect*(ctx: CanvasRenderingContext2D; x, y, width, height: float) =
  {.emit: "`ctx`.strokeRect(`x`, `y`, `width`, `height`);".}

proc fillText*(ctx: CanvasRenderingContext2D; text: cstring; x, y: float) =
  {.emit: "`ctx`.fillText(`text`, `x`, `y`);".}

proc fillText*(ctx: CanvasRenderingContext2D; text: cstring; x, y: float; maxWidth: range[0.0..Inf]) =
  {.emit: "`ctx`.fillText(`text`, `x`, `y`, `maxWidth`);".}

proc strokeText*(ctx: CanvasRenderingContext2D; text: cstring; x, y: float) =
  {.emit: "`ctx`.strokeText(`text`, `x`, `y`);".}

proc strokeText*(ctx: CanvasRenderingContext2D; text: cstring; x, y: float; maxWidth: range[0.0..Inf]) =
  {.emit: "`ctx`.strokeText(`text`, `x`, `y`, `maxWidth`);".}

proc measureText*(ctx: CanvasRenderingContext2D; text: cstring): TextMetrics =
  {.emit: "`result` = `ctx`.measureText(`text`);".}

proc getLineDash*(ctx: CanvasRenderingContext2D): seq[float] =
  {.emit: "`result` = `ctx`.getLineDash();".}

proc setLineDash*(ctx: CanvasRenderingContext2D; segments: seq[float]) =
  {.emit: "`ctx`.setLineDash(`segments`);".}

proc beginPath*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.beginPath();".}

proc closePath*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.closePath();".}

proc moveTo*(ctx: CanvasRenderingContext2D; x, y: float) =
  {.emit: "`ctx`.moveTo(`x`, `y`);".}

proc lineTo*(ctx: CanvasRenderingContext2D; x, y: float) =
  {.emit: "`ctx`.lineTo(`x`, `y`);".}

proc bezierCurveTo*(ctx: CanvasRenderingContext2D; cp1x, cp1y, cp2x, cp2y, x, y: float) =
  {.emit: "`ctx`.bezierCurveTo(`cp1x`, `cp1y`, `cp2x`, `cp2y`, `x`, `y`);".}

proc quadraticCurveTo*(ctx: CanvasRenderingContext2D; cpx, cpy, x, y: float) =
  {.emit: "`ctx`.quadraticCurveTo(`cpx`, `cpy`, `x`, `y`);".}

proc arc*(ctx: CanvasRenderingContext2D; x, y: float; radius: range[0.0..Inf]; startAngle, endAngle: float; anticlockwise: bool = false) =
  {.emit: "`ctx`.arc(`x`, `y`, `radius`, `startAngle`, `endAngle`, `anticlockwise`);".}

proc arcTo*(ctx: CanvasRenderingContext2D; x1, y1, x2, y2: float; radius: range[0.0..Inf]) =
  {.emit: "`ctx`.arcTo(`x1`, `y1`, `x2`, `y2`, `radius`);".}

proc rect*(ctx: CanvasRenderingContext2D; x, y, width, height: float) =
  {.emit: "`ctx`.rect(`x`, `y`, `width`, `height`);".}

proc fill*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.fill();".}

proc fill*(ctx: CanvasRenderingContext2D; fillRule: cstring) =
  {.emit: "`ctx`.fill(`fillRule`);".}

proc stroke*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.stroke();".}

proc clip*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.clip();".}

proc clip*(ctx: CanvasRenderingContext2D; fillRule: cstring) =
  {.emit: "`ctx`.clip(`fillRule`);".}

proc rotate*(ctx: CanvasRenderingContext2D; angle: float) =
  {.emit: "`ctx`.rotate(`angle`);".}

proc scale*(ctx: CanvasRenderingContext2D; x, y: range[0.0..Inf]) =
  {.emit: "`ctx`.scale(`x`, `y`);".}

proc translate*(ctx: CanvasRenderingContext2D; x, y: float) =
  {.emit: "`ctx`.translate(`x`, `y`);".}

proc transform*(ctx: CanvasRenderingContext2D; a, b, c, d, e, f: float) =
  {.emit: "`ctx`.transform(`a`, `b`, `c`, `d`, `e`, `f`);".}

proc setTransform*(ctx: CanvasRenderingContext2D; a, b, c, d, e, f: float) =
  {.emit: "`ctx`.setTransform(`a`, `b`, `c`, `d`, `e`, `f`):".}

proc drawImage*[I: CanvasElement|ImageElement](ctx: CanvasRenderingContext2D; image: I; dstX, dstY: float) =
  {.emit: "`ctx`.drawImage(`image`, `dstX`, `dstY`);".}

proc save*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.save();".}

proc restore*(ctx: CanvasRenderingContext2D) =
  {.emit: "`ctx`.restore();".}



