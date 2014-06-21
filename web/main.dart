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

RangeInputElement separationInput;
RangeInputElement alignmentInput;
RangeInputElement cohesionInput;
SpanElement separationLabel;
SpanElement alignmentLabel;
SpanElement cohesionLabel;

double lastFrameTime = 0.0;

void main() {
  init();
}

void init() {
  canvas = querySelector('#flockingCanvas');
  flocking = new Flocking(canvas);

  canvas.onMouseDown.listen(mouseDown);
  
  // Input etc.
  separationInput = querySelector('#separationWeight');
  alignmentInput = querySelector('#alignmentWeight');
  cohesionInput = querySelector('#cohesionWeight');

  separationLabel = querySelector('#separationLabel');
  alignmentLabel = querySelector('#alignmentLabel');
  cohesionLabel = querySelector('#cohesionLabel');
  
  separationLabel.text = separationInput.value;
  alignmentLabel.text = alignmentInput.value;
  cohesionLabel.text = cohesionInput.value;

  separationInput.onInput.listen(inputChanged);
  alignmentInput.onInput.listen(inputChanged);
  cohesionInput.onInput.listen(inputChanged);
  
  scheduleMicrotask(flocking.start);
  window.animationFrame.then(update);
}

void inputChanged(Event e) {
  RangeInputElement changed = querySelector('#${(e.target as RangeInputElement).id}');
  String val;
  if (changed == separationInput) {
     val = separationInput.value;
     if (val.length > 0) {
       try {
         double realVal = double.parse(val);
         flocking.setSeparationWeight(realVal);
         separationLabel.text = val;
       } on FormatException catch (e) {
         print(e);
       }
     }
  } else if (changed == alignmentInput) {
    val = alignmentInput.value;
         if (val.length > 0) {
           try {
             double realVal = double.parse(val);
             flocking.setAlignmentWeight(realVal);
             alignmentLabel.text = val;
           } on FormatException catch (e) {
             print(e);
           }
         }
  } else if (changed == cohesionInput) {
    val = cohesionInput.value;
         if (val.length > 0) {
           try {
             double realVal = double.parse(val);
             flocking.setCohesionWeight(realVal);
             cohesionLabel.text = val;
           } on FormatException catch (e) {
             print(e);
           }
         }
  }
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
