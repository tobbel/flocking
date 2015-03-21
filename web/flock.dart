part of flocking;

class Flock {
  List<Boid> boids;
  static const int NUM_BOIDS = 1;
  final Vector2 worldSize;
  
  Flock(this.worldSize) {
    boids = new List<Boid>();
    Vector2 startPosition = new Vector2(100.0, 100.0);
    for (int i = 0; i < NUM_BOIDS; i++) {
      boids.add(new Boid(startPosition, i));
    }
  }
  
  // Boids have three rules for movement:
  // 1. Separation: Steer to avoid crowding local flockmates.
  // 2. Alignment: Steer towards the average heading of local flockmates.
  // 3. Cohesion: Steer to move toward the average position of local flockmates.
  double logTimer = 1.0;
  void update(double dt) {
    boids.forEach((b) {
      final List<Boid> neighbors = b.getNeighbors(boids);
      
      Vector2 alignVector = b.align(neighbors);
      Vector2 separationVector = b.separate(neighbors);
      Vector2 cohesionVector = b.cohese(neighbors);
      b.velocity += (alignVector * 0.1 + separationVector * 0.1 + cohesionVector * 0.1);
      
    });
    
    boids.forEach((b) => b.update(dt));
    
    wrapEdges();
  }
  
  void wrapEdges() {
    // Wrap all boids around edges
    for (Boid b in boids) {
      if (b.position.x < 0) b.position.x = worldSize.x + b.position.x;
      if (b.position.y < 0) b.position.y = worldSize.y + b.position.y;
      if (b.position.x > worldSize.x) b.position.x = worldSize.x - b.position.x;
      if (b.position.y > worldSize.y) b.position.y = worldSize.y - b.position.y;
    }
  }
  
  void addBoid(Vector2 position) {
    boids.add(new Boid(position, boids.length));
  }
}
