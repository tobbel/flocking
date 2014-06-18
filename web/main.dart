library flocking;

import 'dart:html';
import 'dart:math' as Math;
import 'dart:async';

import 'package:vector_math/vector_math.dart';

part 'boid.dart';
part 'flock.dart';
part 'flocking.dart';
part 'renderer_2d.dart';

Flocking flocking;
CanvasElement canvas;

double lastFrameTime = 0.0;

void main() {
  init();
}

void init() {
  canvas = querySelector('#flockingCanvas');
  flocking = new Flocking(canvas);

  canvas.onMouseDown.listen(mouseDown);
  
  scheduleMicrotask(flocking.start);
  window.animationFrame.then(update);
}


void update(double frameTime) {
  double dt = (frameTime - lastFrameTime).toDouble() * 0.001;
  
  flocking.update(dt);
  
  lastFrameTime = frameTime;
  window.animationFrame.then(update);
}


void mouseDown(MouseEvent e) {
  flocking.mouseDown(getMouseCanvasPosition(e));
}

Vector2 getMouseCanvasPosition(MouseEvent e) {
  Rectangle rect = canvas.getBoundingClientRect();

  var x = e.client.x - rect.left;
  var y = e.client.y - rect.top;
  return new Vector2(x, y);
}
