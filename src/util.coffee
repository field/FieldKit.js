#
# JavaScript Language Utility Methods
#
util = {}

util.extend = (obj, source) ->
  # ECMAScript5 compatibility based on: http://www.nczonline.net/blog/2012/12/11/are-your-mixins-ecmascript-5-compatible/
  if Object.keys
    keys = Object.keys(source)
    i = 0
    il = keys.length

    while i < il
      prop = keys[i]
      Object.defineProperty obj, prop, Object.getOwnPropertyDescriptor(source, prop)
      i++
  else
    safeHasOwnProperty = {}.hasOwnProperty
    for prop of source
      obj[prop] = source[prop]  if safeHasOwnProperty.call(source, prop)
  obj


module.exports = util