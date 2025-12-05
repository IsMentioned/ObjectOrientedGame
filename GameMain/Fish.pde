class Fish {
  float x;
  float y;
  float size;

  float timeStartIdle;
  float timeStartActive;
  float guage;

  // fish body colours
  float bodyR = random(50, 200);
  float bodyG = random(20, 150);
  float bodyB = random(0, 50);

  // fish accent colours
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
  PVector lure;

  float timeStartLure;
  boolean timerActive;
  boolean lured = false;

  boolean hooked = false;
  boolean caught = false;

  boolean pointsPending = false;

  float opacity = 255;

  // Fish constructor
  // initial spawn location and size of the fish.
  Fish(float tempX, float tempY, float tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;

    position = new PVector (x, y);
    velocity = new PVector (0, 0);
    lure = new PVector (0, 0);
  }
  void display() {
    // The fish will face right or left, depending on the value of the horizontal component of the velocity vector.
    //If the horizontal velocity is negative, or the fish is currently facing left, or is currently hooked, then the fish will face left.
    if (velocity.x < 0 || !facingRight || hooked) {
      facingRight = false;
      // fish fins
      fill(accentR, accentG, accentB, opacity);
      triangle(position.x + 6 * size, position.y, position.x + 11 * size, position.y - 6 * size, position.x + 11 * size, position.y + 6 * size);
      triangle(position.x -1 * size, position.y - 5 * size, position.x + 3 * size, position.y - 5 * size, position.x + 3 * size, position.y - 9 * size);
      triangle(position.x -1 * size, position.y + 5 * size, position.x + 3 * size, position.y + 5 * size, position.x + 3 * size, position.y + 8 * size);
      fill(bodyR, bodyG, bodyB, opacity);
      //fish body
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
      // fish fin
      fill(accentR, accentG, accentB, opacity);
      triangle(position.x - 2 * size, position.y, position.x + 2 * size, position.y, position.x + 3 * size, position.y + fin * size);
    }
    // If the horizontal veloicty is positve, or the fish currently facing right, and is not hooked, then the fish will face right.
    if ((velocity.x > 0 || facingRight) && !hooked) {
      facingRight = true;
      //fish fins
      fill(accentR, accentG, accentB, opacity);
      triangle(position.x - 6 * size, position.y, position.x - 11 * size, position.y + 6 * size, position.x - 11 * size, position.y - 6 * size);
      triangle(position.x + 1 * size, position.y + 5 * size, position.x - 3 * size, position.y + 5 * size, position.x - 3 * size, position.y + 9 * size);
      triangle(position.x + 1 * size, position.y - 5 * size, position.x - 3 * size, position.y - 5 * size, position.x - 3 * size, position.y - 8 * size);
      fill(bodyR, bodyG, bodyB, opacity);
      //fish body
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
      //fish fin
      fill(accentR, accentG, accentB, opacity);
      triangle(position.x + 2 * size, position.y, position.x - 2 * size, position.y, position.x - 3 * size, position.y + fin * size);
    }
  }
  void movement() {
    //Idle pending triggers a timer once, the amount depending on the randomly generated value of the guage variable.
    if (idlePending) {
      idlePending = false;
      guage = random(1, 4);
      timeStartIdle = millis();
      velocity.x = 0;
      velocity.y = 0;
    }
    // Once the given number of seconds has passed, the active mode will be called.
    // The event is only triggered if active mode and ghost mode are currently not set.
    if (millis() - timeStartIdle > guage * 1000 && !active && !ghost) {
      activePending = true;
    }
    // Active pending triggers a timer once, the amount depending on the randomly generated value of the guage variable.
    if (activePending) {
      activePending = false;
      active = true;
      guage = random(1, 3);
      timeStartActive = millis();
      //Horizontal direction of the velocity vector is set to random.
      velocity.x = random(-10, 10);
      velocity.y = 0;
      // Magnitude of the velocity vector is set to 1.
      velocity.setMag(1);
    }
    // Once the given number of seconds has passed, the idle mode will be called.
    // The event is only triggered if active mode is set and ghost mode is not active.
    if (millis() - timeStartActive > guage * 1000 && active && !ghost) {
      idlePending = true;
      active = false;
    }
    // The velocity vector is added to the current position of the fish.
    position.add(velocity);
    // If the fish is currently not hooked, the fish is constrained to the water.
    if (!hooked) {
      position.y = constrain(position.y, 120, 380);
    }
  }

  void wiggle() {
    // A wiggle effect is created using a sin function.
    //The fin direction changes based on the value of sin().
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
    // Ghost mode is initialized based on the call from GameMain.
    //The idle/active cycle is disabled when ghost mode is active.

    // While the fish's horizontal position is less than 100, the fish will move right.
    if (ghostPending && position.x < 100) {
      ghostPending = false;
      ghost = true;
      idlePending = false;
      velocity.x = 10;
      velocity.y = random(-3, 3);
      velocity.setMag(1);
    }
    // While the fish's horizontal position is greater than 300, the fish will move left.
    if (ghostPending && position.x > 300) {
      ghostPending = false;
      ghost = true;
      velocity.x = -10;
      velocity.y = random(-3, 3);
      velocity.setMag(1);
    }
    // If the fish horizontal position is between 100 and 300, the fish will exit ghost mode.
    if (ghost && position.x > 100 && position.x < 300) {
      ghost = false;
    }
  }

  void lure() {
    // If the distance between the hook and the fish is less than 30, then a timer will start.
    if (dist(position.x, position.y, hook.position.x, hook.position.y) < 30) {
      if (!timerActive) {
        timerActive = true;
        timeStartLure = millis();
      }
      fill(255, 255, 255);
      // A white dot will appear above the fish.
      // The dot will move slightly left or right depending on the fish direction to ensure the dot is centered.
      if (facingRight && !lured && !hooked) {
        ellipse(position.x - 1 * size, position.y - 10 * size, 5, 5);
      } else if (!hooked) {
        ellipse(position.x + 1 * size, position.y - 10 * size, 5, 5);
      }
      // If the fish is within 30 units of the hook for more than 1 second, the fish will become lured.
      if (millis() - timeStartLure > 1000 && !hooked) {
        lured = true;
        velocity = PVector.sub(hook.position, position);
        velocity.setMag(1);
        // A green dot appears above the fish.
        fill(0, 255, 0);
        ellipse(position.x + 1 * size, position.y - 10 * size, 5, 5);
        // If the distance between the hook and the fish is less than 5 while lured, the fish will become hooked.
        if (dist(position.x, position.y, hook.position.x, hook.position.y) < 5) {
          hooked = true;
          // The fish position is set to the hook object's position.
          position = hook.position;
        }
      }
    } else {
      // Variables reset if the fish moves 30 or more units away from the hook.
      timerActive = false;
      lured = false;
      hooked = false;
    }
    //The loop works only if the fish is not already caught, preventing an infintie loop. 
    if (hooked && !caught) {
      position = hook.position;
      // If the fish position is less than 91, the fish is caught.
      if (position.y < 91) {
        caught = true;
      }
    }
    //If the fish is hooked and caught, GameMain is notified to add points and remove the fish from the array list.
    if (hooked && caught) {
      // Opacity rapidly decreases.
      opacity -= 10;
      if (opacity > 5) {
        pointsPending = true;
      }
    }
  }
}
