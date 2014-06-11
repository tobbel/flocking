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
  
  // Boids have three rules for movement:
  // 1. Separation: Steer to avoid crowding local flockmates.
  // 2. Alignment: Steer towards the average heading of local flockmates.
  // 3. Cohesion: Steer to move toward the average position of local flockmates.
  void update(double dt) {
    // TODO: Calculate separation, alignment, cohesion for all boids. Change velocity vector.
    // TODO: Apply velocity for all boids.
    
    boids.forEach((b) => b.update(dt));
  }
}
