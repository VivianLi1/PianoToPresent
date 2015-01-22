import themidibus.*;
import controlP5.*;

MidiBus midiBus;
ControlP5 cp5;
int currentScreen;
int currentOctave = 0;
int beginX = 115;
int beginY = 150;
int beginW = 120;
int beginH = 30;
int settingsX = 125;
int settingsY = 200;
int settingsW = 100;
int settingsH = 30;
int helpX, helpY, helpW, helpH;
int setX, setY, setW, setH;
int backX, backY, backW, backH;
int pianoX, pianoY, pianoW, pianoH;
int soundLowX, soundLowY, soundLowW, soundLowH;
int soundMedX, soundMedY, soundMedW, soundMedH;
int soundHiX, soundHiY, soundHiW, soundHiH;
int redX, redY;
int greenX, greenY;
int blueX, blueY;
int colW, colH;
int currentIndex;
int backColor = 0;
int vol = 85;

String[] instrNames = new String[128];

Keys[] KeyBoard0 = new Keys[12];
Keys[] KeyBoard1 = new Keys[12];
Keys[] KeyBoard2 = new Keys[12];
Keys[] temp = new Keys[12];

void setup() { 
  size(351, 301, P3D);
  //noStroke();
  smooth();

  //make keys for middle octave
  KeyBoard0[0] = new WhiteKeys(1, 0, 100, 60);
  KeyBoard0[1] = new WhiteKeys(2, 50, 100, 62);
  KeyBoard0[2] = new WhiteKeys(3, 150, 100, 64);
  KeyBoard0[3] = new WhiteKeys(1, 150, 100, 65);
  KeyBoard0[4] = new WhiteKeys(2, 200, 100, 67);
  KeyBoard0[5] = new WhiteKeys(2, 250, 100, 69);
  KeyBoard0[6] = new WhiteKeys(3, 350, 100, 71);
  KeyBoard0[7] = new BlackKeys(35, 100, 61);
  KeyBoard0[8] = new BlackKeys(85, 100, 63);
  KeyBoard0[9] = new BlackKeys(185, 100, 66);
  KeyBoard0[10] = new BlackKeys(235, 100, 68);
  KeyBoard0[11] = new BlackKeys(285, 100, 70);

  //make keys for higher octave
  KeyBoard1[0] = new WhiteKeys(1, 0, 100, 72);
  KeyBoard1[1] = new WhiteKeys(2, 50, 100, 74);
  KeyBoard1[2] = new WhiteKeys(3, 150, 100, 76);
  KeyBoard1[3] = new WhiteKeys(1, 150, 100, 77);
  KeyBoard1[4] = new WhiteKeys(2, 200, 100, 79);
  KeyBoard1[5] = new WhiteKeys(2, 250, 100, 81);
  KeyBoard1[6] = new WhiteKeys(3, 350, 100, 83);
  KeyBoard1[7] = new BlackKeys(35, 100, 73);
  KeyBoard1[8] = new BlackKeys(85, 100, 75);
  KeyBoard1[9] = new BlackKeys(185, 100, 78);
  KeyBoard1[10] = new BlackKeys(235, 100, 80);
  KeyBoard1[11] = new BlackKeys(285, 100, 82);

  //make keys for lower octave
  KeyBoard2[0] = new WhiteKeys(1, 0, 100, 48);
  KeyBoard2[1] = new WhiteKeys(2, 50, 100, 50);
  KeyBoard2[2] = new WhiteKeys(3, 150, 100, 52);
  KeyBoard2[3] = new WhiteKeys(1, 150, 100, 53);
  KeyBoard2[4] = new WhiteKeys(2, 200, 100, 55);
  KeyBoard2[5] = new WhiteKeys(2, 250, 100, 57);
  KeyBoard2[6] = new WhiteKeys(3, 350, 100, 59);
  KeyBoard2[7] = new BlackKeys(35, 100, 49);
  KeyBoard2[8] = new BlackKeys(85, 100, 51);
  KeyBoard2[9] = new BlackKeys(185, 100, 54);
  KeyBoard2[10] = new BlackKeys(235, 100, 56);
  KeyBoard2[11] = new BlackKeys(285, 100, 58);

  midiBus = new MidiBus(this, 0, 2);
  cp5 = new ControlP5(this);  
  DropdownList instruments;
  instruments = cp5.addDropdownList("Instruments");
  instruments.setPosition(105, 23); 
  instruments.setSize(150,60);
  makeInstrNames();
  instruments.addItems(instrNames);
  //midiBus.sendMessage(0xC0, 0, currentIndex, 0);
}

