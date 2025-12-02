class Fish {
  float x;
  float y;
  Fish(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }
  void display() {
    fill(255, 255, 255);
    ellipse(x, y, 10, 10);
  }
}
