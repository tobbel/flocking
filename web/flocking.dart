part of flocking;


class DatGUIController {
  Flocking flocking;
  DatGUIController(this.flocking) {
    
  }
  
  void reset() {
    flocking.reset();
  }
}

class Flocking {
  static Math.Random rand = new Math.Random();
  
  Flock flock;
  Renderer2D renderer;
  UI ui;
  dat.GUI gui;
  
  Flocking(CanvasElement canvas) {
    flock = new Flock(new Vector2(canvas.width.toDouble(), canvas.height.toDouble()));
    renderer = new Renderer2D(flock, canvas.context2D);
    ui = new UI(flock, canvas);
    DatGUIController DGC = new DatGUIController(this);
    gui = new dat.GUI();
    gui.add(DGC, 'reset');
  }
  
  void start() {
  }
 
  void update(double dt) {
    flock.update(dt);
    renderer.draw(dt);
    ui.draw(dt);
  }
  
  void mouseDown(Vector2 position) {
    flock.addBoid(position);
  }

  void setSeparationWeight(double weight) {
    Boid.separationWeight = weight;
  }
  
  void setAlignmentWeight(double weight) {
    Boid.alignmentWeight = weight;
  }
  
  void setCohesionWeight(double weight) {    
    Boid.cohesionWeight = weight;
  }
  
  void setWorldSize(Vector2 size) {
    flock.worldSize = size;
  }
  
  void reset() {
   flock.reset(); 
  }
}