void controlEvent(ControlEvent e) {
  if (e.name().equals("Instruments")) {
    currentIndex = (int)e.group().value();
    //println(currentIndex);
  }
}

void makeInstrNames() {
  instrNames = loadStrings("InstrNames.txt");
}


void draw() {
  switch(currentScreen) {
  case 0: 
    displayTitle(); 
    break;
  case 1: 
    displayPiano();
    //instruments.setPosition(123,25);
    break;
  case 2:
    displaySettings();
    break;
  case 3:
    displayHelp();
    break;
  default: 
    background(0); 
    break;
  }
  copyKeyBoard();
  //midiBus.sendMessage(0xC0, 0, currentIndex, 0);
}

void octaveChange() {
  if (key == CODED) {
    if (keyCode == SHIFT && currentOctave <= 1 && currentOctave > -1) {
      currentOctave--;
      //println(currentOctave);
    }
    if (keyCode == CONTROL && currentOctave >= -1 && currentOctave < 1) {
      currentOctave++;
      //println(currentOctave);
    }
  }
}

void copyKeyBoard() {
  if (currentOctave == 0) {
    temp = KeyBoard0.clone();
  }
  if (currentOctave == -1) {
    temp = KeyBoard2.clone();
  }
  if (currentOctave == 1) {
    temp = KeyBoard1.clone();
  }
}

void keyPressed() {
  octaveChange();
  midiBus.sendMessage(0xC0, 0, currentIndex, 0);
  if (currentScreen == 1) {
    if (key == 's' && temp[0].getColor()==255) {
      temp[0].pressed(true);
      midiBus.sendNoteOn(0, temp[0].pitch, vol);
    }
    if (key == 'd' && temp[1].getColor()==255) {
      temp[1].pressed(true);
      midiBus.sendNoteOn(0, temp[1].pitch, vol);
    }
    if (key == 'f' && temp[2].getColor()==255) {
      temp[2].pressed(true);
      midiBus.sendNoteOn(0, temp[2].pitch, vol);
    }
    if (key == 'g' && temp[3].getColor()==255) {
      temp[3].pressed(true);
      midiBus.sendNoteOn(0, temp[3].pitch, vol);
    }
    if (key == 'h' && temp[4].getColor()==255) {
      temp[4].pressed(true);
      midiBus.sendNoteOn(0, temp[4].pitch, vol);
    }
    if (key == 'j' && temp[5].getColor()==255) {
      temp[5].pressed(true);
      midiBus.sendNoteOn(0, temp[5].pitch, vol);
    }
    if (key == 'k' && temp[6].getColor()==255) {
      temp[6].pressed(true);
      midiBus.sendNoteOn(0, temp[6].pitch, vol);
    }
    if (key == 'e' && temp[7].getColor()==0) {
      temp[7].pressed(true);
      midiBus.sendNoteOn(0, temp[7].pitch, vol);
    }
    if (key == 'r' && temp[8].getColor()==0) {
      temp[8].pressed(true);
      midiBus.sendNoteOn(0, temp[8].pitch, vol);
    }
    if (key == 'y' && temp[9].getColor()==0) {
      temp[9].pressed(true);
      midiBus.sendNoteOn(0, temp[9].pitch, vol);
    }
    if (key == 'u' && temp[10].getColor()==0) {
      temp[10].pressed(true);
      midiBus.sendNoteOn(0, temp[10].pitch, vol);
    }
    if (key == 'i' && temp[11].getColor()==0) {
      temp[11].pressed(true);
      midiBus.sendNoteOn(0, temp[11].pitch, vol);
    }
  }
}

