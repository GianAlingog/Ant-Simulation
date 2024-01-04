class Food {

    // This is the Food
    // For now, only one Food should be present at all times.
    // Randomly spawning, yet should not spawn within a certain radius of the Ant Hill.
    
    int size;
    float posX, posY;
    final int clearance = 50;
    final int baseSize = 100; // I understand that this a bad way to do it, but I'm lazy.
    
    Food(int size) {
        this.size = size;
        
        // just checks if it's too close to a base (currently only implementing for one center base and one food)
        // don't worry I also "love" the readability of this code..
        posX = random(0 + size + clearance, width - clearance * 3 - baseSize);
        posY = random(0 + size + clearance, height - clearance * 3 - baseSize);
        
        posX = ((abs(posX - width/2) < baseSize/2 + clearance + size/2) ? (posX + clearance * 3 + baseSize) : posX);
        posY = ((abs(posY - height/2) < baseSize/2 + clearance + size/2) ? (posY + clearance * 3 + baseSize) : posY);
        
        ellipse(posX, posY, size, size);
    }
    
    void update() {
        ellipse(posX, posY, size, size);
    }
}
