part of flocking;


class DatGUIController {
  Flocking flocking;
  num separationWeight;
  num alignmentWeight;
  num cohesionWeight;
  DatGUIController(this.flocking) {
    this.separationWeight = 0.1;
    this.alignmentWeight = 0.1;
    this.cohesionWeight = 0.1;
  }
  
  void reset() {
    flocking.reset();
  }
}

class Flocking {
  static Math.Random rand = new Math.Random();
  
  Flock flock;
  Renderer2D renderer;
  dat.GUI gui;
  DatGUIController DGC;
  
  Flocking(CanvasElement canvas) {
    flock = new Flock(new Vector2(canvas.width.toDouble(), canvas.height.toDouble()));
    renderer = new Renderer2D(flock, canvas.context2D);
    DGC = new DatGUIController(this);
    gui = new dat.GUI();
    gui.add(DGC, 'reset'); 
    gui.add(DGC, 'separationWeight', 0, 1).step(0.01);
    gui.add(DGC, 'alignmentWeight', 0, 1).step(0.01);
    gui.add(DGC, 'cohesionWeight', 0, 1).step(0.01);
  }
  
  void start() {
  }
 
  void update(double dt) {
    Boid.separationWeight = DGC.separationWeight;
    Boid.alignmentWeight = DGC.alignmentWeight;
    Boid.cohesionWeight = DGC.cohesionWeight;
    flock.update(dt);
    renderer.draw(dt);
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
