# Work Log

## Anna

### 5/22/23

Created the files with the outline of methods and all variables in ball(set final variables by scaling down real life data). Complete accessor methods and revised ball construction to differ in color from background. Finished basic version of move() with velocity and bounce(no friction) and using onBoard to remove ball if scored.


### 5/23/23

<<<<<<< HEAD
Apply move() in draw and test its functionality. Also revised movement by including acceleration as a factor and fixed issues with bouncing around borders. Used physics formulas to calculate force, acceleration, and velocity as well as friction force based on the friction coefficient of 0.06 although it still needs more testing.
=======
Apply move() in draw and test its functionality. Also revised movement by including acceleration as a factor and fixed issues with bouncing around borders. Used physics formulas to calculate force, acceleration, and velocity as well as friction force based on the friction coefficient of 0.06 although more testing is needed.
>>>>>>> b23fbce7c7750afc3a7d026b82ecc9e0e116300c


### 5/24/23

Fixed friction with Maya. Also began working on the CueBall class, using mousePressed() and mouseReleased() to control the strength and direction it is hit. Actual implementation still needs to be done but the overall outline and plan has been completed.

### 5/25/23

Continued working on cueBall aiming and completed initial mouse controls and booleans/restrictions on aiming or creating new balls. Also began fixing move() and applyFriction() in order to use player controlled direction and strength(of aiming) variables rather than just gravitational force.

### 5/26/23

Started to revise cueBall aiming to use mouseDragged instead of mouseClicked or mouseReleased.


### 5/27/23

Revised Maya's version of aiming with mouseDragged to utilize the distance the mouse has been dragged in order to set the strength of the ball shot, with restrictions on minimum and maximum strength. draw() has also been modified to show these changes on the arrow, with the distance being the length of the aiming arrow(although the exact triangle shape has to be revised as at certain values of strength it looks off and isn't isosceles).

## Maya

### 5/22/23

Started working on the setup() in Game for pool table graphics in class. At home, completed the initial ball class (constructor and getShape()) and added the ability to add balls.

### 5/23/23

Changed ball graphics to include stripe/no stripe, and number (modified getShape(), constructor, and Game for random selection). At home, wrote isOverlapping() and canPlace() to solve the issue of overlapping balls.

### 5/24/23

fixed balls drawing over the edges issue. Modified Ball and Game to add friction to the simulation. Added collision, which works, but still has some major bugs.

### 5/25/23

Tried a different model for handling collisions, but didn't work. Made progress towards fixing the old collision simulator.

### 5/26/23

Finished working on collisions. Added new constructor to Ball to include color. Added a new controller class, and modified Game to add the ability to aim and shoot the cue ball.

### 5/27/23

Edited Ball and Game to implement a power bar that can control shot strength. 
