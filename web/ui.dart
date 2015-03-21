part of flocking;

// TODO: UIElement, UISlider?
class UIButton {
  Vector2 position;
  Vector2 size;
  bool hover = false;
  String text;
  UIButton.FromVectors(this.position, this.size, [this.text = ""]) {
    
  }
  
  UIButton(int x, int y, int width, int height, [this.text = ""]) {
    this.position = new Vector2(x.toDouble(), y.toDouble());
    this.size = new Vector2(width.toDouble(), height.toDouble());
  }
  
  bool contains(int x, int y) {
    if (x > position.x.toInt() && x < position.x.toInt() + size.x.toInt() &&
        y > position.y.toInt() && y < position.y.toInt() + size.y.toInt()) {
      return true;
    }
    return false;
  }
}

class UI {
  Flock flock;
  CanvasElement canvas;
  List<UIButton> buttons;
  UI(this.flock, this.canvas) {
    buttons = new List<UIButton>();
    
    UIButton resetButton = new UIButton(100, 100, 100, 20, "Test");
    buttons.add(resetButton);
    canvas.onMouseMove.listen(onMouseMove);
  }
  
  void draw(double dt) {
    // TODO: Update, clear hover for all elements?
    for (UIButton button in buttons) {
      canvas.context2D.fillStyle = button.hover ? 'green' : 'red';
      canvas.context2D.fillRect(button.position.x, button.position.y, button.size.x, button.size.y);
      if (!button.text.isEmpty)
      {
        canvas.context2D.font = '20px sans-serif';
        canvas.context2D.textBaseline = "hanging";
        canvas.context2D.fillStyle = 'black';
        canvas.context2D.fillText(button.text, button.position.x, button.position.y + 3, button.size.x);
      }
    }
  }
  
  void onMouseMove(MouseEvent e) {
    int x = e.client.x;
    int y = e.client.y;
    for (UIButton button in buttons) {
      if (button.contains(x, y)) {
        button.hover = true;
      } else {
        button.hover = false;
      }
    }
  }
  
  void onMouseDown(MouseEvent e) {
    int x = e.client.x;
    int y = e.client.y;
    // TODO: Swallow etc.
    for (UIButton button in buttons) {
      if (button.hover) {
        // Probably trigger callback
      }
    }
  }
}