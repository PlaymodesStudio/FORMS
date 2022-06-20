void brossa_cities() {
  strokeWeight(3);
  strokeCap(SQUARE);
  selectstrokecolor();
  selectcolor();
  float barsize=width/bars;
  float figure=width/bars;
  float nextfigure=figure;

  color a=customColour[int(random(ncol))];
  color b=customColour[int(random(ncol))];
  color c=customColour[int(random(ncol))];
  color d=customColour[int(random(ncol))];

  for (int i=0; i<width; i+=figure) {

    float[] figval={1, 2, 4, 8, 16};
    float selectedfig=figval[int(random(5))];
    nextfigure=barsize/selectedfig;

    float noteh=(height/float(notegrid));

    float note1a=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note2a=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note3a=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note4a=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note1b=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note2b=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note3b=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
    float note4b=height-((12*(int(random(4))+2)+(scale[int(random(scales[selsc].length))])))*noteh;

    if (random(100)<95) {
      note1b=note1a;
    }
    if (random(100)<95) {
      note2b=note2a;
    }
    if (random(100)<95) {
      note3b=note3a;
    }
    if (random(100)<95) {
      note4b=note4a;
    }

    int numlines=1;
    float val1a=0;
    float val2a=0;
    float val3a=0;
    float val4a=0;
    float val1b=0;
    float val2b=0;
    float val3b=0;
    float val4b=0;

    int chance=75;
    int chancedot=85;
    float[] figdash={4, 8};
    float selectedfigdash=figdash[int(random(2))];
    float[] dashpattern={barsize/selectedfigdash, barsize/selectedfigdash};
    int dashtrue=0;
    if (random(100)<25) {
      dashtrue=1;
    }

    if (random(100)<chance) {
      stroke(a);
      if (random(100)<chancedot) {
        if (dashtrue==1) {
          dashLine(i, note1a, i+nextfigure, note1b, dashpattern);
        } else {
          line(i, note1a, i+nextfigure, note1b);
        }
      } else {
        float[] figdot={4, 8, 16};
        float selectedfigdot=figdot[int(random(3))];
        dottedLine(i, note1a, i+nextfigure, note1b, selectedfigdot/selectedfig);
      }
      numlines++;
      val1a=note1a;
      val1b=note1b;
    } else {
      val1a=0;
      val1b=0;
    }

    if (random(100)<chance) {
      stroke(b);
      if (random(100)<chancedot) {
        if (dashtrue==1) {
          dashLine(i, note1a, i+nextfigure, note1b, dashpattern);
        } else {
          line(i, note2a, i+nextfigure, note2b);
        }
      } else {
        float[] figdot={4, 8, 16};
        float selectedfigdot=figdot[int(random(3))];
        dottedLine(i, note2a, i+nextfigure, note2b, selectedfigdot/selectedfig);
      }
      numlines++;
      val2a=note2a;
      val2b=note2b;
    } else {
      val2a=0;
      val2b=0;
    }

    if (random(100)<chance) {
      stroke(c);
      if (random(100)<chancedot) {
        if (dashtrue==1) {
          dashLine(i, note1a, i+nextfigure, note1b, dashpattern);
        } else {
          line(i, note3a, i+nextfigure, note3b);
        }
      } else {
        float[] figdot={4, 8, 16};
        float selectedfigdot=figdot[int(random(3))];
        dottedLine(i, note3a, i+nextfigure, note3b, selectedfigdot/selectedfig);
      }
      numlines++;
      val3a=note3a;
      val3b=note3b;
    } else {
      val3a=0;
      val3b=0;
    }

    if (random(100)<chance) {
      stroke(d);
      if (random(100)<chancedot) {
        if (dashtrue==1) {
          dashLine(i, note1a, i+nextfigure, note1b, dashpattern);
        } else {
          line(i, note4a, i+nextfigure, note4b);
        }
      } else {
        float[] figdot={4, 8, 16};
        float selectedfigdot=figdot[int(random(3))];
        dottedLine(i, note4a, i+nextfigure, note4b, selectedfigdot/selectedfig);
      }
      numlines++;
      val4a=note4a;
      val4b=note4b;
    } else {
      val4a=0;
      val4b=0;
    }

    int inda=0;
    float[] valuesa = new float[numlines];

    if (val1a>0) {
      valuesa[inda]=val1a;
      inda++;
    }
    if (val2a>0) {
      valuesa[inda]=val2a;
      inda++;
    }
    if (val3a>0) {
      valuesa[inda]=val3a;
      inda++;
    }
    if (val4a>0) {
      valuesa[inda]=val4a;
      inda++;
    }


    float[] numberza = new float[numlines-1];
    for (int k=0; k<numlines-1; k++) {
      numberza[k]=valuesa[k];
    }


    float maxvala = 0;
    float minvala = 0;
    if (numlines-1>0) {
      maxvala = max(numberza);
      minvala = min(numberza);
    }

    int indb=0;
    float[] valuesb = new float[numlines];
    if (val1b>0) {
      valuesb[indb]=val1b;
      indb++;
    }
    if (val2b>0) {
      valuesb[indb]=val2b;
      indb++;
    }
    if (val3b>0) {
      valuesb[indb]=val3b;
      indb++;
    }
    if (val4b>0) {
      valuesb[indb]=val4b;
      indb++;
    }

    float[] numberzb = new float[numlines-1];
    for (int k=0; k<numlines-1; k++) {
      numberzb[k]=valuesb[k];
    }


    float maxvalb = 0;
    float minvalb = 0;
    if (numlines-1>0) {
      maxvalb = max(numberzb);
      minvalb = min(numberzb);
    }


    noStroke();
    selectcolor();

    float w=barsize/32;
    rect(i+nextfigure-1, minvalb-1.5, w, maxvalb-minvalb+3);
    rect(i-1, minvala-1.5, w, maxvala-minvala+3);
    //spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
    //spectralblockb(i+nextfigure,minvalb,10,maxvalb-minvalb, 0.1, 0, 2,2);
    //spectralblockb(i,minvala,10,maxvala-minvala, 0.1, 0, 2,2);
    strokeWeight(3);
    figure=nextfigure;
  }
}

