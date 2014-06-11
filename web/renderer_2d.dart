part of flocking;

class Renderer2D {
  Flock flock;
  CanvasRenderingContext2D context;
  Renderer2D(this.flock, this.context);
  
  void draw(double dt) {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    // Temp render boids
    flock.boids.forEach((b) {
      
      context.fillRect(b.position.x, b.position.y, 2, 2);
    });
  }
}
