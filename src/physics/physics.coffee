util = require '../util'
particleModule = require './particle'
Particle = particleModule.Particle


###

  A Particle Physics Simulation

###
class Physics
  # List of all particles in the simulation
  particles: []

  # List of all behaviours
  behaviours: []
  constraints: []

  # The particle emitter
  emitter: null

  constructor: ->
    @clear()

  clear: ->
    @particles = []
    @behaviours = []
    @constraints = []
    @emitter = new Emitter(this)

  addParticle: (particle) -> @particles.push particle

  # Add a behaviour or constraint to the simulation
  add: (effector, state=particleModule.State.ALIVE) ->
    list = if effector instanceof Constraint then @constraints else @behaviours

    list[state] = []  unless list[state]
    list[state].push effector


  update: ->
    @emitter.update()

    particles = @particles

    # apply behaviours
    @applyEffectors @behaviours, particles

    # apply constraints
    @applyEffectors @constraints, particles

    # update all particles
    dead = []
    stateDead = particleModule.State.DEAD

    for particle in particles
      particle.update()
      dead.push particle if particle.state is stateDead
      undefined

    # remove dead particles
    i = dead.length
    while i--
      particle = dead[i]
      util.removeElement particle, particles
      undefined

    undefined


  # --- utilities ---

  # applies all effectors to the given particle list when their states match
  applyEffectors: (effectors, particles) ->
    # go through all states in effectors list
    state = effectors.length
    while state--
      stateEffectors = effectors[state]

      # apply all behaviours for this state if particle is in this state
      for effector in stateEffectors
        effector.prepare this

        for particle in particles
          effector.apply particle if particle.state is state
          undefined

        undefined
      undefined
    undefined

  # returns the number of particles
  size: -> @particles.length


###

  Particle Emitter

###
class Emitter
  rate: 1
  interval: 1
  max: 100

  # @override to create your own particle type
  type: particleModule.Particle3

  # local vars
  timer = -1
  id = 0

  # created with a reference to the original physics particle array
  constructor: (@physics) ->

  update: ->
    if timer is -1 or timer >= @interval
      timer = 0
      i = 0

      while i < @rate and @physics.size() < @max
        p = @create()
        @init p
        i++

    timer++

  create: ->
    p = new @type(id++)
    @physics.addParticle p
    p

  # @overridable initialiser function run on all newly created particles
  init: (particle) ->



###
  Base class for all physical forces, behaviours & constraints
###
class Behaviour
  prepare: ->
  apply: (particle) ->


class Constraint
  prepare: ->
  apply: (particle) ->


module.exports =
  Physics: Physics
  Emitter: Emitter
  Behaviour: Behaviour
  Constraint: Constraint

