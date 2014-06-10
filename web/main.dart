import 'dart:html';
import 'dart:math' as Math;
import 'package:vector_math/vector_math.dart';

CanvasElement canvas;
double lastFrameTime = 0.0;
Math.Random rand = new Math.Random();

void main() {
  canvas = querySelector('#flockingCanvas');
  canvas.context2D.fillRect(100.0, 100.0, 100.0, 100.0);
}

class Flock {
  List<Boid> boids;
  Flock() {
    boids = new List<Boid>();
    Vector2 startPosition = new Vector2(50.0, 50.0);
    for (int i = 0; i < 50; i++) {
      boids.add(new Boid(startPosition, boids));
    }

    window.animationFrame.then(update);
  }
  
  void update(double frameTime) {
    double dt = (frameTime - lastFrameTime).toDouble() / 1000.0;

    boids.forEach((b) => b.update(dt));

    lastFrameTime = frameTime;
    window.animationFrame.then(update);
  }
}

class Boid {
  // TODO: Might just check neighbors on the fly
  List<Boid> boids;
  Vector2 position;
  //Vector2 angle;
  double angle;
  // Arbitrary for now
  double neighborhoodDistance = 100.0;
  double neighborhoodAngle = Math.PI / 3.0; // 60 degrees in each direction backwards from angle.
  Boid(this.position, this.boids) {
    angle = rand.nextDouble() * Math.PI * 2.0;
  }
  
  // Boids have three rules for movement:
  // 1. Separation: Steer to avoid crowding local flockmates.
  // 2. Alignment: Steer towards the average heading of local flockmates.
  // 3. Cohesion: Steer to move toward the average position of local flockmates.
  void update(double dt) {
    // Find neighbors by distance
    // Calculate 
  }
}
