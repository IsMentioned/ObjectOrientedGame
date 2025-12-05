class Boat {
  PVector position;
  PVector velocity;
  PVector accel;

// Boat Constructor
  Boat() {
    fill(255, 255, 255);
    position = new PVector (200, 80);
    velocity = new PVector (0, 0);
    accel = new PVector (0, 0);
  }
  void display() {
    noStroke();
    // boat cabin
    fill(100, 100, 255);
    rect(position.x - 80, position.y - 30, position.x - 40, position.y);
    // boat windows
    fill(255, 255, 178);
    rect(position.x - 60, position.y - 22, position.x - 45, position.y -10);
    rect(position.x - 72, position.y - 22, position.x - 65, position.y -10);
    // boat hull
    fill(200, 200, 200);
    arc(position.x - 20, position.y, 40, 60, 0, HALF_PI);
    arc(position.x - 80, position.y, 40, 60, HALF_PI, PI );
    rect(position.x - 81, position.y, position.x - 19, position.y + 30);
    // boat roof
    fill(200, 200, 200);
    rect(position.x - 85, position.y - 35, position.x - 35, position.y - 30);
    // boat light
    fill(150, 150, 150);
    quad(position.x - 80, position.y - 45, position.x - 80, position.y - 35, position.x - 70, position.y - 35, position.x - 70, position.y - 42);
    fill(255, 255, 178);
    ellipse(position.x - 80, position.y - 40, 4, 10);
    //hook box
    fill(100, 100, 100);
    rectMode(CENTER);
    rect(position.x, position.y, 10, 10);
    rectMode(CORNERS);
  }

  void movement() {
    // If the 'a' or 'd' key is pressed, the boat will accelerate in the given direction.
    // Otherwise, the velocity will decrease until the boat stops.
    position.add(velocity);
    velocity.add(accel);
    if (keyPressed) {
      if (key == 'a') {
        accel.x = -0.01;
      }
      if (key == 'd') {
        accel.x = 0.01;
      }
    } else if (velocity.x > 0) {
      velocity.x -= 0.005;
      accel.x = 0;
    } else if (velocity.x < 0) {
      velocity.x += 0.005;
      accel.x = 0;
    }
  }
  void border() {
    // if the boat hits either side of the screen, it will stop and bounce back slightly.
    //Left side
    if (position.x < 100) {
      points -= 20;
      fill(255, 50, 50);
      rect(0, 0, 400, 400);
      position.x = 101;
      velocity.x *= -0.1;
      accel.x = 0;
    }
    //Right side
    if (position.x > 400) {
      points -= 20;
      fill(255, 50, 50);
      rect(0, 0, 400, 400);
      position.x = 399;
      velocity.x *= -0.1;
      accel.x = 0;
    }
  }
}
