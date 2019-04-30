/*
  ACOUSTIC ASTRONOMY:
  ASTRONOMY VISUALIZATION IN PROCESSING 3
  
  MIKE POIRIER
  BHA MAKER FAIRE 2019
  MAY 18, 2019
*/

import processing.sound.*;

Amplitude amp;
AudioIn in;

PImage img;
String choiceText;

int smallPoint = 1;
int largePoint = 60;
int choice = 1;
int MAX_IMAGES = 15;
int MAX_PARTICLES = 2000;

//Set intial time
int time = millis();

void setup() {
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in); //analyze computer input stream for amplitude

  fullScreen(); 
  imageMode(CENTER);
  noStroke();
  background(0);
  loadAstroImage();
}

void draw() {
  if (millis() > time + 12000){
    loadAstroImage();
    choice = int(random(1,3));
    time = millis();
    MAX_PARTICLES = int(random(250,2500));
    smallPoint = int(random(1, 20));
    largePoint = int(random(20, 100));
  }
  
  if (keyPressed){
    loadAstroImage();
    choice = int(random(1,3));
    time = millis();
    MAX_PARTICLES = int(random(250,2500));
    smallPoint = int(random(1, 20));
    largePoint = int(random(20, 100));
  }

  if (choice == 1){
    pointillizeAmplitudeEllipse(MAX_PARTICLES);
    choiceText = "\"Pointillize Ellipse\"";
  }
  else if (choice == 2){
    pointillizeAmplitudeRect(MAX_PARTICLES);
    choiceText = "\"Pointillize Rect\"";
  }

  printBorderText();
  
}

void loadAstroImage() {
  int astroFileNumber = int (random(1, MAX_IMAGES + 1));
  while (img == loadImage("astro" + astroFileNumber + ".jpg")){
    astroFileNumber = int (random(1, MAX_IMAGES + 1));
  }
  img = loadImage("astro" + astroFileNumber + ".jpg");
}

void pointillizeAmplitudeEllipse(int max){
  for (int i = 0; i < max; i++){
    int x = int(random(img.width));
    int y = int(random(img.height));
    
    float pointillize = map((amp.analyze()*15), 0.0, 1.0, smallPoint, largePoint);

    color pix = img.get(x, y);
    noStroke();
    fill(pix, 128);
    tint(255, 120);  // Display at half opacity
    
    ellipse(x, y, pointillize, pointillize);
  }
}

void pointillizeAmplitudeRect(int max){
  for (int i = 0; i < max; i++){
    int x = int(random(img.width));
    int y = int(random(img.height));
    
    float pointillize = map((amp.analyze()*15), 0.0, 1.0, smallPoint, largePoint);

    color pix = img.get(x, y);
    noStroke();
    fill(pix, 128);
    tint(255, 120);  // Display at half opacity
    
    rect(x, y, pointillize, pointillize);
  }
}

void printBorderText(){
  strokeWeight(img.width/16);
  stroke(0);
  //noFill();
  tint(255);
  //rect(0,0,displayWidth, displayHeight);
  rect(0, displayHeight-30, displayWidth, 70);
  
  fill(255);
  textSize(30);
  text("BHA Maker Faire 2019: Acoustic Astronomy", 20, displayHeight-28);
  
  fill(100);
  textSize(16);
  text("Mike Poirier @ github.com/mvpoirier/", displayWidth-360, displayHeight-45);
  
  fill(100);
  textSize(16);
  text("Coded in Processing 3 (www.processing.org)", displayWidth-360, displayHeight-20);
}
