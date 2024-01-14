// Ant States
enum State {
    WORKER,
    CARRIER
}

class Ant {
    // Initialize Variables
    State state = State.WORKER;
    
    float maxSpeed = 5.0;
    final float steerStrength = 0.1;
    final float wanderStrength = 500.0;

    final int padding = 5;
    final int size = 5;
    
    PVector position = new PVector();
    PVector velocity = new PVector();
    PVector direction = new PVector();
    PVector basePos = new PVector();
    
    int maxX, maxY, liveTime = 5000;

    boolean feed = false;

    float startX, startY;
    
    final int baseSize = 200;
    final int foodSize = 150;
    
    // Constructor
    Ant(int x, int y) {
        this.maxX = x;
        this.maxY = y;

        startX = maxX / 2;
        startY = maxY / 2;
         
        position = new PVector(startX, startY);
    }

    void update() {
        // Decrease the time the ant has left to live
        liveTime--;

        // Heavily inspired by Sebastian Lague's code for random ant movement (Amazing Game Dev - Highly Recommend!)
        // https://www.youtube.com/watch?v=X-iSQQgOd1A
        // Here is the actual file, although he modifies the code to work for pheromones, which I won't do so we can see how (in)effective ants would be if they didn't have pheromones.
        // https://github.com/SebLague/Ant-Simulation/blob/main/Assets/Scripts/Ant.cs

        // Updates the direction the ant is moving
        // Creates a new vector and steers in that direction, limited by a steerStrength, from the original vector
        if (this.state == State.CARRIER) {
            basePos = new PVector(width/2, height/2);
            maxSpeed = 2.0; // Slower speed because Ant is carrying Food

            // Random movement in direction of Base
            direction = (direction.add(basePos.sub(position).add(PVector.random2D().mult(wanderStrength)))).normalize();
        } else {
            maxSpeed = 5.0; // Max Speed

            // Random direction
            direction = (direction.add(PVector.random2D().mult(wanderStrength))).normalize();
        }

        PVector desiredVelocity = direction.mult(maxSpeed);
        PVector desiredSteerStrength = ((desiredVelocity.sub(velocity)).mult(steerStrength));
        PVector acceleration = desiredSteerStrength.limit(steerStrength);
        
        velocity = (velocity.add(acceleration)).limit(maxSpeed);
        position = position.add(velocity);
        
        float angle = atan2(velocity.y, velocity.x);


        // If position is outside of screen, teleport to the other side (within the screen)
        if (position.x < 0) { position.x += maxX; }
        if (position.x > maxX) { position.x -= maxX; }

        if (position.y < 0) { position.y += maxY; }
        if (position.y > maxY) { position.y -= maxY; }
        

        // Inspired by this amazing tutorial by Processing
        // https://processing.org/tutorials/transform2d
        // Redraws the ant to the screen
        pushMatrix();
        translate(position.x, position.y);
        rotate(angle);
        ellipse(0, 0, size, size);
        popMatrix();
    }
    
    void draw() {
        // State Handler
        // I tried to use a switch-case, but it wouldn't work for enums
        if (this.state == State.WORKER) { fill(0, 0, 0); }
        if (this.state == State.CARRIER) { fill(255, 165, 0); }
    }
    
    void interactFood(Food food) {
        // Checks if the Ant is not already carrying Food and is within the Food
        // Note: Implement an inCircle() method
        if (food.count > 0 && this.state == State.WORKER && (Math.pow(this.position.x - food.posX, 2) + Math.pow(this.position.y - food.posY, 2) < Math.pow(foodSize/2, 2))) {
            this.state = State.CARRIER; // Change Ant State
            food.count--; // Update Counter
        }
    }
    
    void interactBase(Base base) {
        // Checks if the Ant is carrying Food and is within the Base
        // Note: Implement an inSquare() method
        if (this.state == State.CARRIER && (this.position.x > base.posX - baseSize/2 && this.position.x < base.posX + baseSize/2) && (this.position.y > base.posY - baseSize/2 && this.position.y < base.posY + baseSize/2)) {
            this.state = State.WORKER; // Change Ant State
            base.count++; // Update Counter
            liveTime = 5000; // Reset lifespan
            feed = true; // Utilized for birth (See Ant_Simulation.pde)
        }
    }
}
