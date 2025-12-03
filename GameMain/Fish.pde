class Fish {
  float x;
  float y;

  float timeStartIdle;
  float timeStartActive;
  float guage;

  boolean idlePending = true;
  boolean activePending = false;
  boolean active = false;

  boolean ghost = false;
  boolean ghostPending = false;

  PVector position;
  PVector velocity;

  Fish(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    position = new PVector (x, y);
    velocity = new PVector (0, 0);
  }
  void display() {
    fill(255, 255, 255);
    ellipse(position.x, position.y, 10, 10);
  }
  void movement() {
    if (idlePending) {
      idlePending = false;
      guage = random(1, 4);
      timeStartIdle = millis();
      velocity.x = 0;
      velocity.y = 0;
    }
    if (millis() - timeStartIdle > guage * 1000 && !active && !ghost) {
      activePending = true;
      println("activePending triggered!");
    }
    if (activePending) {
      activePending = false;
      active = true;
      guage = random(1, 3);
      timeStartActive = millis();
      //direction of the velocity vector is set to random
      velocity.x = random(-10, 10);
      velocity.y = random(-3, 3);
      //magnitude of the velocity vector is set to 5
      velocity.setMag(1);
    }
    if (millis() - timeStartActive > guage * 1000 && active && !ghost) {
      idlePending = true;
      active = false;
      println("idlePending triggered!");
      
    }
    position.add(velocity);
    position.y = constrain(position.y, 120, 380);
  }

  void ghost() {
    if (ghostPending && position.x < 200) {
      ghostPending = false;
      ghost = true;
      println("less than 100!");
      idlePending = false;
      velocity.x = 10;
      velocity.y = random(-3, 3);
      velocity.setMag(1);
    }
    if (ghostPending && position.x > 300) {
      ghostPending = false;
      ghost = true;
      println("greater than 300!");
      velocity.x = -10;
      velocity.y = random(-3, 3);
      velocity.setMag(1);
    }
    if (ghost && position.x > 100 && position.x < 300) {
      ghost = false;
    }
  }
}
