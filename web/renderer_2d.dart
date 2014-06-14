part of flocking;

class Renderer2D {
  Flock flock;
  CanvasRenderingContext2D context;
  Renderer2D(this.flock, this.context);
  
  void draw(double dt) {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    // Temp render boids
    flock.boids.forEach((b) {
      // TODO: Move canvas to center, rotate, draw triangle (see fractals)
      context.fillRect(b.position.x, b.position.y, 2, 2);
      
      // Temp draw neighbor distance (made for a cool pattern!)
      context.beginPath();
      context.arc(b.position.x, b.position.y, Boid.NEIGHBORHOOD_DISTANCE,     0, Math.PI*2, false);
      context.arc(b.position.x, b.position.y, Boid.NEIGHBORHOOD_DISTANCE - 1, 0, Math.PI*2, true);
      context.fill();
    });
  }
}
