part of flocking;

class Boid {
  static const double NEIGHBORHOOD_DISTANCE = 5.0;
  static const double NEIGHBORHOOD_DISTANCE_SQUARED = 25.0;
  
  static const double MAX_SPEED = 2.0;
  static const double MAX_ACCELERATION = 0.03;
  
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
  
  // This should be somewhere else, putting it here for now
  void limit(Vector2 vector, double maxLength) {
    // If vec lengthSq > maxLengthSq, limit to maxLength
    if ((vector.length2 > 0.0) && (vector.length2 > (maxLength * maxLength))) {
      double ratio = maxLength / vector.length;
      vector.x *= ratio;
      vector.y *= ratio;
    }
  }
  
  void update(double dt) {
    velocity += acceleration * dt;
    // Limit velocity by MAX_SPEED
    limit(velocity, MAX_SPEED);
    position += velocity * dt;
    //final double friction = 0.1;
    //velocity -= velocity * friction;
    acceleration *= 0.0;
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
    final double maxSpeed = 100.0;
    sumTo *= maxSpeed;
    sumTo -= velocity;

    if (sumTo.length > 2.0)
    {
      sumTo.normalize();
      sumTo *= 2.0;
    }
    
    acceleration -= sumTo;
  }
  
  void align(List<Boid> neighbors) {
    if (neighbors.isEmpty)
      return;
    
    // Calculate average heading of neighbors. 
    Vector2 sumVelocity = new Vector2(0.0, 0.0);
    for (final Boid n in neighbors) {
      sumVelocity += n.velocity.normalized();
    }
    sumVelocity /= neighbors.length.toDouble();
    sumVelocity.normalize();
    sumVelocity *= 30.0;
    sumVelocity -= velocity;

    if (sumVelocity.length > 0.7)
    {
      sumVelocity.normalize();
      sumVelocity *= 0.7;
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
    acceleration += toAvgPosition * 0.3;
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
