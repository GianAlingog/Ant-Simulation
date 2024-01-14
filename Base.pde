class Base {

    // This is the Ant Hill
    // There should be only one Ant Hill, and it should be possible for it to be placed anywhere on the screen.
    
    // Initialize Variables
    int size, posX, posY, count = 0;
    
    // Constructor
    Base(int size) {
        this.size = size;
        this.posX = width/2;
        this.posY = height/2;
        
        update();
    }
    
    Base(int size, int x, int y) {
        this.size = size;
        this.posX = x;
        this.posY = y;
        
        update();
    }
    
    void update() {
        rect(posX, posY, size, size);
        fill(0, 0, 0);
        text(count, posX, posY);
    }
}
