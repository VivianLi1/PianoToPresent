class WhiteKeys extends Keys {

  PShape whiteKey;

  public WhiteKeys(int pos, int x, int y, int pitch) {
    super(x, y, 255, pitch);
    if (pos == 1) { 
      makeWhiteKeysLeft();
    }
    if (pos == 2) { 
      makeWhiteKeysMid();
    }
    if (pos == 3 ) {
      makeWhiteKeysRight();
    }
  }

  void makeWhiteKeysLeft() {
    whiteKey = createShape();
    whiteKey.beginShape();
    whiteKey.vertex(0, 0);
    whiteKey.vertex(35, 0);
    whiteKey.vertex(35, 100);
    whiteKey.vertex(50, 100);
    whiteKey.vertex(50, 200);
    whiteKey.vertex(0, 200);
    whiteKey.endShape(CLOSE);
  }

  void makeWhiteKeysMid() {
    whiteKey = createShape();
    whiteKey.beginShape();
    whiteKey.vertex(0, 100);
    whiteKey.vertex(15, 100);
    whiteKey.vertex(15, 0);
    whiteKey.vertex(35, 0);
    whiteKey.vertex(35, 100);
    whiteKey.vertex(50, 100);
    whiteKey.vertex(50, 200);
    whiteKey.vertex(0, 200);
    whiteKey.endShape(CLOSE);
  }

  void makeWhiteKeysRight() {
    makeWhiteKeysLeft();
    whiteKey.rotateY(PI);
  }

  void show() {
    whiteKey.setFill(color(col));
    shape(whiteKey, getx(), gety());
  }


  public void pressed(boolean p) {
    if (p) {
      setColor(200);
      this.show();
    } else {
      //go back to normal
      setColor(origColor);
      this.show();
    }
  }
}

