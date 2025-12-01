class Boat {
  float x = 200;
  float y = 80;
  float velocity = 0;
  float accel = 0;

  Boat() {
    fill(255, 255, 255);
  }
  void display() {
    noStroke();
    // boat cabin
    fill(100, 100, 255);
    rect(x - 80, y - 30, x - 40, y);
    // boat windows
    fill(255, 255, 178);
    rect(x - 60, y - 22, x - 45, y -10);
    rect(x - 72, y - 22, x - 65, y -10);
    // boat hull
    fill(200, 200, 200);
    arc(x - 20, y, 40, 60, 0, HALF_PI);
    arc(x - 80, y, 40, 60, HALF_PI, PI );
    rect(x - 81, y, x - 19, y + 30);
    // boat roof
    fill(200, 200, 200);
    rect(x - 85, y - 35, x - 35, y - 30);
    // boat light
    fill(150, 150, 150);
    quad(x - 80, y - 45, x - 80, y - 35, x - 70, y - 35, x - 70, y - 42);
    fill(255, 255, 178);
    ellipse(x - 80, y - 40, 4, 10);
    //hook box
    fill(100, 100, 100);
    rectMode(CENTER);
    rect(x, y, 10, 10);
    rectMode(CORNERS);
  }

  void movement() {
    // If the 'a' or 'd' key is pressed, the boat will accelerate in the given direction.
    // Otherwise, the velocity will decrease until the boat stops.
    x += velocity;
    velocity += accel;
    if (keyPressed) {
      if (key == 'a') {
        accel = -0.01;
      }
      if (key == 'd') {
        accel = 0.01;
      }
    } else if (velocity > 0) {
      velocity -= 0.01;
      accel = 0;
    } else if (velocity < 0) {
      velocity += 0.01;
      accel = 0;
    }
  }
  void border() {
    // if the boat hits either side of the screen, it will stop and bounce back slightly.
    if (x < 100) {
      x = 101;
      velocity *= -0.1;
      accel = 0;
    }
        if (x > 400) {
      x = 399;
      velocity *= -0.1;
      accel = 0;
    }
  }
}
