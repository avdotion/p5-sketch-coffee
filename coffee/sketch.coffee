mysketch = (sketch) ->
  sketch.setup = ->
    sketch.createCanvas 400, 300
    sketch.background 51

  sketch.draw = ->


myp5 = new p5(mysketch)
