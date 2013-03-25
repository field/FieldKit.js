
# fits the given value between min and max
fit01 = (value, min, max) -> value * (max - min) + min

# returns a new random number between min and max
randF = (min, max, rng) ->
  r = if rng? then rng.next() else Math.random()
  r * (max - min) + min

randI = (min, max, rng) -> Math.floor randF(min, max, rng)


module.exports =
  fit01: fit01
  randF: randF
  randI: randI