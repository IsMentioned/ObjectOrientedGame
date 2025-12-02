class Fish {
  float x;
  float y;

  float timeStartIdle;
  float timeStartActive;
  float guage;

  boolean idlePending = true;
  boolean activePending = false;
  boolean active = false;

  PVector velocity;

  Fish(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    velocity = new PVector (0, 0);
  }
  void display() {
    fill(255, 255, 255);
    ellipse(x, y, 10, 10);
  }
  void movement() {
    if (idlePending) {
      idlePending = false;
      guage = random(0, 5);
      timeStartIdle = millis();
      velocity.x = 0;
      velocity.y = 0;
    }
    if (millis() - timeStartIdle >= guage * 1000 && !active) {
      activePending = true;
    }
    if (activePending) {
      activePending = false;
      active = true;
      guage = random(1, 3);
      timeStartActive = millis();
      //direction of the velocity vector is set to random
      velocity.x = random(-10, 10);
      velocity.y = random(-10, 10);
      //magnitude of the velocity vector is set to 5
      velocity.setMag(1);
    }
    if (millis() - timeStartActive > guage * 1000 && active) {
      idlePending = true;
      active = false;
    }
    x += velocity.x;
    y += velocity.y;
    
    y = constrain(y, 120, 380);
  }
}
