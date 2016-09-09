class Particle {
  PVector pos = new PVector(random(width),random(height));
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  float maxSpeed = 1;

  PVector prevPos = pos.copy();

  public void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  public void follow(PVector[] vectors) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = (x-1) + ((y-1) * cols);
    // Sometimes the index ends up out of range, typically by a value under 100.
    // I have no idea why this happens, but I have to do some stupid if-checking
    // to make sure the sketch doesn't crash when it inevitably happens.
    //
    index = index - 1;
    if(index > vectors.length || index < 0) {
      //println("Out of bounds!");
      //println(index);
      //println(vectors.length);
      index = vectors.length - 1;
    }
    PVector force = vectors[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  public void show() {
    stroke(255, 50);
    strokeWeight(2);
    point(pos.x, pos.y);
  }

  public void updatePrev() {
    prevPos.x = pos.x;
    prevPos.y = pos.y;
  }

  public void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePrev();
    }
    if (pos.x < 0) {
      pos.x = width;
      updatePrev();
    }

    if (pos.y > height) {
      pos.y = 0;
      updatePrev();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePrev();
    }
  }
}
