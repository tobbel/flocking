part of flocking;

class Flock {
  List<Boid> boids;
  static const int NUM_BOIDS = 50;
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
      
      b.separate(neighbors);
      //b.align(neighbors);
      //b.cohese(neighbors);
    });
    
    boids.forEach((b) => b.update(dt));
    
    if (logTimer > 0.0) {
      logTimer -= dt;
      if (logTimer <= 0.0) {
        logTimer = 1.0;
        // Get fastest boid
        double maxVelocity = 0.0;
        double maxAcceleration = 0.0;
        boids.forEach((b) {
          if (b.velocity.length > maxVelocity) maxVelocity = b.velocity.length;
          if (b.acceleration.length > maxAcceleration) maxAcceleration = b.acceleration.length;
        });
        print('------------------------------');
        print('Max Velocity    : $maxVelocity');
        print('Max Acceleration: $maxAcceleration');
      }
    }
    
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
