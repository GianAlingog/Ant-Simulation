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
    
    int maxX, maxY; // I will use this later on to either set the boundaries of the ants or have them teleport across the screen.
    float startX, startY;
    
    Ant(int x, int y) {
        this.maxX = x;
        this.maxY = y;
        
        startX = random(padding, width - padding);
        startY = random(padding, height - padding);
         
        position = PVector.random2D();
    }

    void update() {
        direction = (direction.add(PVector.random2D().mult(wanderStrength)));
        PVector desiredVelocity = direction.mult(maxSpeed);
        PVector desiredSteerStrength = ((desiredVelocity.sub(velocity)).mult(steerStrength));
        PVector acceleration = desiredSteerStrength.limit(steerStrength);
        
        velocity = (velocity.add(acceleration)).limit(maxSpeed);
        position = position.add(velocity);
        
        float angle = atan2(velocity.y, velocity.x);
        
        pushMatrix();
        translate(position.x + startX, position.y + startY);
        rotate(angle);
        ellipse(0, 0, size, size);
        popMatrix();
  
    }
    
    void draw() {
        ; // I will use this for changing the ant's color based on its state
    }
}
