part of flocking;

class Flock {
  List<Boid> boids;
  static const int NUM_BOIDS = 50;
  Vector2 worldSize;
  
  Flock(this.worldSize) {
    boids = new List<Boid>();
    for (int i = 0; i < NUM_BOIDS; i++) {
      Vector2 startPosition = new Vector2(Flocking.rand.nextDouble() * worldSize.x, Flocking.rand.nextDouble() * worldSize.y);
      boids.add(new Boid(startPosition, i));
    }
  }
  
  // Boids have three rules for movement:
  // 1. Separation: Steer to avoid crowding local flockmates.
  // 2. Alignment: Steer towards the average heading of local flockmates.
  // 3. Cohesion: Steer to move toward the average position of local flockmates.
  void update(double dt) {
    boids.forEach((b) {
      final List<Boid> neighbors = b.getNeighbors(boids);
      
      Vector2 alignVector = b.align(neighbors);
      Vector2 separationVector = b.separate(neighbors);
      Vector2 cohesionVector = b.cohese(neighbors);
      Vector2 wallAvoidance = CalculateWallAvoidance(b);
      b.velocity += (alignVector * Boid.alignmentWeight + separationVector * Boid.separationWeight + cohesionVector * Boid.cohesionWeight);
      b.velocity += wallAvoidance * 0.5;
      
    });
    
    boids.forEach((b) => b.update(dt));
    
   // wrapEdges();
  }
  
  Vector2 CalculateWallAvoidance(Boid boid) {
    Vector2 avoidanceVector = new Vector2(0.0, 0.0);
    
    if (boid.position.x < 40) {
      avoidanceVector.x = 10.0;
    }
    if (boid.position.x > worldSize.x - 40) {
      avoidanceVector.x = - 10.0;
    }
    if (boid.position.y < 40) {
      avoidanceVector.y = 10.0;
    }
    if (boid.position.y > worldSize.y - 40) {
      avoidanceVector.y = - 10.0;
    }
    
    return avoidanceVector;
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
