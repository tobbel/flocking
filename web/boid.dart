part of flocking;

class Boid {
  static const NEIGHBORHOOD_DISTANCE_SQUARED = 500.0;
  
  Vector2 position;
  Vector2 velocity;
  Vector2 acceleration;

  // TODO: Angle (double neighborhoodAngle = Math.PI / 3.0;)
  // 60 degrees in each direction backwards from angle.
  
  Boid(this.position) {
    final double direction = Flocking.rand.nextDouble() * Math.PI * 2.0;
    acceleration = new Vector2(Math.sin(direction), Math.cos(direction));
    velocity = new Vector2(0.0, 0.0);
  }
  
  void update(double dt) {
    // TODO: Limit maxspeed etc.
    velocity += acceleration * dt;
    position += velocity * dt;
    final double friction = 0.8;
    velocity -= velocity * friction;
  }
  
  void separate(List<Boid> neighbors) {
    if (neighbors.isEmpty)
          return;
        
    // Calculate sum of all toNeighbor vectors. Negate and add to velocity.
    Vector2 sumTo = new Vector2(0.0, 0.0);
    for (final n in neighbors) {
      Vector2 toNeighbor = n.position - position;
      sumTo += toNeighbor;
    }
    //velocity -= sumTo * 0.005;
    acceleration -= sumTo * 0.005;
  }
  
  void align(List<Boid> neighbors) {
    if (neighbors.isEmpty)
      return;
    
    // Calculate average heading of neighbors. 
    Vector2 sumVelocity = new Vector2(0.0, 0.0);
    for (final n in neighbors) {
      sumVelocity += n.velocity;
    }
    sumVelocity /= neighbors.length.toDouble();
    
    // TODO: Unsure how to apply this, think about it.
    //velocity += sumVelocity * 0.01;
    acceleration += sumVelocity * 0.01;
  }
  
  void cohese(List<Boid> neighbors) {
    if (neighbors.isEmpty)
      return;
    
    // Calculate average position of neighbors. Steer towards it.
    Vector2 avgPosition = new Vector2(0.0, 0.0);
    for (final n in neighbors) {
      avgPosition += n.position;
    }
    avgPosition /= neighbors.length.toDouble();
    final Vector2 toAvgPosition = avgPosition - position;
    //velocity += toAvgPosition * 0.01;
    acceleration += toAvgPosition * 0.01;
  }
  
  List<Boid> getNeighbors(List<Boid> boids) {
    List<Boid> neighbors = new List<Boid>();
    for (final b in boids)
    {
      // TODO: Angle
      //Vector2 toNeighbor = b.position - position;
      //final double angle = Math.atan2(toNeighbor.y, toNeighbor.x);
      
      // DistanceTo
      final double distanceTo = position.distanceToSquared(b.position);
      if (distanceTo > NEIGHBORHOOD_DISTANCE_SQUARED)
        continue;
      
      neighbors.add(b);
    }
    
    return neighbors;
  }
}
