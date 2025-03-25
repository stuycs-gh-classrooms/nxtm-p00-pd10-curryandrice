[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/gbHItYk9)
## Project 00
### NeXTCS
### Period: 
## Name0: Nihal Robi
## Name1: Vincent Wu
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: 

- Force of attraction torwards edge of screen

### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

- Gravity formula but calculating distance for each point along the edge, with no additional mass.

### Custom Force
What information that is already present in the `Orb` or `OrbNode` classes does this force use?

- center and mass.

 Does this force require any new constants, if so what are they and what values will you try initially?
 
- we need a new constant for the eq, we will try a value similar to g

 Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
 
- No.

Does this force interact with other `Orbs`, or is it applied based on the environment?

- Applied based on environment.

In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?

- Create a for loop iterating to width/height and applies force of that coordinate each time to selected ball.

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

- We could disable all forces except gravity (heavily reduced), attractive forces, and drag and then heavily increase drag to slow down movement. It may also be needed to set a minimum distance to prevent the planets from getting too close. 

--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

- We will have two balls connected by a spring. all other forces will be turned off. One of the balls will have some intital velocity that will help demonstrate the effect of spring force on the other ball. When it approaches the other ball, it will be pushed back by the compressive force that has built up in the spring and the other ball will be pushed back by the transfered force. 

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

- We have a row of balls that all have velocity in the same direction. They will pass through two distinct, color-coded zones that have different drag coefficients. This will demonstrate the effect of drag on their movement as they slow down. 

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

- We will have a row of orbs centered on the screen. They will have no initial velocity and the only force enabled will be our custom force. It will slowly accelerate the balls towards the edges of the screen. 

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

- drag, our custom force, spring force. The setup will be a row of balls, evenly split between the two "drag zones". they will be centered on the screen and connected through springs. We will see that the springs will pull all the balls toward the middle edges of the screen due to the pulling effect of the balls closer to the center have a shorter distance to their edges due to the pythagorean theorem. The different drag zones will create an effect where one side of the screen will have this process happen faster than the other. We expect for both sides to reach an endpoint where all balls are near the top and bottom edges of the screen.
