class Food {

    // This is the Food
    // For now, only one Food should be present at all times.
    // Randomly spawning, yet should not spawn within a certain radius of the Ant Hill.
    
    int size, replaceTime = 400, count = int(random(40, 61)); // 40-60
    float posX, posY;
    final int clearance = 10;
    final int baseSize = 200;
    
    Food(int size) {
        this.size = size;
        
        // Makes sure the Food doesn't spawn in too close to the Base
        posX = random(2) < 1 ? (random(0 + size/2 + clearance, width/2 - baseSize/2 - clearance)) : (random(width/2 + baseSize/2 + clearance, width - size/2 - clearance));
        posY = random(2) < 1 ? (random(0 + size/2 + clearance, height/2 - baseSize/2 - clearance)) : (random(width/2 + baseSize/2 + clearance, width - size/2 - clearance));
        
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
