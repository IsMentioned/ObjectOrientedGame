
ArrayList<Fish> fish = new ArrayList<Fish>();

Boat boat;
Hook hook;

boolean spawnedInitial = false;

int sideSelect;

void setup() {
  size(400, 400);
  background(0);
  rectMode(CORNERS);

  boat = new Boat();
  hook = new Hook();
}

void draw() {
  background(188, 235, 255);
  seaWavesBehind();
  seaFloor();

  boat.display();
  boat.movement();
  boat.border();

  hook.display();
  hook.movement();

  initialFishSpawn();
  fishDisplay();
  fishMovement();
  fishSub();
  fishPoints();

  seaWavesFront();
}

void seaFloor () {
  fill(235, 231, 197);
  // A custom shape is used to make the sea floor, combining a wave and random noise.
  beginShape();
  //bottom left corner
  vertex(0, height);
  //wave of shape
  for (float x = 0; x < width + 5; x += 10) {
    float y = (380 + noise(x) * 5) + sin(x * 0.02) * 2;
    vertex(x, y);
  }
  // bottom right corner
  vertex(width, height);
  endShape();
}

void seaWavesBehind() {
  fill(100, 150, 200);
  // Each of the 80 vertices that make up the wave portion update every frame.
  beginShape();
  //bottom left corner
  vertex(0, height);
  //wave of shape
  for (float x = 0; x < width + 5; x += 5) {
    float y = 100 + sin(x * 0.02 + frameCount * 0.02) * 5;
    vertex(x, y);
  }
  // bottom right corner
  vertex(width, height);
  endShape();
}
void seaWavesFront() {
  fill(43, 159, 207, 80);

  // Each of the 80 vertices that make up the wave portion update every frame.
  beginShape();
  //bottom left corner
  vertex(0, height);
  //wave of shape
  for (float x = 0; x < width + 5; x += 5) {
    float y = 100 + sin(x * 0.02 + frameCount * 0.02) * 5;
    vertex(x, y);
  }
  // bottom right corner
  vertex(width, height);
  endShape();
}

void initialFishSpawn() {
  if (!spawnedInitial) {
    for (int i = 0; i < 5; i++) {
      fish.add(new Fish(random(50, 350), random(120, 380), random(0.5, 2)));
    }
    spawnedInitial = true;
  }
}

void fishDisplay() {
  for (int i = 0; i < fish.size(); i++) {
    fish.get(i).display();
  }
}

void fishMovement() {
  for (int i = 0; i < fish.size(); i++) {
    fish.get(i).movement();
    fish.get(i).ghost();
    fish.get(i).wiggle();
    fish.get(i).lure();
  }
}

void fishSub() {
  // the for loop is set backwards to prevent a number from being skipped if a number is removed.
  for (int i = fish.size() - 1; i >= 0; i--) {
    if ((fish.get(i).position.x < - 10 || fish.get(i).position.x > 410) && !fish.get(i).ghost) {
      fish.remove(i);
    }
  }
  if (fish.size() < 5) {
    sideSelect = int(random(0, 2));
    if (sideSelect == 0) {
      fish.add(new Fish(- 50, random(120, 380), random(0.5, 2)));
      fish.get(fish.size() - 1).ghostPending = true;
      fish.get(fish.size() - 1).idlePending = false;
    }
    if (sideSelect == 1) {
      fish.add(new Fish(450, random(120, 380), random(0.5, 2)));
      fish.get(fish.size() - 1).ghostPending = true;
      fish.get(fish.size() - 1).idlePending = false;
    }
  }
}

void fishPoints() {
}
