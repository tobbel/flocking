part of flocking;

class Flocking {
  static Math.Random rand = new Math.Random();
  
  Flock flock;
  Renderer2D renderer;
  
  Flocking(CanvasElement canvas) {
    flock = new Flock();
    renderer = new Renderer2D(flock, canvas.context2D);    
  }
  
  void start() {
  }
 
  void update(double dt) {
    flock.update(dt);
    renderer.draw(dt);
  }
}