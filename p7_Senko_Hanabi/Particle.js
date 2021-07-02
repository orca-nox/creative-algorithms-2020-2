class Rod {
  constructor(i, x, y) {
    this.index = i;
    this.phase = 0;
    this.yBuf = 0;
    this.coord = createVector(x, y);
    this.length = random(50, 100);
    this.particles = new Array(50);
    this.hue = random(rangeMin, rangeMax);
    this.scale = random(1, 5);
  }

  draw() {
    if (this.phase == 0) {
      stroke(80);
      strokeWeight(this.scale);
      this.yBuf = ((this.length - this.yBuf) / 10) + this.yBuf;
      line(this.coord.x, this.coord.y, this.coord.x, this.coord.y + this.yBuf);
      if (this.yBuf > this.length - 1) {
        this.phase = 1;
        for (let i = 0; i < this.particles.length; i++) {
          this.particles[i] = new Particle(this.coord.x, this.coord.y + this.yBuf, this.hue, this.scale);
        }
      }

    } else if (this.phase == 1) {

      stroke(50);
      strokeWeight(this.scale/2);
      line(this.coord.x, this.coord.y, this.coord.x, this.coord.y + this.length);
      stroke(80);
      strokeWeight(this.scale);
      line(this.coord.x, this.coord.y, this.coord.x, this.coord.y + this.yBuf);
      this.yBuf -= 0.1;
      for (let i = 0; i < this.particles.length; i++) {
        fill(255, 255, 0);
        this.particles[i].draw();
        this.particles[i].lcoord.y -= 0.1;
      }
      if (this.yBuf < 0) {
        this.phase = 2;
      }
    }
  }
}


class Particle {
  constructor(x, y, h, s) {
    this.lcoord = createVector(x, y);
    this.coord = createVector(x, y);
    this.vel = createVector(0, 0);
    this.offset = random(0, 50);
    this.counter = this.offset;
    this.reset(x, y);
    this.size = random(1, s*1.5);
    this.hue = h;
    this.scale = s;
  }

  reset(x, y) {
    if (this.offset < 0) {
      this.coord = createVector(x, y);
      this.q = random(0, this.scale*3);
      this.r = random(0, TWO_PI);
      this.tempX = cos(this.r) * this.q;
      this.tempY = sin(this.r) * this.q;
      this.vel = createVector(this.tempX, this.tempY);
      this.counter += 50;
    }
  }

  update() {
    this.coord.add(this.vel);
    this.vel.mult(0.9);
    this.counter--;
    this.offset--;
    this.coord.y += 1.5;
  }

  draw() {
    stroke(this.hue, 70, 90);
    strokeWeight(this.size);
    point(this.coord.x, this.coord.y);
    stroke(this.hue, 20, 100);
    strokeWeight(this.size - 1);
    point(this.coord.x, this.coord.y);

    this.update();
    if (this.counter < 0) this.reset(this.lcoord.x, this.lcoord.y, this.scale * 10);
  }
}