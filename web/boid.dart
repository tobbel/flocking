part of flocking;

class Boid {
  // TODO: Might just check neighbors on the fly

  List<Boid> boids;
  Vector2 position;
  Vector2 velocity;
  //Vector2 angle;
  double angle;
  // Arbitrary for now
  double neighborhoodDistance = 100.0;
  double neighborhoodAngle = Math.PI / 3.0; // 60 degrees in each direction backwards from angle.
  Boid(this.position, this.boids) {
    angle = Flocking.rand.nextDouble() * Math.PI * 2.0;
    velocity = new Vector2((Flocking.rand.nextDouble() - 0.5) * 10.0, (Flocking.rand.nextDouble() - 0.5) * 10.0);
  }
  
  // Boids have three rules for movement:
  // 1. Separation: Steer to avoid crowding local flockmates.
  // 2. Alignment: Steer towards the average heading of local flockmates.
  // 3. Cohesion: Steer to move toward the average position of local flockmates.
  void update(double dt) {
    // Find neighbors by distance
    // Calculate 
    position += velocity * dt;
    print('updating boid, now at position $position');
  }
}