void keyReleased() {
  if (currentScreen == 1) {
    if (key == 's' && temp[0].getColor() == 200) {
      temp[0].pressed(false);
      //KeyBoard0[0].playNote(KeyBoard0[0].pitch, false);
    }
    if (key == 'd' && temp[1].getColor() == 200) {
      temp[1].pressed(false);
      //KeyBoard0[1].playNote(KeyBoard0[1].pitch, false);
    }
    if (key == 'f' && temp[2].getColor() == 200) {
      temp[2].pressed(false);
      //KeyBoard0[2].playNote(KeyBoard0[2].pitch, false);
    }
    if (key == 'g' && temp[3].getColor() == 200) {
      temp[3].pressed(false);
      //KeyBoard0[3].playNote(KeyBoard0[3].pitch, false);
    }
    if (key == 'h' && temp[4].getColor() == 200) {
      temp[4].pressed(false);
      //KeyBoard0[4].playNote(KeyBoard0[4].pitch, false);
    }
    if (key == 'j' && temp[5].getColor() == 200) {
      temp[5].pressed(false);
      //KeyBoard0[5].playNote(KeyBoard0[5].pitch, false);
    }
    if (key == 'k' && temp[6].getColor() == 200) {
      temp[6].pressed(false);
      //KeyBoard0[6].playNote(KeyBoard0[6].pitch, false);
    }
    if (key == 'e' && temp[7].getColor() == 200) {
      temp[7].pressed(false);
      //KeyBoard0[7].playNote(KeyBoard0[7].pitch, false);
    }
    if (key == 'r' && temp[8].getColor() == 200) {
      temp[8].pressed(false);
      //KeyBoard0[8].playNote(KeyBoard0[8].pitch, false);
    }
    if (key == 'y' && temp[9].getColor() == 200) {
      temp[9].pressed(false);
      //KeyBoard0[9].playNote(KeyBoard0[9].pitch, false);
    }
    if (key == 'u' && temp[10].getColor() == 200) {
      temp[10].pressed(false);
      //KeyBoard0[10].playNote(KeyBoard0[10].pitch, false);
    }
    if (key == 'i' && temp[11].getColor() == 200) {
      temp[11].pressed(false);
      //KeyBoard0[11].playNote(KeyBoard0[11].pitch, false);
    }
  }
}

void displayPiano() {
  //instruments.setPosition(125, 23); 

  if (backColor == 0) {
    background(199, 45, 45);
  }
  if (backColor == 1) {
    background(35, 163, 59);
  }
  if (backColor == 2) {
    background(0, 102, 153);
  }

  String o = "";
  if (currentOctave == -1) {
    o = "Lower";
  }
  if (currentOctave == 0) {
    o = "Middle";
  }
  if (currentOctave == 1) {
    o = "Higher";
  }
  String s = o + " Octave";
  textSize(32);
  fill(255);
  text(s, 0, -100, width, height);
  for (int i=0; i<temp.length; i++) {
    temp[i].show();
  }
  fill(255);
  //instructions
  helpX = 325;
  helpY = 5;
  helpW = 20;
  helpH = 20;
  rect(helpX, helpY, helpW, helpH);
  fill(0);
  textSize(15);
  text("?", 335, 13);
  //settings
  fill(255);
  setX = 5;
  setY = 5;
  setW = 20;
  setH = 20;
  rect(setX, setY, setW, setH);
  fill(0);
  text("S", 15, 13);
}

