part of flocking;

class Boid {
  static const double NEIGHBORHOOD_DISTANCE = 100.0;
  
  static const double MAX_SPEED = 150.0;
  
  static num separationWeight = 0.1;
  static num alignmentWeight = 0.1;
  static num cohesionWeight = 0.1;
  
  // TODO: Static id counter, class istf int
  int id;
  
  Vector2 avgCenter = new Vector2(0.0, 0.0);
  
  Vector2 position;
  Vector2 velocity;

  Vector2 separationStrength = new Vector2(0.0, 0.0);
  Vector2 alignmentStrength = new Vector2(0.0, 0.0);
  Vector2 cohesionStrength = new Vector2(0.0, 0.0);

  // TODO: Angle (double neighborhoodAngle = Math.PI / 3.0;)
  // 60 degrees in each direction backwards from angle.

  Boid(this.position, this.id) {
    final double direction = Flocking.rand.nextDouble() * Math.PI * 2.0;
    velocity = new Vector2(Flocking.rand.nextDouble() * 100 - 50, Flocking.rand.nextDouble() * 100 - 50);
  }
  
  // This should be somewhere else, putting it here for now
  Vector2 limit(Vector2 vector, double maxLength) {
    if (vector.length2 > maxLength * maxLength) {
      vector.normalize();
      vector *= maxLength;
    }
    return vector;
  }
  
  void update(double dt) {
    velocity = limit(velocity, MAX_SPEED);
    position += velocity * dt;
  }
  
  Vector2 separate(List<Boid> neighbors) {
    Vector2 totalSeparation = new Vector2(0.0, 0.0);
    if (neighbors.isEmpty)
      return totalSeparation;
    
    for (final Boid n in neighbors) {
      totalSeparation += n.position - this.position;
    }
    
    totalSeparation.x /= neighbors.length;
    totalSeparation.y /= neighbors.length;
    totalSeparation *= -1.0;
    totalSeparation.normalize();
    
    return totalSeparation;
  }
  
  Vector2 align(List<Boid> neighbors) {
    Vector2 totalAlignment = new Vector2(0.0, 0.0);
    
    if (neighbors.isEmpty)
      return totalAlignment;
    
    for (final Boid n in neighbors) {
      totalAlignment += n.velocity;
    }
    
    totalAlignment.x /= neighbors.length;
    totalAlignment.y /= neighbors.length;
    totalAlignment.normalize();
    
    return totalAlignment;
  }
 
  Vector2 cohese(List<Boid> neighbors) {
    Vector2 totalCohesion = new Vector2(0.0, 0.0);
    
    if (neighbors.isEmpty)
      return totalCohesion;
    
    for (final n in neighbors) {
      if (n == this) continue;
      totalCohesion += n.position;
    }
    
    totalCohesion.x /= neighbors.length;
    totalCohesion.y /= neighbors.length;
    
    totalCohesion = totalCohesion - this.position;
    totalCohesion.normalize();
    return totalCohesion;
  }
  
  List<Boid> getNeighbors(List<Boid> boids) {
    List<Boid> neighbors = new List<Boid>();
    for (final Boid b in boids)
    {
      if (b == this) continue;
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
