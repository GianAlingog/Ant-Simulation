int numAnts = 1000;

Ant[] ants = new Ant[numAnts];

void setup() {
    fullScreen();
    //size(300, 300);
    smooth();
    frameRate(60);
    ellipseMode(CENTER);
    
    for (int i=0; i<numAnts; i++) {
        ants[i] = new Ant(width, height);
    }
}

void draw() {
    background(255);
    
    for (int i=0; i<numAnts; i++) {
        ants[i].draw();
        ants[i].update(delta);
    }
}
