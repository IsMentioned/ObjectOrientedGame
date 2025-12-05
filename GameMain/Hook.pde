class Hook {
  float y = 90;
  PVector position;

// Hook constructor
  Hook() {
  }
  void display() {
    // The x-value of the position vectors takes the x-value of the boat object position vector.
    position = new PVector (boat.position.x, y);
    noFill();
    stroke(255);
    strokeWeight(2);
    //hook
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
    // If the 'w' or 's' key is pressed, the hook will move in the given direction.
    if (keyPressed) {
      if (key == 's') {
        y += 2;
      }
      if (key == 'w') {
        y -= 2;
      }
    }
    // The hook y value is contrained between 90 and 380.
    y = constrain(y, 90, 380);
  }
}
