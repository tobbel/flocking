part of flocking;

class Boid {
  static const NEIGHBORHOOD_DISTANCE_SQUARED = 10000.0;
  
  Vector2 position;
  Vector2 velocity;

  // TODO: Angle (double neighborhoodAngle = Math.PI / 3.0;)
  // 60 degrees in each direction backwards from angle.
  
  Boid(this.position) {
    final double direction = Flocking.rand.nextDouble() * Math.PI * 2.0;
    velocity = new Vector2(Math.cos(direction), Math.sin(direction));
  }
  
  void update(double dt) {
    position += velocity * dt;
  }
  
  List<Boid> getNeighbors(List<Boid> boids) {
    List<Boid> neighbors = new List<Boid>();
    for (final b in boids)
    {
      // TODO: Angle
      //Vector2 toNeighbor = b.position - position;
      
      // DistanceTo
      final double distanceTo = position.distanceToSquared(b.position);
      if (distanceTo > NEIGHBORHOOD_DISTANCE_SQUARED)
        continue;
      
      neighbors.add(b);
    }
    
    return neighbors;
  }
}
