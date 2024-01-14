// Initialize Variables
int numAnts = 1000;

int baseSize = 200;
int foodSize = 150;

int fRate = 60;

final float chance = 0.0001;

ArrayList<Ant> ants = new ArrayList<Ant>();
Food food;
Base base;

PFont mainFont;
PFont smallFont;

// Initialization
void setup() {
    // fullScreen();
    size(900, 900);
    smooth();
    background(255);
    frameRate(fRate);
    ellipseMode(CENTER);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    
    mainFont = createFont("Poppins-Regular.ttf", 64);
    smallFont = createFont("Poppins-Regular.ttf", 12);

    fill(0, 0, 0);
    textFont(smallFont);
    text("Ants: " + Integer.toString(ants.size()), 50, 10);
    
    fill(0, 255, 0);
    food = new Food(foodSize);
    
    fill(255, 255, 0);
    base = new Base(baseSize);
    
    for (int i=0; i<numAnts; i++) {
        ants.add(new Ant(width, height));
    }
}

void draw() {
    background(255);
    fill(0, 0, 0);
    textFont(smallFont);

    // Ant Counter (top left)
    text("Ants: " + Integer.toString(ants.size()), 50, 10);
    
    // Food Spawning System (and Food Counter)
    fill(0, 255, 0);
    if (food.replaceTime > 0) {   
        textFont(mainFont);
        food.update();
    } else {
        food = new Food(foodSize);
    }
    
    // Base and Base Counter
    fill(255, 255, 0);
    textFont(mainFont);
    base.update();
    
    // Ant Interactions
    for (int i=0; i<ants.size(); i++) {
        ants.get(i).interactFood(food);
        ants.get(i).interactBase(base);
        
        ants.get(i).draw();
        ants.get(i).update();
        
        // If Ant successfully brings back food, it feeds itself and a new Ant is spawned in
        if (ants.get(i).feed == true) {
            ants.add(new Ant(width, height));
            ants.get(i).feed = false;
        }

        // Ants past their lifespan have a (very) small chance to pass away with each frame that passes
        if (ants.get(i).liveTime <= 0) {
            if (random(1) < chance) { ants.remove(i); }
        }
    }
}
