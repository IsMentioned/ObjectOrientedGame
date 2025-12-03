class Fish {
  float x;
  float y;

  float timeStartIdle;
  float timeStartActive;
  float guage;
  
  boolean facingRight = true;

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
    
    
    if (velocity.x < 0 || !facingRight){
      facingRight = false;
    fill(150, 20, 30);
    triangle(position.x + 6, position.y, position.x + 11, position.y - 6, position.x + 11, position.y + 6);
    triangle(position.x -1, position.y - 5, position.x + 3, position.y - 5, position.x + 3, position.y - 9);
    triangle(position.x -1, position.y + 5, position.x + 3, position.y + 5, position.x + 3, position.y + 8);
    fill(255, 255, 255);
    beginShape();
    vertex(position.x - 5, position.y);
    vertex(position.x - 7, position.y - 2);
    vertex(position.x - 3, position.y - 5);
    vertex(position.x + 3, position.y - 5);
    vertex(position.x + 9, position.y);
    vertex(position.x + 3, position.y + 5);
    vertex(position.x - 3, position.y + 5);
    vertex(position.x - 7, position.y + 2);
    endShape();
    fill(150, 20, 30);
    triangle(position.x - 2, position.y, position.x + 2, position.y, position.x + 3, position.y + 4);
    }
    if (velocity.x > 0 || facingRight){
      facingRight = true;
    fill(150, 20, 30);
    triangle(position.x - 6, position.y, position.x - 11, position.y + 6, position.x - 11, position.y - 6);
    triangle(position.x + 1, position.y + 5, position.x - 3, position.y + 5, position.x - 3, position.y + 9);
    triangle(position.x + 1, position.y - 5, position.x - 3, position.y - 5, position.x - 3, position.y - 8);
    fill(255, 255, 255);
    beginShape();
    vertex(position.x + 5, position.y);
    vertex(position.x + 7, position.y + 2);
    vertex(position.x + 3, position.y + 5);
    vertex(position.x - 3, position.y + 5);
    vertex(position.x - 9, position.y);
    vertex(position.x - 3, position.y - 5);
    vertex(position.x + 3, position.y - 5);
    vertex(position.x + 7, position.y - 2);
    endShape();
    fill(150, 20, 30);
    triangle(position.x + 2, position.y, position.x - 2, position.y, position.x - 3, position.y - 4);
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
