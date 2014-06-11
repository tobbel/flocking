part of flocking;

class Flocking {
  CanvasRenderingContext2D context;
  Flock flock;
  Renderer2D renderer;
  static Math.Random rand = new Math.Random();
  Flocking(CanvasElement canvas) {
    context = canvas.context2D;
    flock = new Flock();
    renderer = new Renderer2D(flock, context);
  }
  
  void start() {
    
  }
 
  void update(double dt) {
    flock.update(dt);

    renderer.draw(dt);
     
  }
}