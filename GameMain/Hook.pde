class Hook {
  float y = 90;
  PVector position;

  Hook() {
  }
  void display() {
    position = new PVector (boat.position.x, y);
    noFill();
    stroke(255);
    strokeWeight(2);
    //hook
    // the hook takes the boat's x position
    arc(position.x - 5, y, 10, 10, 0, HALF_PI);
    arc(position.x - 5, y, 10, 10, HALF_PI, PI);
    line(position.x - 10, y, position.x - 10, y - 3);
    line(position.x - 10, y - 3, position.x - 8, y);
    line(position.x, y, position.x, y - 10);
    //hook line
    stroke(150);
    line(position.x, y - 10, position.x, 80);
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