void harmonics2(float p, float barpos, float bardur, int mode, int partmode, int envmode, int maxparts) {
  float slower=16/bars;
  int toggle =int(random(ncol));
  float barsize=width/bars;
  stroke(255);
  strokeWeight(3);
  float f=p2f(p);
  float noteheight=height/float(notegrid);
  float partials=4+int(random(maxparts-4));
  float x0=0;
  float x1=0;
  for (int i=0; i<partials; i++) {
    float freqs=i*f;
    float pitches=f2p(freqs);
    float y=height-(pitches*noteheight);
    float maxlen=(bardur*barsize); //500 x width
    float minlen=10;
    float len=minlen+random(maxlen-minlen);

    switch(mode) {
    case 0:
      x0=0; //biggest
      x1=maxlen; //biggest
      break;

    case 1:
      x0=0; //align left
      x1=0+len; //align left
      break;

    case 2:
      x0=0+(maxlen/2)-(len/2); //center
      x1=0+(maxlen/2)+(len/2); //center
      break;

    case 3:
      x0=0+maxlen-len; //align right
      x1=0+maxlen; //align right
      break;

    case 4:
      x0=0+random(maxlen-len); //randomize
      x1=x0+len; //randomize
      break;
    }

    //line(x0,y,x1,y);
    boolean pinta=true;
    switch(partmode) {
    case 0: //tots
      pinta=true;
      break;

    case 1: //saw
      if (i%2==0) {
        pinta=true;
      } else {
        pinta=false;
      }
      break;

    case 2: //quad
      if (i%2==1) {
        pinta=true;
      } else {
        pinta=false;
      }
      break;

    case 3: //random
      pinta=boolean(int(random(2)));
      break;
    }
    int maxlfofreq=4;
    float lfofreq=int(random(maxlfofreq))/slower;
    //lfofreq=0;

    if (pinta) {
      for (float j=x0; j<x1; j++) {
        float ph=(j-x0)/(x1-x0);
        float lfo=((cos(ph*TWO_PI*lfofreq))+1)/2;
        float env=1;
        if (envmode==0) {
          env=pow(ph, 2);
        }
        if (envmode==1) {
          env=1-pow(ph, 2);
        }
        if (envmode==2) {
          env=1-(constrain(abs((((ph*2)-1))*1), 0, 1));
        }
        stroke(customColour[toggle], (env*lfo*255)/2);
        pushMatrix();
        translate(barpos*barsize, 0);
        point(j, y);
        point(j, y);
        popMatrix();
      }
    }
  }
}

void harmonics(int pitx, int mode, int partmode, int maxparts) {
  int toggle =int(random(ncol));
  stroke(customColour[toggle]);
  stroke(255);
  strokeWeight(1.9);
  float p=(12*int(random(2))*((int(random(2))*2)-1))+pitx; //-24 a +24
  float f=p2f(p);
  float noteheight=height/float(notegrid);
  float partials=4+int(random(maxparts-4));
  float x0=0;
  float x1=0;
  for (int i=0; i<partials; i++) {
    float freqs=i*f;
    float pitches=f2p(freqs);
    float y=height-(pitches*noteheight);
    float start=0;
    float maxlen=width-start; //500 x width
    float minlen=10;
    float len=minlen+random(maxlen-minlen);

    switch(mode) {
    case 0:
      x0=start; //biggest
      x1=maxlen; //biggest
      break;

    case 1:
      x0=start; //align left
      x1=start+len; //align left
      break;

    case 2:
      x0=start+(maxlen/2)-(len/2); //center
      x1=start+(maxlen/2)+(len/2); //center
      break;

    case 3:
      x0=start+maxlen-len; //align right
      x1=start+maxlen; //align right
      break;

    case 4:
      x0=start+random(maxlen-len); //randomize
      x1=x0+len; //randomize
      break;
    }

    //line(x0,y,x1,y);
    boolean pinta=true;
    switch(partmode) {
    case 0: //tots
      pinta=true;
      break;

    case 1: //saw
      if (i%2==0) {
        pinta=true;
      } else {
        pinta=false;
      }
      break;

    case 2: //quad
      if (i%2==1) {
        pinta=true;
      } else {
        pinta=false;
      }
      break;

    case 3: //random
      pinta=boolean(int(random(2)));
      break;
    }
    int maxlfofreq=4;
    float lfofreq=int(random(maxlfofreq));
    //lfofreq=0;

    if (pinta) {
      for (float j=x0; j<x1; j++) {
        int tr=transposeList[int(j/(width/bars))];
        tr=int(tr*noteheight);
        float ph=(j-x0)/(x1-x0);
        float lfo=((cos(ph*TWO_PI*lfofreq))+1)/2;
        float env=1-(constrain(abs((((ph*2)-1))*1), 0, 1));
        stroke(customColour[toggle], (env*lfo*255)/2);
        point(j, y-tr);
      }
    }
  }
}
