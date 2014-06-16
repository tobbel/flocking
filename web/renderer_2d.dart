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
      context.beginPath();
      Vector2 direction = b.velocity.normalized();
      Vector2 perpDir = new Vector2(-direction.y, direction.x);
      perpDir *= 15.0; // base is 10 long
      double x = b.position.x + perpDir.x;
      double y = b.position.y + perpDir.y;
      context.moveTo(x, y);
      x -= perpDir.x * 2.0;
      y -= perpDir.y * 2.0;
      context.lineTo(x, y);
      context.stroke();
      
      // Current angle
      double angle = Math.atan2(y, x);
      // Add 250 deg
      angle += 250 * Math.PI / 180.0;
      Vector2 oldPos = new Vector2(x, y);
      // Back to vector again
      double newx = Math.cos(angle);
      double newy = Math.sin(angle);
      Vector2 dirVector = new Vector2(newx, newy).normalized();
      dirVector *= 30.0;
      Vector2 newPos = oldPos + dirVector; 
      context.lineTo(newPos.x, newPos.y);
      context.stroke();
      
      angle = Math.atan2(y, x);
      angle += 40 * Math.PI / 180.0;
      newx = Math.cos(angle);
      newy = Math.sin(angle);
      dirVector = new Vector2(newx, newy).normalized();
      dirVector *= 30.0;
      newPos += dirVector;
      context.lineTo(newPos.x, newPos.y);
      context.stroke();
      
      //context.fillRect(b.position.x, b.position.y, 2, 2);
    });
  }
}
