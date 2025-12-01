class Hook {
  float y = 90;

  Hook() {
  }
  void display() {
    noFill();
    stroke(255);
    strokeWeight(2);
    //hook
    // the hook takes the boat's x position
    arc(boat.x - 5, y, 10, 10, 0, HALF_PI);
    arc(boat.x - 5, y, 10, 10, HALF_PI, PI);
    line(boat.x - 10, y, boat.x - 10, y - 3);
    line(boat.x - 10, y - 3, boat.x - 8, y);
    line(boat.x, y, boat.x, y - 10);
    //hook line
    stroke(150);
    line(boat.x, y - 10, boat.x, 80);
    noStroke();
  }
  void movement() {
    // If the 'a' or 'd' key is pressed, the boat will accelerate in the given direction.
    // Otherwise, the velocity will decrease until the boat stops.
    if (keyPressed) {
      if (key == 's') {
        y += 2;
      }
      if (key == 'w') {
        y -= 2;
      }
    }
    y = constrain(y, 90, 380);
  }
}
