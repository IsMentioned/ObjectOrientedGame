
Boat boat;

void setup() {
  size(400, 400);
  background(0);
  rectMode(CORNERS);

  boat = new Boat();
}

void draw() {
  background(188, 235, 255);
  boat.display();
  seaWaves();
}

void seaWaves() {
  fill(0, 80, 110);
  // A custom shape is used the simulation of a wave. 
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