void displayTitle() {
  String s = "Click to begin";
  String t = "Settings";
  background(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(255);
  text("Tiny Piano", 175, 90);
  rect(beginX, beginY, beginW, beginH);
  textSize(15);
  fill(35, 163, 59);
  text(s, 175, 162);
  fill(255);
  rect(settingsX, settingsY, settingsW, settingsH);
  fill(199, 45, 45);
  text(t, 175, 212);
}

void displaySettings() {
  background(0);
  String v = "Volume:";
  String b = "Background Color:";
  String d = "Created by Vivian Li and Felicity Ng";
  fill(255);
  textSize(50);
  text("Settings", 175, 40);
  textSize(20);
  text(v, 71, 110);
  text(b, 120, 160);
  textSize(15);
  text(d, 175, 215);

  //for background: Red, Green, Blue?
  //red
  fill(199, 45, 45);
  redX = 225;
  redY = 155;
  colW = 25;
  colH = 15;
  rect(redX, redY, colW, colH);
  //green
  fill(35, 163, 59);
  greenX = 260;
  greenY = 155;
  rect(greenX, greenY, colW, colH);
  //blue
  fill(0, 102, 153);
  blueX = 295;
  blueY = 155;
  rect(blueX, blueY, colW, colH);

  //Volume: Loudish,Loud,Loudest
  fill(255);
  //volume
  soundLowX = 130;
  soundLowY = 100;
  soundLowW = 50;
  soundLowH = 25;
  soundMedX = 200;
  soundMedY = 100;
  soundMedW = 50;
  soundMedH = 25;
  soundHiX = 270;
  soundHiY = 100;
  soundHiW = 50;
  soundHiH = 25;
  rect(soundLowX, soundLowY, soundLowW, soundLowH);
  rect(soundMedX, soundMedY, soundMedW, soundMedH);
  rect(soundHiX, soundHiY, soundHiW, soundHiH);
  //volume
  fill(177, 15, 110);
  textSize(15);
  text("Meh", 155, 110);
  text("Okay", 225, 110);
  text("YEAH", 295, 110);

  //finished button (Takes you to piano)
  fill(255);
  pianoX = 130;
  pianoY = 250;
  pianoW = 90;
  pianoH = 30;
  rect(pianoX, pianoY, pianoW, pianoH);
  fill(0);
  textSize(15);
  text("Piano time!", 175, 263);
} 

void displayHelp() {
  background(0);
  String h = "To play: press SDFGHJK on your keyboard \n for white keys and ERYUI for black keys.";
  String c = "To change octaves: press CTRL to change \n to a higher octave and SHIFT to change to \n a lower octave.";
  textSize(25);
  fill(255);
  text("How to use Tiny Piano", 175, 45);
  textSize(15);
  text(h, 175, 100);
  text(c, 175, 173);
  fill(255);
  backX = 145;
  backY = 252;
  backW = 60;
  backH = 26;
  rect(backX, backY, backW, backH);
  fill(0);
  text("Back", 175, 263);
}



boolean overMouse(int x, int y, int w, int h) {
  return(mouseX > x && mouseX < x+w
    && mouseY > y && mouseY < y+h);
}

void mousePressed() {
  if (currentScreen == 0) {
    if (overMouse(beginX, beginY, beginW, beginH)) {
      currentScreen = 1;
    }
    if (overMouse(settingsX, settingsY, settingsW, settingsH)) {
      currentScreen = 2;
    }
  }
  if (currentScreen == 1) {
    if (overMouse(helpX, helpY, helpW, helpH)) {
      currentScreen = 3;
    }
    if (overMouse(setX, setY, setW, setH)) {
      currentScreen = 2;
    }
  }
  if (currentScreen == 2) {
    if (overMouse(pianoX, pianoY, pianoW, pianoH)) {
      currentScreen = 1;
    }
    if (overMouse(soundLowX, soundLowY, soundLowW, soundLowH)) {
      vol = 30;
    }
    if (overMouse(soundMedX, soundMedY, soundMedW, soundMedH)) {
      vol = 85;
    }
    if (overMouse(soundHiX, soundHiY, soundHiW, soundHiH)) {
      vol = 500;
    }

    if (overMouse(redX, redY, colW, colH)) {
      backColor = 0;
    }
    if (overMouse(greenX, greenY, colW, colH)) {
      backColor = 1;
    }
    if (overMouse(blueX, blueY, colW, colH)) {
      backColor = 2;
    }
  }
  if (currentScreen == 3) {
    if (overMouse(backX, backY, backW, backH)) {
      currentScreen = 1;
    }
  }
}

