enum State {
    WORKER,
    CARRIER
}

class Ant {
    State state = State.WORKER;
    
    final float maxSpeed = 5.0;
    final float steerStrength = 0.1;
    final float wanderStrength = 1.0;

    final int padding = 5;
    final int size = 5;
    
    PVector position = new PVector();
    PVector velocity = new PVector();
    PVector direction = new PVector();
    
    int maxX, maxY;

    float startX, startY;
    
    final int baseSize = 200;
    final int foodSize = 150;
    
    Ant(int x, int y) {
        this.maxX = x;
        this.maxY = y;

        startX = maxX / 2;
        startY = maxY / 2;
         
        position = new PVector(startX, startY);
    }

    void update() {
        // Heavily inspired by Sebastian Lague's code for random ant movement (Amazing Game Dev - Highly Recommend!)
        // https://www.youtube.com/watch?v=X-iSQQgOd1A
        // Here is the actual file, although he modifies the code to work for pheromones, which I won't do so we can see how (in)effective ants would be if they didn't have pheromones.
        // https://github.com/SebLague/Ant-Simulation/blob/main/Assets/Scripts/Ant.cs

        // Updates the direction the ant is moving
        // Creates a new vector and steers in that direction, limited by a steerStrength, from the original vector
        direction = (direction.add(PVector.random2D().mult(wanderStrength)));
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
        // I tried to use a switch-case, but it wouldn't work for enums
        if (this.state == State.WORKER) { fill(0, 0, 0); }
        if (this.state == State.CARRIER) { fill(255, 165, 0); }
    }
    
    void interactFood(Food food) {
        // inCircle()
        if (this.state == State.WORKER && (Math.pow(this.position.x - food.posX, 2) + Math.pow(this.position.y - food.posY, 2) < Math.pow(foodSize/2, 2))) {
            this.state = State.CARRIER;
            food.count--;
        }
    }
    
    void interactBase(Base base) {
        // inSquare()
        if (this.state == State.CARRIER && (this.position.x > base.posX - baseSize/2 && this.position.x < base.posX + baseSize/2) && (this.position.y > base.posY - baseSize/2 && this.position.y < base.posY + baseSize/2)) {
            this.state = State.WORKER;
            base.count++;
        }
    }
}
