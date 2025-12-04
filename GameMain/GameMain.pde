
ArrayList<Fish> fish = new ArrayList<Fish>();

Boat boat;
Hook hook;

boolean spawnedInitial = false;

int sideSelect;
float points = 0;

boolean start = true;
boolean win = false;
boolean loss = false;

boolean hookActive;

String outcome = "";


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
  fishOneRule();

  seaWavesFront();

  gameMenu();
  
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

void fishOneRule() {
  for (int i = 0; i < fish.size(); i++) {
    if (fish.get(i).hooked) {
      hookActive = true;
    }
  }
}

void fishPoints() {
  noFill();
  strokeWeight(2);
  stroke(150);
  rect(310, 10, 390, 30);
  noStroke();
  fill(50, 200, 50);
  rect(310, 10, 310 + points, 30);
  points = constrain(points, 0, 80);

  for (int i = fish.size() - 1; i >= 0; i--) {
    if (fish.get(i).pointsPending) {
      fish.get(i).pointsPending = false;
      points += fish.get(i).size * 10;
      fish.remove(i);
    }
  }
  if (points > 80) {
    win = true;
    start = true;
  }
}


void gameMenu() {
  if (start) {
    fill(50, 50, 100);
    rect(0, 0, 400, 400);
    fill(150, 150, 255);
    rect(140, 300, 260, 340);
    textSize(30);
    fill(255, 255, 255);
    text("PLAY", 170, 330);
    textSize(60);
    text(outcome, 90, 100);
  }
  if (win) {
    outcome = "YOU WIN!";
  }
}

void mouseClicked() {
  if (mouseX > 140 && mouseX < 300 && mouseY > 260 && mouseY < 340 && start) {
    start = false;
    win = false;
    loss = false;
    points = 0;
  }
}
