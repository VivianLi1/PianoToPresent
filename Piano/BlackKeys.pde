class BlackKeys extends Keys {

  public BlackKeys(int x, int y, int pitch) {
    super(x, y, 0, pitch);
  }

  void show() {
    fill(col);
    rect(getx(), gety(), 30, 100);
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

