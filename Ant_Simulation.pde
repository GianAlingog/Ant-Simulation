int numAnts = 1000;
int numBases = 1;
int numFoods = 1;

int baseSize = 100;
int foodSize = 150;

int fRate = 60;


Ant[] ants = new Ant[numAnts];
Base[] bases = new Base[numBases];
Food[] foods = new Food[numFoods];

void setup() {
     fullScreen();
    //size(300, 300);
    smooth();
    frameRate(fRate);
    ellipseMode(CENTER);
    
    fill(0, 255, 0);
    for (int i=0; i<numFoods; i++) {
        foods[i] = new Food(foodSize);
    }
    
    fill(255, 255, 0);
    for (int i=0; i<numBases; i++) {
        bases[i] = new Base(baseSize);
    }
    
    for (int i=0; i<numAnts; i++) {
        ants[i] = new Ant(width, height);
    }
}

void draw() {
    background(255);
    
    fill(0, 255, 0);
    for (int i=0; i<numFoods; i++) {
        foods[i].update();
    }
    
    fill(255, 255, 0);
    for (int i=0; i<numBases; i++) {
        bases[i].update();
    }
    
    for (int i=0; i<numAnts; i++) {
        for (int j=0; j<numFoods; j++) {
            ants[i].interactFood(foods[j]);
        }
        
        for (int j=0; j<numBases; j++) {
            ants[i].interactBase(bases[j]);
        }
        
        ants[i].draw();
        ants[i].update();
    }
}
