import processing.pdf.*;
import garciadelcastillo.dashedlines.*;
DashedLines dash;

int mode=0;
boolean midion=false;

int frame=0;
int notegrid=100; //tessitura + octava per baix + octava per dalt

float bars=4;
float bardiv=16; //cada compas es divideix en semicorxees

float sincounter1=0;
float sincounter2=0;
float counter=0;

int tema=0;
int rndseed=12;
int paleta=1;

int scale[]={0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
int selsc=5;

int [][] scales= new int[][]{
  {0, 1, 5, 7, 10}, //japanese
  {0, 3, 5, 7, 10}, //minpent
  {0, 2, 3, 7, 8}, //hirajoshi
  {0, 3, 6, 9}, //dim
  {0, 2, 4, 6, 8, 10}, //whole
  {0, 1, 4,5, 7, 10}, //arabian
  {0, 3, 7}, //minorchord
  {0, 3, 7, 11}, //minmaj
  {0, 4, 7, 11}, //M7
  {0, 3, 7, 10, 14}, //m9
  {0, 3, 7, 10}, //m7
  {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, //chromatic
  {0, 3, 5, 8, 10}, //mongolia
  {0,2,5,7,8}, //FORMS_Fa
  {0,2,3,5,7,8,11}, //FORMS_Fa_extended
  {0,2,3,5,7,8,10}, //eolian
  {0,2,3,5,7,9,10}, //dorian
  {0,2,4,5,7,9,11}, //ionian
  {0,4,7}, //majorChord
  {0, 4, 7, 11,14}, //M9
  {0,1,4,5,7,11} //arabian2
  
  
};


int ncol=5;

color customColour[]={
  #ffffff, // blanc
  #bf0000, // granate
  #ffcc00, // groc ataronjat
  #00139f, // blau mari
  #065535, //verd

};

color palette0[]={
  #ffffff, // blanc
  #bf0000, // granate
  #ff9700, //  taronja
  //#0051ff, // blau mari
  //#065535, //verd

};


color palette6[]={
  #FFECBF, // crema
  #ff9700, // taronja
  #7B318A, //purpura
  #ffffff, // blanc

};

color palette2[]={
  #f0e07d,
  #e1d8c7,
  #65b4bb,
  #e3ab46,
  #56432d,
};

color palette3[]={
  #f2f2f2,
  #ddf156,
  #078ca9,
  #53d1ec,
  #c5df16,
};

color palette1[]={
  #fac51c,
  #3b8beb,
  #ffa800,
  #1c77ac,
  #0f2862,
};

color palette5[]={
  #f0e9bf,
  #7e7e74,
  #f06b6b,
  #c34040,
  #d89959,
};

color palette4[]={
  #ffffff,
  #ffffff,
  #ffffff,
  #ffffff,
  #ffffff,
};

color palette7[]={ //brossa
  #ffde8a,
  #ffbf1c,
  #ff8000,
  #ff4000,
  #ff0000,
};

color palette8[]={ //whitered
  #ffffff,
  #ffffff,
  #ffffff,
  #ff0000,
  #ff0000,

};

color palette9[]={ //whiteredcyan
  #ffffff,
  #ffffff,
  #00ffff,
  #ff0000,
  #ff0000,

};

color palette10[]={ //whiteyellow
  #ffffff,
  #ffffff,
  #ffc000,
  #ffc000,
  #ffc000,

};

color palette11[]={ //whiteblue
  #ffffff,
  #ffffff,
  #0080ff,
  #005eff,
  #005eff,

};

color palette12[]={ //whitegreen
  #ffffff,
  #ffffff,
  #00de3b,
  #00de3b,
  #00de3b,

};

color palette13[]={ //whitepink
  #ffffff,
  #ffffff,
  #fc036b,
  #fc036b,
  #fc036b

};

color palette14[]={ //whiteorange
  #ffffff,
  #ffffff,
  #ff8000,
  #ff8000,
  #ff8000

};

import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

PRNG prng = new PRNG();

String[] layer1Array=new String[20];
int layer1Size=3;
String layer1;
boolean listlayer1full=false;

String[] layer2Array=new String[20];
int layer2Size=3;
String layer2;
boolean listlayer2full=false;

String[] layer3Array=new String[20];
int layer3Size=3;
String layer3;
boolean listlayer3full=false;

String[] fx1Array=new String[20];
int fx1Size=3;
String fx1;
boolean listfx1full=false;

String[] fx2Array=new String[20];
int fx2Size=3;
String fx2;
boolean listfx2full=false;

String[] fx3Array=new String[20];
int fx3Size=3;
String fx3;
boolean listfx3full=false;

int[] rootList=new int[20];
int rootListSize=3;
int thisRoot;

int[] transposeList=new int[20];
int transposeListSize=3;
int thisTranspose;

/////////////////////////////////////////


void setup() {
  dash = new DashedLines(this);
  size(1920, 1080); //setup our stage/canvas
  oscP5 = new OscP5(this, 12346); //per a rebre
  myRemoteLocation = new NetAddress("127.0.0.1", 11511); //per a enviar
  randomizepalette();
  surface.setVisible(false);
  noLoop();
  //server = new SyphonServer(this, "Processing Syphon");
}


//////////////////////////////////////

void draw() {
  background(0);
  selectscale(selsc);
  selectpalette(paleta);
  stroke(255);
  strokeWeight(1);


if(listlayer3full){
  for(int i=0; i<layer3Size;i++){
    layer3=layer3Array[i];
    method(layer3);
   }
 }

if(listfx3full){
  for(int i=0; i<fx3Size;i++){
    fx3=fx3Array[i];
    method(fx3);
   }
 }
 
if(listlayer2full){
  for(int i=0; i<layer2Size;i++){
    layer2=layer2Array[i];
    method(layer2);
   }
 }

if(listfx2full){
  for(int i=0; i<fx2Size;i++){
    fx2=fx2Array[i];
    method(fx2);
   }
 }

if(listlayer1full){
  for(int i=0; i<layer1Size;i++){
    layer1=layer1Array[i];
    method(layer1);
   }
 }

if(listfx1full){
  for(int i=0; i<fx1Size;i++){
    fx1=fx1Array[i];
    method(fx1);
   }
 }
 
  showgrid();

  int cnt=frameCount%9999;
  String filename=sketchPath("")+"pngs/"+cnt+".png";
  saveFrame(filename);

  OscMessage myMessage = new OscMessage("/file");
  myMessage.add(filename);
  oscP5.send(myMessage, myRemoteLocation);
}


/////////////////////////////////////////////

void none(){
}

void selectpalette(int pal) {


  if (pal==0) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette0[i%3];
    }
  }

  if (pal==1) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette1[i];
    }
  }

  if (pal==2) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette2[i];
    }
  }

  if (pal==5) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette3[i];
    }
  }

  if (pal==4) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette4[i];
    }
  }

  if (pal==3) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette5[i];
    }
  }

  if (pal==6) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette6[i%4];
    }
  }

  if (pal==7) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette7[i];
    }
  }

  if (pal==8) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette8[i];
    }
  }

  if (pal==9) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette9[i];
    }
  }

  if (pal==10) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette10[i];
    }
  }

  if (pal==11) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette11[i];
    }
  }

  if (pal==12) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette12[i];
    }
  }
  if (pal==13) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette13[i];
    }
  }
  
  if (pal==14) {
    for (int i=0; i<5; i++) {
      customColour[i]=palette14[i];
    }
  }
}

