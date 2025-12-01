
Boat boat;
Hook hook;

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
  fill(0, 80, 110);
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
  fill(43, 159, 207, 125);

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
