class Food {

    // This is the Food
    // For now, only one Food should be present at all times.
    // Randomly spawning, yet should not spawn within a certain radius of the Ant Hill.
    
    int size, replaceTime = 400, count = int(random(40, 61)); // 40-60
    float posX, posY;
    final int clearance = 50;
    final int baseSize = 200;
    
    Food(int size) {
        this.size = size;
        
        // Makes sure the Food doesn't spawn in too close to the Base
        // Note: This could spawn outside the screen, will fix soon.
        posX = random(0 + size + clearance, width - clearance * 3 - baseSize);
        posY = random(0 + size + clearance, height - clearance * 3 - baseSize);
        
        posX = ((abs(posX - width/2) < baseSize/2 + clearance + size/2) ? (posX + clearance * 3 + baseSize) : posX);
        posY = ((abs(posY - height/2) < baseSize/2 + clearance + size/2) ? (posY + clearance * 3 + baseSize) : posY);
        
        update();
    }
    
    void update() {
        if (count > 0) {
            ellipse(posX, posY, size, size);
            fill(0, 0, 0);
            text(count, posX, posY);
        } else {
            replaceTime--;
        }
    }
}
