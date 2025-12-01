class Hook {
  Hook() {
  }
  void display() {
    noFill();
    stroke(255);
    strokeWeight(2);
    //hook
    // the hook takes the boat's x position
    arc(boat.x - 5, 200, 10, 10, 0, HALF_PI);
    arc(boat.x - 5, 200, 10, 10, HALF_PI, PI);
    line(boat.x - 10, 200, boat.x - 10, 197);
    line(boat.x - 10, 197, boat.x - 8, 200);
    line(boat.x, 200, boat.x, 190);
    //hook line
    stroke(150);
    line(boat.x, 190, boat.x, 80);
    noStroke();
  }
}
