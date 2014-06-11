part of flocking;

class Boid {
  // TODO: Might just check neighbors on the fly

  List<Boid> boids;
  Vector2 position;
  Vector2 velocity;
  double direction;
  // Arbitrary for now
  double neighborhoodDistance = 100.0;
  double neighborhoodAngle = Math.PI / 3.0; // 60 degrees in each direction backwards from angle.
  Boid(this.position, this.boids) {
    direction = Flocking.rand.nextDouble() * Math.PI * 2.0;
    velocity = new Vector2(Math.cos(direction), Math.sin(direction));
  }
  
  void update(double dt) {
    position += velocity * dt;
  }
}
