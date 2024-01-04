enum State {
    WORKER,
    CARRIER,
    KING
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
    
    int maxX, maxY; // I will use this later on to either set the boundaries of the ants or have them teleport across the screen.

    float startX, startY;
    
    final int foodSize = 150; // Once again, I understand that this a bad way to do it, but I'm lazy.
    final int baseSize = 100;
    
    Ant(int x, int y) {
        this.maxX = x;
        this.maxY = y;
        
        // startX = random(padding, width - padding);
        startX = random(width/2 - 20, width/2 + 20);
        // startY = random(padding, height - padding);
        startY = random(height/2 - 20, height/2 + 20);
         
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
        // idk why switch-cases dont work on enums
        if (this.state == State.WORKER) { fill(0, 0, 0); }
        if (this.state == State.CARRIER) { fill(255, 165, 0); }
        if (this.state == State.KING) { fill(128, 0, 128); }
    }
    
    void interactFood(Food food) {
        // I apologize for this if statement, multiple if statements kill me inside. wait this checks for a square not circle..
        if (this.state == State.WORKER && (this.position.x + startX > food.posX - foodSize/2 && this.position.x + startX < food.posX + foodSize/2) && (this.position.y + startY > food.posY - foodSize/2 && this.position.y + startY < food.posY + foodSize/2)) {
            this.state = State.CARRIER;
        }
    }
    
    void interactBase(Base base) {
        // More abhorrent if statements (surely there's an easier way to do this...) too lazy to fix rn
        if (this.state == State.CARRIER && (this.position.x + startX > base.posX - baseSize/2 && this.position.x + startX < base.posX + baseSize/2) && (this.position.y + startY > base.posY - baseSize/2 && this.position.y + startY < base.posY + baseSize/2)) {
            this.state = State.WORKER;
        }
    }
}
