class Boat {
  Boat() {
    fill(255, 255, 255);
  }
  void display() {
    noStroke();
    // boat cabin
    fill(100, 100, 255);
    rect(200 - 80, 80 - 30, 200 - 40, 80);
    // boat windows
    fill(255, 255, 178);
    rect(200 - 60, 80 - 22, 200 - 45, 80 -10);
    rect(200 - 72, 80 - 22, 200 - 65, 80 -10);
    // boat hull
    fill(200, 200, 200);
    arc(200 - 20, 80, 40, 60, 0, HALF_PI);
    arc(200 - 80, 80, 40, 60, HALF_PI, PI );
    rect(200 - 80, 80, 200 - 20, 80 + 30);
    // boat roof
    fill(200, 200, 200);
    rect(200 - 85, 80 - 35, 200 - 35, 80 - 30);
    // boat light
    fill(150, 150, 150);
    quad(200 - 80, 80 - 45, 200 - 80, 80 - 35, 200 - 70, 80 - 35, 200 - 70, 80 - 42);
    fill(255, 255, 178);
    ellipse(120, 40, 4, 10);
    //hook box
    fill(100, 100, 100);
    rectMode(CENTER);
    rect(200, 80, 10, 10);
    rectMode(CORNERS);
  }
  void movement() {
    
}