void randomizepalette() {

  int pale=int(random(7));
  selectpalette(pale);
}

void selectcolor() {
  int toggle =int(random(ncol));      //numero de colors
  fill(customColour[toggle]);
}

void selectstrokecolor() {
  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle]);
}

void selectallcolor() {
  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle]);
  fill(customColour[toggle]);
}

void showgrid() {

  float noteh=height/float(notegrid);

  if (keyPressed) {
    if (key=='1') {


      for (float i=0; i<width; i+=((width/bars)/4)) {  //beats
        strokeWeight(4);
        stroke(255, 0, 0, 50);
        line(i, 0, i, height);
      }

      for (float i=0; i<width; i+=((width/bars)/bardiv)) {  //16th
        strokeWeight(1);
        stroke(255, 0, 0, 50);
        line(i, 0, i, height);
      }
    }
    if (key=='2') {
      for (float i=0; i<height; i+=noteh) { //notes
        strokeWeight(1);
        stroke(255, 128);
        line(0, i, width, i);
      }

      for (float i=0; i<height; i+=noteh*12) { //octave
        strokeWeight(2);
        stroke(0, 255, 0);
        line(0, height-i, width, height-i);
      }
    }

    if (key=='3') {


      float step=0;
      float next=0;
      for (float i=0; i<notegrid; i++) {
        int pos=int((i%(scales[selsc].length)));
        float noteheight=height/float(notegrid);
        step=scale[pos];
        next=int((i/scales[selsc].length))*12;
        step=height-(((step+next)*noteheight));
        //println(i);
        stroke(0, 0, 255, 255);
        strokeWeight(2);
        line(0, step, width, step);
      }

      for (float i=0; i<height; i+=noteh*12) { //octave
        strokeWeight(2);
        stroke(0, 255, 0);
        line(0, height-i, width, height-i);
      }
    }
  }
}


void drawgrid() {
  for (float i=0; i<width; i+=width/bars) { //bars
    strokeWeight(8);
    stroke(255, 0, 0, 50);
    line(i, 0, i, height);
  }

  for (float i=0; i<width; i+=((width/bars)/4)) {  //beats
    strokeWeight(4);
    stroke(255, 0, 0, 50);
    line(i, 0, i, height);
  }

  for (float i=0; i<width; i+=((width/bars)/bardiv)) {  //16th
    strokeWeight(1);
    stroke(255, 0, 0, 50);
    line(i, 0, i, height);
  }

  for (float i=0; i<height; i+=height/float(notegrid)) { //notes
    strokeWeight(1);
    stroke(255, 50);
    line(0, i, width, i);
  }

  for (float i=0; i<height; i+=(height/float(notegrid))*12) { //octave
    strokeWeight(2);
    stroke(0, 255, 0);
    line(0, i, width, i);
  }

  float step=0;
  float next=0;

  for (float i=0; i<notegrid; i++) {
    int pos=int((i%(scales[selsc].length)));
    float noteheight=height/float(notegrid);
    step=scale[pos];
    next=int((i/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    //println(i);
    strokeWeight(1);
    stroke(0, 0, 255);
    line(0, step, width, step);
  }
}

void selectscale(int whichScale) {
  for (int i=0; i<scales[whichScale].length; i++) {
    scale[i]=scales[whichScale][i];
  }
}


void mousePressed()
{
  String filename=mode+"_"+frame+"_score.pdf";
  beginRecord(PDF, filename);
  redraw();
}

void keyPressed() {
  if (key=='s') {
    endRecord();
    //String filename=mode+"_"+frame+"_score.png";
    //saveFrame(filename);
    frame++;
  }
}
