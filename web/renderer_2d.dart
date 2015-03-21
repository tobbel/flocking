part of flocking;

class Renderer2D {
  Flock flock;
  CanvasRenderingContext2D context;
  Renderer2D(this.flock, this.context);
  
  void draw(double dt) {
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    // Temp render boids
    flock.boids.forEach((b) {
      Vector2 dir = b.velocity.normalized();
      Vector2 perp = new Vector2(-dir.y, dir.x);
      perp *= 15.0;
      Vector2 left = b.position + perp;
      Vector2 right = b.position - perp;
      Vector2 front = b.position + dir * 30.0;
      
      context.beginPath();
      context.moveTo(left.x, left.y);
      context.lineTo(right.x, right.y);
      context.stroke();
      context.lineTo(front.x, front.y);
      context.stroke();
      context.lineTo(left.x, left.y);
      context.stroke();
      final double speedFactor = b.velocity.length / Boid.MAX_SPEED * 0.5;
      final String redColor = (255 * speedFactor).toInt().toString();
      final String greenColor = (255 * (1 - speedFactor)).toInt().toString();
      final String color = 'rgba(' + redColor +', '+greenColor+', 0, 1.0)';
      context.fillStyle = color;
      context.closePath();
      context.fill();
      
      if (b.id == 0) {
        context.strokeStyle = 'black';
        context.beginPath();
        context.arc(b.position.x, b.position.y, Boid.NEIGHBORHOOD_DISTANCE, 0, 2 * Math.PI);
        context.stroke();
        context.closePath();
        // Separation: red
        context.strokeStyle = 'red';
        context.beginPath();
        context.moveTo(b.position.x, b.position.y);
        context.lineTo(b.position.x + b.separationStrength.x * 10.0, b.position.y + b.separationStrength.y * 10.0);
        context.stroke();
        context.closePath();

        // Alignment: blue
        context.strokeStyle = 'blue';
        context.beginPath();
        context.moveTo(b.position.x, b.position.y);
        context.lineTo(b.position.x + b.alignmentStrength.x * 10.0, b.position.y + b.alignmentStrength.y * 10.0);
        context.stroke();
        context.closePath();

        // Cohesion: green
        context.strokeStyle = 'yellow';
        context.beginPath();
        context.moveTo(b.position.x, b.position.y);
        context.lineTo(b.position.x + b.cohesionStrength.x * 10.0, b.position.y + b.cohesionStrength.y * 10.0);
        context.stroke();
        context.closePath();
        
        // All together now
        context.strokeStyle = 'black';
        context.beginPath();
        context.moveTo(b.position.x, b.position.y);
        
        context.stroke();
        context.closePath();
      }
    });
  }
}
