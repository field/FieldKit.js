
class Color
  constructor: (@r=0, @g=0, @b=0, @a=256) ->

  set: (color) ->
    @r = color.r
    @g = color.g
    @b = color.b

  randomize: ->
    @r = Math.floor(Math.random() * 256)
    @g = Math.floor(Math.random() * 256)
    @b = Math.floor(Math.random() * 256)

  clone: -> new Color(@r, @g, @b, @a)

  equals: (other) ->
    return false if not other?
    @r == other.r and @g == other.g and @b == other.b and @a == other.a

  toString: ->
    "fk.Color(#{@r},#{@g},#{@b},#{@a})"

module.exports =
  Color: Color