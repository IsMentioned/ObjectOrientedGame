class Fish {
  float x;
  float y;
  float size;

  float timeStartIdle;
  float timeStartActive;
  float guage;

  float bodyR = random(50, 200);
  float bodyG = random(20, 150);
  float bodyB = random(0, 50);

  float accentR = random(200, 250);
  float accentG = random(70, 250);
  float accentB = random(50, 100);


  float fin = -4;
  boolean facingRight = true;

  boolean idlePending = true;
  boolean activePending = false;
  boolean active = false;

  boolean ghost = false;
  boolean ghostPending = false;

  PVector position;
  PVector velocity;

  Fish(float tempX, float tempY, float tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    position = new PVector (x, y);
    velocity = new PVector (0, 0);
  }
  void display() {


    if (velocity.x < 0 || !facingRight) {
      facingRight = false;
      fill(accentR, accentG, accentB);
      triangle(position.x + 6 * size, position.y, position.x + 11 * size, position.y - 6 * size, position.x + 11 * size, position.y + 6 * size);
      triangle(position.x -1 * size, position.y - 5 * size, position.x + 3 * size, position.y - 5 * size, position.x + 3 * size, position.y - 9 * size);
      triangle(position.x -1 * size, position.y + 5 * size, position.x + 3 * size, position.y + 5 * size, position.x + 3 * size, position.y + 8 * size);
      fill(bodyR, bodyG, bodyB);
      beginShape();
      vertex(position.x - 5 * size, position.y);
      vertex(position.x - 7 * size, position.y - 2 * size);
      vertex(position.x - 3 * size, position.y - 5 * size);
      vertex(position.x + 3 * size, position.y - 5 * size);
      vertex(position.x + 7 * size, position.y - 3 * size);
      vertex(position.x + 9 * size, position.y);
      vertex(position.x + 7 * size, position.y + 3 * size);
      vertex(position.x + 3 * size, position.y + 5 * size);
      vertex(position.x - 3 * size, position.y + 5 * size);
      vertex(position.x - 7 * size, position.y + 2 * size);
      endShape();
      fill(accentR, accentG, accentB);
      triangle(position.x - 2 * size, position.y, position.x + 2 * size, position.y, position.x + 3 * size, position.y + fin * size);
    }
    if (velocity.x > 0 || facingRight) {
      facingRight = true;
      fill(accentR, accentG, accentB);
      triangle(position.x - 6 * size, position.y, position.x - 11 * size, position.y + 6 * size, position.x - 11 * size, position.y - 6 * size);
      triangle(position.x + 1 * size, position.y + 5 * size, position.x - 3 * size, position.y + 5 * size, position.x - 3 * size, position.y + 9 * size);
      triangle(position.x + 1 * size, position.y - 5 * size, position.x - 3 * size, position.y - 5 * size, position.x - 3 * size, position.y - 8 * size);
      fill(bodyR, bodyG, bodyB);
      beginShape();
      vertex(position.x + 5 * size, position.y);
      vertex(position.x + 7 * size, position.y + 2 * size);
      vertex(position.x + 3 * size, position.y + 5 * size);
      vertex(position.x - 3 * size, position.y + 5 * size);
      vertex(position.x - 7 * size, position.y + 3 * size);
      vertex(position.x - 9 * size, position.y);
      vertex(position.x - 7 * size, position.y - 3 * size);
      vertex(position.x - 3 * size, position.y - 5 * size);
      vertex(position.x + 3 * size, position.y - 5 * size);
      vertex(position.x + 7 * size, position.y - 2 * size);
      endShape();
      fill(accentR, accentG, accentB);
      triangle(position.x + 2 * size, position.y, position.x - 2 * size, position.y, position.x - 3 * size, position.y + fin * size);
    }
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
    }
    if (activePending) {
      activePending = false;
      active = true;
      guage = random(1, 3);
      timeStartActive = millis();
      //direction of the velocity vector is set to random
      velocity.x = random(-10, 10);
      velocity.y = random(0, 0);
      //magnitude of the velocity vector is set to 5
      velocity.setMag(1);
    }
    if (millis() - timeStartActive > guage * 1000 && active && !ghost) {
      idlePending = true;
      active = false;
    }
    position.add(velocity);
    position.y = constrain(position.y, 120, 380);
  }

  void wiggle() {
    if (velocity.x < -0.1 || velocity.x > 0.1) {
      velocity.y += sin(frameCount * 0.3) * 0.1;
      if ((sin(frameCount * 0.3) * 0.1) > 0) {
        fin = - 4;
      }
      if ((sin(frameCount * 0.3) * 0.1) <= 0) {
        fin = 4;
      }
    }
  }

  void ghost() {
    if (ghostPending && position.x < 200) {
      ghostPending = false;
      ghost = true;
      idlePending = false;
      velocity.x = 10;
      velocity.y = random(-3, 3);
      velocity.setMag(1);
    }
    if (ghostPending && position.x > 300) {
      ghostPending = false;
      ghost = true;
      velocity.x = -10;
      velocity.y = random(-3, 3);
      velocity.setMag(1);
    }
    if (ghost && position.x > 100 && position.x < 300) {
      ghost = false;
    }
  }
}
