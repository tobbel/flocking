part of flocking;

class Flock {
  List<Boid> boids;
  Flock() {
    boids = new List<Boid>();
    Vector2 startPosition = new Vector2(50.0, 50.0);
    for (int i = 0; i < 50; i++) {
      boids.add(new Boid(startPosition, boids));
    }
  }
  
  void update(double dt) {
    boids.forEach((b) => b.update(dt));
  }
}
