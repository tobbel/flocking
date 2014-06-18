part of flocking;

class Flocking {
  static Math.Random rand = new Math.Random();
  
  Flock flock;
  Renderer2D renderer;
  
  Flocking(CanvasElement canvas) {
    flock = new Flock(new Vector2(canvas.width.toDouble(), canvas.height.toDouble()));
    renderer = new Renderer2D(flock, canvas.context2D);    
  }
  
  void start() {
  }
 
  void update(double dt) {
    flock.update(dt);
    renderer.draw(dt);
  }
  
  void mouseDown(Vector2 position) {
    flock.addBoid(position);
  }
}
