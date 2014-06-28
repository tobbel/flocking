part of flocking;

class Boid {
  static const double NEIGHBORHOOD_DISTANCE = 10.0;
  
  static const double MAX_SPEED = 100.0;
  static const double MAX_ACCELERATION = 5.0;
  
  static double separationWeight = 1.0;
  static double alignmentWeight = 1.0;
  static double cohesionWeight = 1.0;
  
  // TODO: Static id counter, class istf int
  int id;
  
  Vector2 avgCenter = new Vector2(0.0, 0.0);
  
  Vector2 position;
  Vector2 velocity;
  Vector2 acceleration;

  Vector2 separationStrength = new Vector2(0.0, 0.0);
  Vector2 alignmentStrength = new Vector2(0.0, 0.0);
  Vector2 cohesionStrength = new Vector2(0.0, 0.0);

  // TODO: Angle (double neighborhoodAngle = Math.PI / 3.0;)
  // 60 degrees in each direction backwards from angle.

  Boid(this.position, this.id) {
    final double direction = Flocking.rand.nextDouble() * Math.PI * 2.0;
    acceleration = new Vector2(Math.sin(direction), Math.cos(direction));
    velocity = new Vector2(0.0, 0.0);
  }
  
  // This should be somewhere else, putting it here for now
  void limit(Vector2 vector, double maxLength) {
    if (vector.length2 > maxLength * maxLength) {
      vector.normalize();
      vector *= maxLength;
    }
  }
  
  void update(double dt) {
    velocity += acceleration * dt;
    limit(velocity, MAX_SPEED);
    position += velocity * dt;
    
    // TODO: Clearing acc in renderer to render acc
    //acceleration *= 0.0;
  }
  
  void separate(List<Boid> neighbors) {
    if (neighbors.isEmpty)
          return;
        
    // Calculate sum of all toNeighbor vectors. Negate and add to velocity.
    Vector2 separation = new Vector2(0.0, 0.0);
    Vector2 sumTo = new Vector2(0.0, 0.0);
    double count = 0.0;
    for (final Boid n in neighbors) {
      if (n == this) continue;
      final Vector2 toNeighbor = n.position - position;
      final double distance = toNeighbor.length;
      if (distance <= 0) continue;
      
      count++;
      sumTo += toNeighbor.normalized() / distance;
    }
    
    if (count <= 0) return;
    avgCenter = sumTo;
    sumTo /= count;
    sumTo.normalize();
    sumTo *= MAX_SPEED;
    sumTo -= velocity;

    limit(sumTo, MAX_ACCELERATION);
    separationStrength = sumTo * separationWeight;
    acceleration -= sumTo * separationWeight;
  }
  
  void align(List<Boid> neighbors) {
    if (neighbors.isEmpty)
      return;
    
    // Calculate average heading of neighbors. 
    Vector2 sumVelocity = new Vector2(0.0, 0.0);
    for (final Boid n in neighbors) {
      if (n == this) continue;
      sumVelocity += n.velocity.normalized();
    }
    sumVelocity /= neighbors.length.toDouble();
    sumVelocity.normalize();
    sumVelocity *= MAX_SPEED;
    sumVelocity -= velocity;

    limit(sumVelocity, MAX_ACCELERATION);
    alignmentStrength = sumVelocity * alignmentWeight;
    acceleration += sumVelocity * alignmentWeight;
  }
  
  void cohese(List<Boid> neighbors) {
    if (neighbors.isEmpty)
      return;
    
    // Calculate average position of neighbors. Steer towards it.
    Vector2 avgPosition = new Vector2(0.0, 0.0);
    for (final n in neighbors) {
      if (n == this) continue;
      avgPosition += n.position;
    }
    if (avgPosition.x == 0.0 && avgPosition.y == 0.0) {
      return;
    }

    avgPosition /= neighbors.length.toDouble();
    avgPosition.normalize();
    avgPosition *= MAX_SPEED;
    Vector2 steer = avgPosition - velocity;
    
    limit(steer, MAX_ACCELERATION);
    cohesionStrength = steer * cohesionWeight;
    acceleration += steer * cohesionWeight;
  }
  
  List<Boid> getNeighbors(List<Boid> boids) {
    List<Boid> neighbors = new List<Boid>();
    for (final Boid b in boids)
    {
      // TODO: Angle
      //Vector2 toNeighbor = b.position - position;
      //final double angle = Math.atan2(toNeighbor.y, toNeighbor.x);
      
      // DistanceTo
      final double distanceTo = position.distanceTo(b.position);
      if (distanceTo > NEIGHBORHOOD_DISTANCE)
        continue;
      
      neighbors.add(b);
    }
    
    return neighbors;
  }
}
