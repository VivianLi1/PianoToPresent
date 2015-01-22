class Keys {
  //Instance variables: width, length, x/y coordinate, color; note
  int x, y, origColor, col, pitch;
  int vol;
  Note note;

  //constructor

  Keys(int x, int y, int origColor, int pitch) {
    setx(x);
    sety(y);
    setOrigColor(origColor);
    setColor(origColor);
    //setVol(vol);
    setPitch(pitch);
    //setNote(pitch);
  }

  Keys() {
  }

  public int getx() {
    return x;
  }
  void setx(int xcor) {
    x = xcor;
  }

  int gety() {
    return y;
  }
  void sety(int ycor) {
    y = ycor;
  }

  int getPitch() {
    return pitch;
  }
  void setPitch(int p) {
    pitch = p;
  }

  void setOrigColor(int oc) {
    origColor = oc;
  }

  void setColor(int c) {
    col = c;
  }

  int getColor() {
    return col;
  }

  void setVol(int v) {
    vol = v;
  }
  
/*
  void setNote(int p) {
    p = pitch;
    v = vol;
    note = new Note(0, p, v);
  }

*/
  void show() {
  }


  //used by Piano to change color and play note

  public void pressed(boolean p) {
  }
/*
  void playNote(int p, boolean b) {
    if (b == true) {
      //midiBus.sendMessage(0xC0, 0, instr, 0);
      midiBus.sendNoteOn(0,p,v);
    }
  }
  */
}

