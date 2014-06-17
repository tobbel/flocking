part of flocking;

class Boid {
  static const double NEIGHBORHOOD_DISTANCE = 20.0;
  static const double NEIGHBORHOOD_DISTANCE_SQUARED = 400.0;
  
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
    final double friction = 0.1;
    velocity -= velocity * friction;
  }
  
  void separate(List<Boid> neighbors) {
    if (neighbors.isEmpty)
          return;
        
    // Calculate sum of all toNeighbor vectors. Negate and add to velocity.
    Vector2 separation = new Vector2(0.0, 0.0);
    Vector2 sumTo = new Vector2(0.0, 0.0);
    double count = 0.0;
    for (final Boid n in neighbors) {
      final Vector2 toNeighbor = n.position - position;
      final double distance = toNeighbor.length;
      if (distance <= 0) continue;
      
      count++;
      sumTo += toNeighbor.normalized() / distance;
    }
    
    if (count <= 0) return;
    sumTo /= count;
    sumTo.normalize();
    final double maxSpeed = 20.0;
    sumTo *= maxSpeed;
    sumTo -= velocity;

    if (sumTo.length > 0.75)
    {
      sumTo.normalize();
      sumTo *= 0.75;
    }
    
    acceleration -= sumTo;
  }
  
  void align(List<Boid> neighbors) {
    if (neighbors.isEmpty)
      return;
    
    // Calculate average heading of neighbors. 
    Vector2 sumVelocity = new Vector2(0.0, 0.0);
    for (final Boid n in neighbors) {
      sumVelocity += n.velocity;
    }
    sumVelocity /= neighbors.length.toDouble();

    // TODO: Unsure how to apply this, think about it.
    sumVelocity.normalize();
    sumVelocity *= 20.0;
    sumVelocity -= velocity;

    if (sumVelocity.length > 0.3)
    {
      sumVelocity.normalize();
      sumVelocity *= 0.3;
    }
    acceleration += sumVelocity;
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
    acceleration += toAvgPosition * 0.01;
  }
  
  List<Boid> getNeighbors(List<Boid> boids) {
    List<Boid> neighbors = new List<Boid>();
    for (final Boid b in boids)
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
