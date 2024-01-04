class Base {

    // This is the Ant Hill
    // There should be only one Ant Hill, and it should be possible for it to be placed anywhere on the screen.
    
    int size, posX, posY;
  
    Base(int size) {
        this.size = size;
        this.posX = width/2;
        this.posY = height/2;
        
        ellipse(posX, posY, size, size);
    }
    
    Base(int size, int x, int y) {
        this.size = size;
        this.posX = x;
        this.posY = y;
        
        ellipse(posX, posY, size, size);
    }
    
    void update() {
        ellipse(posX, posY, size, size);
    }
}
