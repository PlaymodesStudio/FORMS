void microtonalHarm(int density, int maxstroke) {
  int toggle =int(random(ncol));
  float noteh=height/float(notegrid);
  float barsize=width/bars;
  for (int i=0; i<density; i++) {
    float mod=(random(4));
    float str=1+random(maxstroke);
    int x0=int(random(width));
    int x1=int(random(width));

    int p=scale[int(random(scales[selsc].length))];
    p=p+(12*int(random(9)));
    float y=height-(p*noteh);

    strokeWeight(1);
    int len=((x1-x0));

    for (float j=0; j<len; j++) {
      int tr=transposeList[int((x0+j)/barsize)];
      tr=int(tr*noteh);
      float ph=j/len;
      float env=j/len;
      env=1-(abs((env*2)-1));
      env=constrain(2*env, 0., 1.);
      ph=((cos(ph*TWO_PI*mod))+1)/2;
      stroke(customColour[toggle], env*(ph*255));
      line(x0+j, y-(str/2)-tr, x0+j, y+(str/2)-tr);
    }
  }
}

void arpeggiovibes2() {
  freezevibes(1);
  fill(0, 200);
  rect(0, 0, width, height);
  for (int i=0; i<bars; i++) {
    for (int j=0; j<5; j++) {
      int num=8*(1+int(random(4)));
      arpeggio(i, 1, num, 0.5+random(3), 1, 1+int(random(16)), 6, 0);//arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, int modulo)
    }
  }

  for (int i=0; i<bars; i++) {
    int trans[]={0, 5, 7};
    int tr=trans[int(random(trans.length))];
    transpose(i, 1, tr);//transpose(float barposx, int barw, float semitones)
  }
}

void pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo) {
  float slower=(16/bars);
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float posx=barpos*barsize;
  float posy=int(random(octaverange))*12*noteheight;
  float step=0;
  float next=0;
  bardur=barsize*bardur;
  float tempo=(barsize/bardiv)*divtempo;
  octaves=((int(random(octaves))+1)*scales[selsc].length)-(int(random(scales[selsc].length))-1);
  noStroke();
  selectcolor();
  float notestart=int(random(scales[selsc].length));
  for (float i=notestart; i<octaves+notestart; i+=2) {

    int pos=int(((i)%(scales[selsc].length)));
    step=scale[pos];
    next=int((i/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    step=step-(octavestart*12*noteheight);
    for (int k=0; k<bardur; k+=tempo) {
      int tr=transposeList[int((posx+k+(2*slower))/barsize)];
      tr=int(tr*noteheight);

      ellipse(posx+k+(2*slower), step+(noteheight/4)-posy-2-tr, 4*slower, 4);
    }
  }
}

void glissando(int bardur, int barstart) {
  float barsize=(width/bars);
  strokeWeight(1.5);
  selectstrokecolor();
  int mode=int(random(3));
  float w=(barsize*bardur);
  if (barsize*barstart>width) {
    w=barsize;
  }
  float h= int(random(height));
  float n=3+int(random(20));
  float maxoff=height/15;

  float x=(barstart*barsize);

  float offx=0;
  float offy=10+int(random(maxoff));
  float x1=x;
  float y1=int(random(height));
  float cx1=x1+random((w/2));
  float cy1=int(random(height));
  float x2=x+w;
  float y2=int(random(height));
  float cx2=x2-random(w/2);
  float cy2=int(random(height));

  noFill();
  for (int i=0; i<n; i++) {
    if (mode==0) {
      bezier(x1, y1, cx1, cy1, cx2+(offx*i), cy2+(offy*i), x2, y2);
    }
    if (mode==1) {
      bezier(x1, y1+(offy*i), cx1, cy1, cx2+(offx*i), cy2+(offy*i), x2, y2);
    }
    if (mode==2) {
      bezier(x1, y1, cx1, cy1, cx2+(offx*i), cy2+offy*i, x2, y2+(offy*i));
    }
    if (mode==3) {
      bezier(x1, y1+(offy*i), cx1, cy1, cx2+offx*i, cy2+(offy*i), x2, y2+(offy*i));
    }
  }
}

void strum3(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int modulo, int dir, int transpose) {
  float barsize=width/bars;
  octavestart=(octavestart*12);
  bardur=bardur*barsize;
  barstart=barstart*barsize;

  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int partialmode=int(random(4));
  float lfopow=random(1, 40);
  int partials=int(random(2, 20));
  int firstpartial=1;
  float detune=random(2);

  for (int i=0; i<numnotes; i++) {
    int index=i%modulo;
    switch(dir) {
    case 0:
      index=i%modulo; //UP
      break;
    case 1:
      index=modulo-(i%modulo); //DOWN
      break;
    case 2:
      index=abs((i%(modulo*2))-modulo); //DOWN UP
      break;
    case 3:
      index=modulo-(abs((i%(modulo*2))-modulo)); // UP DOWN
      break;
    }
    float pos=index*stepsize;
    float offset=random(rndmoff);
    int note=int((pos%(scales[selsc].length)));
    float octave=int((pos/scales[selsc].length))*12;
    float y=scale[note];
    y=octavestart+y+octave;
    float posx=i*(bardur/numnotes);
    float x=barstart+posx+offset;
    float partdet=0;
    //  //void note(float x,int p, float w,int partials, int partialmode, int firstpartial, float hicutpow,float locutpow,int ampshape,float ampow,int lfoshape,
    //float lfocycles, int lfohp, float lfopow, float tremamp, float tremcyc,float vibamp, float vibcyc, float detune, float vol){
    note(x, int(y)+transpose, notewidth, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void strum2(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int modulo, int dir, int strokew, float pw, int transpose) {
  int strokeColor=g.strokeColor;
  float barsize=width/bars;
  float noteheight=(height/float(notegrid));
  octavestart=(octavestart*12)*noteheight;
  bardur=bardur*barsize;
  barstart=barstart*barsize;
  transpose=int(transpose*noteheight);

  for (int i=0; i<numnotes; i++) {
    int index=i%modulo;
    switch(dir) {
    case 0:
      index=i%modulo; //UP
      break;
    case 1:
      index=modulo-(i%modulo); //DOWN
      break;
    case 2:
      index=abs((i%(modulo*2))-modulo); //DOWN UP
      break;
    case 3:
      index=modulo-(abs((i%(modulo*2))-modulo)); // UP DOWN
      break;
    }
    float pos=index*stepsize;
    float offset=random(rndmoff);
    int note=int((pos%(scales[selsc].length)));
    float octave=int((pos/scales[selsc].length))*12;
    float step=scale[note];
    step=height-(octavestart+transpose+((step+octave)*noteheight));
    strokeCap(ROUND);
    strokeWeight(noteheight/2);
    float posx=i*(bardur/numnotes);
    for (int j=0; j<notewidth; j++) {
      float ph=j/notewidth;
      ph=1-ph;
      ph=pow(ph, pw);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255);
      strokeWeight(strokew);
      point(barstart+posx+j+offset, step);
    }
  }
}

void strum(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int strokew, float pw, int transpose) {
  int strokeColor=g.strokeColor;
  float barsize=width/bars;
  float noteheight=(height/float(notegrid));
  octavestart=(octavestart*12)*noteheight;
  bardur=bardur*barsize;
  barstart=barstart*barsize;
  transpose=int(transpose*noteheight);

  for (int i=0; i<numnotes; i++) {
    float offset=random(rndmoff);
    float pos=i*stepsize; //i cap enrera?
    int note=int((pos%(scales[selsc].length)));
    float octave=int((pos/scales[selsc].length))*12;
    float step=scale[note];
    step=height-(octavestart+transpose+((step+octave)*noteheight));
    strokeCap(ROUND);
    strokeWeight(noteheight/2);
    float posx=i*(bardur/numnotes);

    for (int j=0; j<notewidth; j++) {
      float ph=j/notewidth;
      ph=1-ph;
      ph=pow(ph, pw);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255);
      strokeWeight(strokew);
      point(barstart+posx+j+offset, step);
    }
  }
}

void chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw, int transpose ) {
  strokeCap(PROJECT);
  float barsize=width/bars;
  float w=bardur*barsize;
  float posx=barstart*barsize;
  float noteheight=height/float(notegrid);
  int notestart =int(random(scales[selsc].length));
  float octavestart=noteheight*(12*octave);
  float h=(height/notegrid)/2;
  int strokeColor=g.strokeColor;


  for (int i=notestart; i<notestart+chordnum; i++) {
    float mod=int(random(8));
    int salt=int(random(2))+1;
    float note=((scale[(i*salt)%scales[selsc].length]+(int(i/12)*12)))*noteheight;
    //line(posx,height-(note+octavestart),posx+w,height-(note+octavestart));
    for (float j=0; j<w; j++) {

      float ph=j/w;
      float env=j/w;

      if (envmode==0) {
        env=1-(abs((env*2)-1));
        env=constrain(2*env, 0., 1.);
      }
      if (envmode==1) {
        env=(1-(j/w));
        env=pow(env, 2);
      }
      if (envmode==2) {
        env=(1-(j/w));
        env=1-pow(env, 2);
      }
      if (envmode==3) {
        env=1;
      }

      ph=((cos(ph*TWO_PI*mod))+1)/2;

      int tr=transposeList[int((posx+j)/barsize)];
      tr=int(tr*noteheight);
      if (mode==0) {
        ph=pow(ph, pow);
        ph=env*(0.2+(ph*0.8));
        strokeWeight(strokw);
        stroke(red(strokeColor), green(strokeColor), blue(strokeColor), env*(ph*255));
        line(posx+j, height-(note+octavestart)-(strokew/2)-tr, posx+j, height-(note+octavestart)+strokew-(strokew/2)-tr);
      }

      if (mode==1) {

        ph=pow(ph, pow);
        ph=env*(0.1+(ph*0.9));
        for (int t=0; t<int(ph*20); t++) {
          strokeWeight(strokw);
          stroke(red(strokeColor), green(strokeColor), blue(strokeColor));
          point(posx+j, (height-(note+octavestart)+random(strokew))-(strokew/2)-tr);
        }
      }

      if (mode==2) {

        ph=pow(ph, pow);
        ph=env*(0.2+(ph*0.8));
        strokeWeight(strokw);
        stroke(red(strokeColor), green(strokeColor), blue(strokeColor), env*(ph*255));
        for (int t=0; t<int(ph*20); t++) {
          point(posx+j, (height-(note+octavestart))-tr);
        }
      }
    }
  }
}

void chord2(int mode, float barstart, float bardur, float pow, int transpose) {
  float barsize=width/bars;
  float w=bardur*barsize;
  float posx=barstart*barsize;
  float noteheight=height/float(notegrid);
  int notestart =int(random(scales[selsc].length));
  float octavestart=noteheight*(12*(int(random(4))+1));
  float chordnum=3+int(random(4));
  float h=(height/notegrid)/2;
  int toggle =int(random(ncol));
  strokeWeight(3);
  //println(w);
  selectstrokecolor();
  for (int i=notestart; i<notestart+chordnum; i++) {
    float mod=int(random(8));
    int salt=int(random(2))+1;
    float note=((scale[(i*salt)%scales[selsc].length]+(int(i/12)*12)))*noteheight;
    //line(posx,height-(note+octavestart),posx+w,height-(note+octavestart));
    for (float j=0; j<w; j++) {

      int tr=transposeList[int((posx+j)/barsize)];
      tr=int(tr*noteheight);

      strokeWeight(1);
      float ph=j/w;
      float env=j/w;
      env=1-(abs((env*2)-1));
      env=constrain(2*env, 0., 1.);
      ph=((cos(ph*TWO_PI*mod))+1)/2;


      if (mode==0) {
        ph=pow(ph, pow);
        ph=env*(0.2+(ph*0.8));
        stroke(customColour[toggle], env*(ph*255));
        line(posx+j, height-(note+octavestart)-(h/2)-tr, posx+j, height-(note+octavestart)+h-(h/2)-tr);
      }

      if (mode==1) {

        ph=pow(ph, pow);
        ph=env*(0.1+(ph*0.9));
        for (int t=0; t<int(ph*20); t++) {
          point(posx+j, (height-(note+octavestart)+random(h))-(h/2)-tr);
        }
      }

      if (mode==2) {

        ph=pow(ph, pow);
        ph=env*(0.2+(ph*0.8));
        stroke(customColour[toggle], env*(ph*255));
        for (int t=0; t<int(ph*20); t++) {
          point(posx+j, (height-(note+octavestart))-tr);
        }
      }
    }
  }
}
void chord(int mode) {
  float barsize=width/bars;
  float w=(barsize*((int(random(4)))+1))/((int(random(4)))+1);
  float posx=(((barsize/bardiv)*8)*int(random(width/((barsize/bardiv)*8))));
  float noteheight=height/float(notegrid);
  int notestart =int(random(scales[selsc].length));
  float octavestart=noteheight*(12*(int(random(4))+1));
  float chordnum=3+int(random(5));
  float h=(height/notegrid)/2;
  int toggle =int(random(ncol));
  strokeWeight(3);
  //println(w);
  selectstrokecolor();
  for (int i=notestart; i<notestart+chordnum; i++) {
    float mod=int(random(8));
    int salt=int(random(2))+1;
    float note=(scale[(i*salt)%scales[selsc].length]+(int(i/12)*12))*noteheight;
    //line(posx,height-(note+octavestart),posx+w,height-(note+octavestart));
    for (float j=0; j<w; j++) {

      int tr=transposeList[int((posx+j)/barsize)];
      tr=int(tr*noteheight);

      strokeWeight(1);
      float ph=j/w;
      float env=j/w;
      env=1-(abs((env*2)-1));
      env=constrain(2*env, 0., 1.);
      ph=((cos(ph*TWO_PI*mod))+1)/2;


      if (mode==0) {
        ph=pow(ph, 2);
        ph=env*(0.2+(ph*0.8));
        stroke(customColour[toggle], env*(ph*255));
        line(posx+j, height-(note+octavestart)-(h/2)-tr, posx+j, height-(note+octavestart)+h-(h/2)-tr);
      }

      if (mode==1) {

        ph=pow(ph, 4);
        ph=env*(0.1+(ph*0.9));
        for (int t=0; t<int(ph*20); t++) {
          point(posx+j, (height-(note+octavestart)+random(h))-(h/2)-tr);
        }
      }

      if (mode==2) {

        ph=pow(ph, 2);
        ph=env*(0.2+(ph*0.8));
        stroke(customColour[toggle], env*(ph*255));
        for (int t=0; t<int(ph*20); t++) {
          point(posx+j, (height-(note+octavestart))-tr);
        }
      }
    }
  }
}

void tremolo(float x, float y, float x2, float y2) {
  float noteh=(height/float(notegrid));
  float barsize=width/bars;
  float w=barsize/16;
  int count=0;
  float ydist=y2-y;
  float ydistw=ydist/((x2-x)/w);
  noFill();

  beginShape();
  for (float i=x; i<x2; i+=w) {
    float ph=(i-x)/(x2-x);
    count++;
    if (count%2==0) {
      vertex(i, y+(ydist*ph));
      vertex(i+w, y+(ydist*ph)+ydistw);
      vertex(i+w, y+noteh+(ydist*ph)+ydistw);
    } else {
      vertex(i, y+noteh+(ydist*ph));
      vertex(i+w, y+noteh+(ydist*ph)+ydistw);
      //vertex(i+w,y+(ydist*ph)+ydistw);
    }
  }
  endShape(OPEN);
}

void xenakis2(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid) {

  //int strokeColor=g.strokeColor;
  selectstrokecolor();
  strokeWeight(3);
  noFill();
  float barsize=width/bars;
  float w=bardur*barsize;
  float noteheight=height/float(notegrid);

  float[] heights = new float[numlines];
  float[] heights0 = new float[numlines];
  float posy0;
  float posy1;


  int inc=(int(random(maxstep))+minstep);
  float inc2=1;

  int startnote=int(random(scales[selsc].length));


  for (int i=0; i<numlines; i++) {

    if (mode==0) {
      float octave=int(random(octaverange))*12;
      float starty=(octavestart*12)*noteheight;
      float note=octave+scale[int(random(scales[selsc].length))];
      heights0[i]=height-((noteheight*note)+starty);
      heights[i]=height-((noteheight*note)+starty);
    }
    if (mode==1) {
      float octstarty=(octavestart*12)*noteheight;
      float octave=int((startnote+(i*inc))/(scales[selsc].length))*12*noteheight;
      float note=scale[(startnote+(i*inc))%(scales[selsc].length)]*noteheight;
      heights0[i]=height-(octstarty+note+octave);
      heights[i]=height-(octstarty+note+octave);
    }
  }

  int incmode=int(random(2));


  for (float j=0; j<barnum; j+=inc2) {
    if (incmode==1) {
      float figs[]={0.25, 0.5, 1};
      inc2=figs[int(random(figs.length))];
    } else {
      inc2=1;
    }

    inc=(int(random(maxstep))+minstep);
    int rectmode=int(random(2));

    for (int i=0; i<numlines; i++) {
      posy0=heights0[i];
      float octave=int(random(octaverange))*12;
      float starty=(octavestart*12)*noteheight;
      float note=octave+scale[int(random(scales[selsc].length))];
      if (rectmode==0) {
        posy1=heights0[i];
      } else {
        posy1=height-((noteheight*note)+starty);
        heights[i]=posy1;
      }
      //portamento(w*j,posy0,w*(j+1),posy1,sigmoid,0);
      //bezier(w*j, posy0, (w*j)+(w*sigmoid), posy0, (w*(j+inc2))-(w*sigmoid), posy1, w*(j+inc2), posy1);
      float x1=w*j;
      float y1=posy0;
      float x2=(w*(j+inc2))-(w*sigmoid);
      float y2=posy1;
      if (random(100)<100) {
        if (random(100)<30) {
          if (random(100)<50) {
            float nums[]={4, 8, 12, 16};
            float dotnum=nums[int(random(nums.length))];
            dottedLine(x1, y1, x2, y2, dotnum*inc2);
          } else {
            float[] figdash={8, 16, 32};
            float selectedfigdash1=figdash[int(random(figdash.length))];
            float selectedfigdash2=figdash[int(random(figdash.length))];
            dash.pattern(selectedfigdash1, selectedfigdash2);
            dash.line(x1, y1, x2, y2);
          }
        } else {
          if (random(100)<100) {
            line(x1, y1, x2, y2);
          } else {
            tremolo(x1, y1, x2, y2);
          }
        }
      } else {
      }
    }
    startnote=int(random(scales[selsc].length));
    for (int i=0; i<numlines; i++) {
      heights0[i]=heights[i];
    }
  }
}
void xenakis3(float[] incs, int[] sustain, int[] converge, int[] parallel, int[] pitch) {

  float noteh=height/float(notegrid);
  float y1=height-((12*(int(random(3))+3)+(scale[int(random(scales[selsc].length))])))*noteh;
  float y2=height-((12*(int(random(3))+3)+(scale[int(random(scales[selsc].length))])))*noteh;
  float x1=0;
  float x2=0;
  strokeWeight(3);

  for (int i=0; i<incs.length; i++) {
    if (sustain[i]==0) {
      if (converge[i]==0) { //si no convergeixen
        if (parallel[i]!=0) { //si son paral·leles
          y2=pitch[i]+(int(random(3))*12); //agafa pitch del array extern i transposa segons parallel i inde
          y2=height-(y2*noteh);
        } else {
          y2=height-((12*(int(random(3))+3)+(scale[int(random(scales[selsc].length))])))*noteh;
        }
      } else {
        y2=height-((12*4)*noteh);
      }
    }

    x2=x1+incs[i]; //posició final del segment
    if (random(100)<100) {//chance
      if ((random(100)<40)) { ////discontinu
        if (random(100)<50) {//punts
          float nums[]={4, 8, 12, 16};
          float dotnum=nums[int(random(nums.length))];
          dottedLine(x1, y1, x2, y2, dotnum);
        } else { //dashes
          float[] figdash={8, 16, 32};
          float selectedfigdash1=figdash[int(random(figdash.length))];
          float selectedfigdash2=figdash[int(random(figdash.length))];
          dash.pattern(selectedfigdash1, selectedfigdash2);
          dash.line(x1, y1, x2, y2);
        }
      } else { //continu
        if (random(100)<100) {
          line(x1, y1, x2, y2);
        } else { //tremolo
          tremolo(x1, y1, x2, y2);
        }
      }
    }

    y1=y2;
    x1=x2;
  }
}

void xenakis4(float[] incs, int[] sustain, int[] converge) {
  strokeWeight(3);
  float noteh=height/float(notegrid);
  float y1=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
  float y2=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
  float x1=0;
  float x2=0;

  for (int i=0; i<incs.length; i++) {
    if (sustain[i]==0) {
      if (converge[i]==0) { //chance de convergencia en una nota
        y2=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
      } else {
        y2=height-(12*3)*noteh;
      }
    }

    x2=x1+incs[i]; //posició final del segment
    if (random(100)<100) {//chance
      if ((random(100)<40)) { ////discontinu
        if (random(100)<50) {//punts
          float nums[]={4, 8, 12, 16};
          float dotnum=nums[int(random(nums.length))];
          dottedLine(x1, y1, x2, y2, dotnum);
        } else { //dashes
          float[] figdash={8, 16, 32};
          float selectedfigdash1=figdash[int(random(figdash.length))];
          float selectedfigdash2=figdash[int(random(figdash.length))];
          dash.pattern(selectedfigdash1, selectedfigdash2);
          dash.line(x1, y1, x2, y2);
        }
      } else { //continu
        if (random(100)<100) {
          line(x1, y1, x2, y2);
        } else { //tremolo
          tremolo(x1, y1, x2, y2);
        }
      }
    }

    y1=y2;
    x1=x2;
  }
}

void xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid) {

  int strokeColor=g.strokeColor;
  stroke(red(strokeColor), green(strokeColor), blue(strokeColor));
  strokeWeight(2);
  noFill();
  float barsize=width/bars;
  float w=bardur*barsize;
  float range=height;
  float noteheight=height/float(notegrid);

  float[] heights = new float[numlines];
  float[] heights0 = new float[numlines];
  float posy0;
  float posy1;


  int inc=(int(random(maxstep))+minstep);

  int startnote=int(random(scales[selsc].length));


  for (int i=0; i<numlines; i++) {
    if (mode==0) {
      float octave=int(random(octaverange))*12;
      float starty=(octavestart*12)*noteheight;
      float note=octave+scale[int(random(scales[selsc].length))];
      heights0[i]=height-((noteheight*note)+starty);
      heights[i]=height-((noteheight*note)+starty);
    }
    if (mode==1) {
      float octstarty=(octavestart*12)*noteheight;
      float octave=int((startnote+(i*inc))/(scales[selsc].length))*12*noteheight;
      float note=scale[(startnote+(i*inc))%(scales[selsc].length)]*noteheight;
      heights0[i]=height-(octstarty+note+octave);
      heights[i]=height-(octstarty+note+octave);
    }
  }


  for (float j=0; j<barnum; j++) {

    inc=(int(random(maxstep))+minstep);
    int rectmode=int(random(2));

    if (random(100)<25) {
      mode=0;
    } else {
      mode=1;
    }

    for (int i=0; i<numlines; i++) {
      if (mode==0) {
        posy0=heights0[i];
        float octave=int(random(octaverange))*12;
        float starty=(octavestart*12)*noteheight;
        float note=octave+scale[int(random(scales[selsc].length))];
        if (rectmode==0) {
          posy1=heights0[i];
        } else {
          posy1=height-((noteheight*note)+starty);
          heights[i]=posy1;
        }
        //portamento(w*j,posy0,w*(j+1),posy1,sigmoid,0);
        bezier(w*j, posy0, (w*j)+(w*sigmoid), posy0, (w*(j+1))-(w*sigmoid), posy1, w*(j+1), posy1);
      }
      if (mode==1) {
        posy0=heights0[i];
        float octstarty=(octavestart*12)*noteheight;
        float octave=int((startnote+(i*inc))/(scales[selsc].length))*12*noteheight;
        float note=scale[(startnote+(i*inc))%(scales[selsc].length)]*noteheight;
        if (rectmode==0) {
          posy1=heights0[i];
        } else {
          posy1=height-(octstarty+note+octave);
          heights[i]=posy1;
        }
        //portamento(w*j,posy0,w*(j+1),posy1,sigmoid,0);
        bezier(w*j, posy0, (w*j)+(w*sigmoid), posy0, (w*(j+1))-(w*sigmoid), posy1, w*(j+1), posy1);
      }
    }
    startnote=int(random(scales[selsc].length));
    for (int i=0; i<numlines; i++) {
      heights0[i]=heights[i];
    }
  }
}

void portaseq(float barstart, float w, int octavestart, int octaverange, int num, float t, float vib) {

  int toggle =int(random(ncol));
  stroke(customColour[toggle]);
  float barsize=width/bars;
  barstart=barstart*barsize;
  float noteheight=height/float(notegrid);
  float notewidth=(barsize/bardiv)*w;

  PVector[] coordinates;
  coordinates=new PVector[num+20];
  float x=0;
  float y=0;
  int note=0;
  int step=0;
  for (int i=0; i<num+2; i+=2) {
    if (i==0) {
      x=0;
    } else {
      x=x+notewidth*2;
    }
    //note=scale[int(random(scales[selsc].length))];
    step=abs((step+(int(random(3))-1)))%scales[selsc].length;
    note=scale[step];
    x=x+((notewidth*(1+int(random(3)))*(1+int(random(2))))/(1+int(random(2))));
    int tr=transposeList[constrain(int(x/barsize), 1, transposeList.length)];
    float ystart=(12*noteheight)*octavestart;
    y=height-(ystart+((note+tr+(int(random(octaverange))*12))*noteheight));
    coordinates[i]=new PVector(x, y);
    coordinates[i+1]=new PVector(x, y);
  }
  for (int j=0; j<num; j++) {

    portamento(barstart+coordinates[j].x, coordinates[j].y, barstart+coordinates[j+1].x, coordinates[j+1].y, t, vib, 0, 0);
    //portamento(coordinates[j].x,coordinates[j].y+noteheight*3,coordinates[j+1].x,coordinates[j+1].y+noteheight*3,t);
  }
}

void portamento(float x0, float y0, float x1, float y1, float tens, float vib, float perlinfreq, float perlinampinsemitones) {
  float noteheight=height/float(notegrid);
  float distX = x1 - x0;
  float distY = y1 - y0;
  float pointnum=distX;
  float noisey=random(1000);
  float noisey2=random(100);
  noFill();
  beginShape();
  for (float i=0; i<pointnum; i++) {
    float ph=i/pointnum;
    float perl=noise((ph*perlinfreq)+noisey, noisey2);
    perl=((perl*2)-1)*(perlinampinsemitones*noteheight);
    float sinamp=(1+sin(ph*4))/2;
    float sinus=(sin(ph*48)*sinamp)*(noteheight/2);
    float x=x0+(ph*distX);
    float y=(sinus*vib)+y0+(sigmoid(ph, tens)*distY)+perl;
    vertex(x, y);
  }
  endShape();
}

void additive3(float p, float x, float w, float partials, int partmode, int envmode, float detune, float pow) {
  int strokeColor=g.strokeColor;
  strokeCap(ROUND);
  strokeWeight(2);
  float f=p2f(p);
  float noteheight=height/float(notegrid);
  float x0=x;
  float x1=x0+w;
  for (int i=0; i<partials; i++) {
    float phi=i/partials;
    float freqs=i*f;
    float pitches=f2p(freqs);
    float y=height-(pitches*noteheight);
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

    if (pinta) {
      for (float j=x0; j<x1; j++) {
        float ph=1-((j-x0)/(x1-x0));
        if (envmode==1) {//saw
          ph=pow(ph, pow);
        }
        if (envmode==3) {//inv saw
          ph=1-ph;
          ph=pow(ph, pow);
        }
        if (envmode==2) {//tri
          ph=1-(abs((ph*2)-1));
          ph=pow(ph, pow/2);
        }
        if (envmode==0) {//sq
          ph=1;
        }
        //stroke(customColour[toggle],(ph*255));
        stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255*(1-phi));
        point(j, y);
        point(j, y+detune);
        point(j, y-detune);
      }
    }
  }
}

void additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow) {
  int strokeColor=g.strokeColor;
  strokeCap(ROUND);
  strokeWeight(2);
  float barsize=width/bars;
  float notewidth=(barsize/bardiv);
  float f=p2f(p);
  float noteheight=height/float(notegrid);
  float w=notedur*notewidth;
  float x0=barpos*barsize;
  float x1=x0+w;
  for (int i=0; i<partials; i++) {
    float phi=i/partials;
    float freqs=i*f;
    float pitches=f2p(freqs);
    float y=height-(pitches*noteheight);
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

    if (pinta) {
      for (float j=x0; j<x1; j++) {
        float ph=1-((j-x0)/(x1-x0));
        if (envmode==1) {//saw
          ph=pow(ph, pow);
        }
        if (envmode==3) {//inv saw
          ph=1-ph;
          ph=pow(ph, pow);
        }
        if (envmode==2) {//tri
          ph=1-(abs((ph*2)-1));
          ph=pow(ph, pow/2);
        }
        if (envmode==0) {//sq
          ph=1;
        }
        //stroke(customColour[toggle],(ph*255));
        stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255*(1-phi));
        point(j, y);
        point(j, y+detune);
        point(j, y-detune);
      }
    }
  }
}

void additive(float p, float barpos, float notedur, float partials, int partmode) {
  float slower=(16/bars);
  int strokeColor=g.strokeColor;
  strokeWeight(2);
  strokeCap(ROUND);
  float barsize=width/bars;
  float notewidth=(barsize/bardiv);
  float f=p2f(p);
  float noteheight=height/float(notegrid);
  float w=notedur*notewidth;
  float x0=barpos*barsize;
  float x1=x0+w;
  for (int i=0; i<partials; i++) {
    float freqs=i*f;
    float pitches=f2p(freqs);
    float y=height-(pitches*noteheight);
    float start=0;
    float maxlen=width-start; //500 x width
    float minlen=10;
    float len=minlen+random(maxlen-minlen);

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

    if (pinta) {
      for (float j=x0; j<x1; j++) {
        float ph=1-((j-x0)/(x1-x0));
        ph=pow(ph, 4);
        stroke(red(strokeColor), green(strokeColor), blue(strokeColor), (ph*255));
        point(j, y);
      }
    }
  }
}

void noteam(float barstart, float bardur, int note, float noisescale) {
  float barsize=width/bars;
  bardur=bardur*barsize;
  barstart=barstart*barsize;
  for (float i=note; i<note+1; i++) {
    int pos=int((i%(scales[selsc].length)));
    float noteheight=(height/float(notegrid));
    float step=scale[pos];
    float next=int((i/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    //println(i);
    strokeWeight(1);
    stroke(0, 0, 255);
    float off=random(width);
    for (int j=0; j<bardur; j++) {
      float noiseVal = 2*prng.perlin((i*width)+off+(j*noisescale), 1*noisescale);
      noiseVal=pow(noiseVal, 1);
      stroke(0, noiseVal*255);
      line(barstart+j, step-(noteheight/2), barstart+j, step+(noteheight/2));
    }
  }
}

void base(float barstart, float bardur, int note) {
  int toggle =int(random(ncol));
  float barsize=width/bars;
  bardur=bardur*barsize;
  barstart=barstart*barsize;
  for (float i=note; i<note+1; i++) {
    int pos=int((i%(scales[selsc].length)));
    float noteheight=(height/float(notegrid));
    float step=scale[pos];
    float next=int((i/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    //println(i);
    strokeWeight(noteheight-1);
    stroke(customColour[toggle]);
    line(barstart, step, barstart+bardur, step);
  }
}

//////////////////////////////////////////////////////////////////////

void h1_theremin() {//theremin
  //t10_r2d2();
  //hole4(0, width, 4, 0);
  float strw=random(1, 4);
  strokeWeight(strw);
  portaseq(0, 4, 3, 3, 32, 0.9, random(1)); //portaseq(float barstart, float w, int octavestart, int octaverange, int num, float t, float vib)
  if (random(100)<50) {
    portaseq(0, 4, 3, 3, 32, 0.9, random(1));
  }
  //additive2(0, 0, bars*16, random(4, 12), 0, 2, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
}

void h2_iridescence() {//brwonian tonal pad
  int prob=int(random(8, 50));
  selectstrokecolor();
  float barsize=width/bars;
  int w=width;
  int strokew=1+int(random(6));
  int strokeColor2=g.strokeColor;
  float noiseran=1+random(10);
  float noiseScale = 0.02/noiseran;
  float ran=random(200000);
  float power=6+int(random(10));
  float step=0;
  float next=0;
  for (float y=0; y<notegrid; y++) {
    int pos=int((y%(scales[selsc].length)));
    float noteheight=height/float(notegrid);
    step=scale[pos];
    next=int((y/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    if (random(100)<prob) { //nomes pintem algunes notes
      for (int x=0; x<w; x++) {
        int tr=transposeList[int(x/barsize)];
        tr=int(tr*noteheight);
        float env=float(x)/w;
        env=1-(abs((env*2)-1));
        env=constrain(2*env, 0., 1.);
        env=pow(env, 2);
        float noiseVal2 = prng.perlin(((y*100)+x*noiseScale), ran*noiseScale);
        noiseVal2=pow(noiseVal2*1.5, power);
        stroke(red(strokeColor2), green(strokeColor2), blue(strokeColor2), noiseVal2*255*env);
        //stroke(255,noiseVal2*255*env);
        strokeWeight(strokew);
        point(x, step-tr);
      }
    }
  }
  selectstrokecolor();
}

void h3_AM() {//vacquie pad
  int prob=int(random(4, 33));
  float slower=(16/bars);
  strokeCap(SQUARE);
  float w=width;
  float x=0;
  float h=2;
  selectstrokecolor();

  for (float y=0; y<notegrid; y++) {
    h=1+random(3);
    int pos=int((y%(scales[selsc].length)));
    float noteheight=height/float(notegrid);
    float step=scale[pos];
    int next=int((y/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    float maxfreq=random(8, 24);
    float noiseScale=random(0.001, 0.004)/slower;
    int ran=int(random(200000));
    //noiseScale=0.001;
    //maxfreq=20;
    //ran=23;
    if (random(100)<prob) {

      brownianblock(x, step, w, h, noiseScale, maxfreq, ran, 2, int(random(2)));
    }
  }
  selectstrokecolor();
  if (random(100)<33) {
    additive2(0, 0, bars*16, random(8, 32), 0, 2, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }
}

void h4_partialDance() {//dancing partials

  harmonics(0, 4, 0, 36);
  harmonics(24, 4, 0, 24);
}

void h5_partialMelodies() { //partial melodies

  float inc=1;
  float count=0;
  for (float i=0; i<bars*2; i+=inc) {
    int oct=12*(int(random(4)));
    int tr=transposeList[int(i)];
    int p=scale[int(random(scales[selsc].length))]+oct+tr;
    if (random(100)<100) {
      harmonics2(p, i, 4, 1, 1, 1, 16);//harmonics2(float p, float barpos, float bardur, int mode, int partmode, int envmode,int maxparts)
    }
    count+=inc;
    float raninc[]={0.125, 0.25, 0.5, 1};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }
}

void h6_clouds() { //tonal perlin clouds
  selectcolor();
  perlin(0.4, 1);
  if (random(100)<50) {
    selectcolor();
    perlin(0.4, 1);
  }
  vignette(4);
  hole4(0, width, 4, 0);
  additive2(0, 0, bars*16, random(8, 32), 0, 2, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
}

void h7_arpeggios() {  //arpeggio
  selectstrokecolor();
  int reps=int(random(1, 12));
  for (int i=0; i<bars; i++) {
    int tr=transposeList[int(i)];
    float probgrad=float(i)/bars;
    probgrad=1-(abs((probgrad*2)-1));
    for (float j=0; j<(reps*probgrad)+1; j++) {
      int num=2*(1+int(random(4)))*(1+int(random(2)));
      //if(random(100)<probgrad*300){
      arpeggio(i, 1, num, 0.5+random(3), 3, 1+int(random(16)), int(random(6)), tr);//arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, int modulo)
      //}
    }
  }

  selectstrokecolor();
  for (int i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    additive(p, i, 32, int(random(2, 8)), 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }
}

void h8_xenakis() { //xenakis

  stroke(255);
  float sigm=int(random(2))*0.5;
  xenakis(1, int(random(6, 12)), 1, bars, 2, 2+int(random(2)), 2, 0, sigm);
  //xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid){
}

void h9_electro() {//electro
  float slower=(16/bars);
  stroke(255);
  int seed=int(random(1000));
  int steps=3+int(random(14));
  int partiels=4+int(random(12));
  for (int j=0; j<bars; j++) {
    int p=0;
    int rt=rootList[int(j)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(j)];
    p=p+rt+tr;

    for (int i=0; i<steps; i++) {
      int eval=randomfills(i, steps, seed);
      if ((eval==1)) {
        additive(p, j+(i*0.0625), 2, partiels, 2); //additive(float p, float barpos, float notedur, float partials, int partmode)
      }
    }
  }

  selectstrokecolor();
  float div[]={8, 16};
  float tempo=div[int(random(div.length))];
  float randindex[]={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  for (int i=0; i<bars; i++) {
    randindex[i]=int(random(2));
  }

  for (float i=0; i<bars; i+=1/tempo) { //additive melody
    float part=int(random(4, 12));
    int posscale=int(random(scales[selsc].length));
    posscale=0;
    int octave=12*(1+int(random(4)));
    int index=int(i);
    int tr=transposeList[int(i)];
    if (randindex[index]==1) {
      if (random(100)<50) {
        additive(posscale+octave+tr, i, 1, part, 2); //additive(float p, float barpos, float notedur, float partials, int partmode)
      }
    }
  }

  //chords

  int toggle =int(random(ncol));
  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    if (random(100)<66) {
      chord3(0, 3, i, 2, 0, 1, 2+int(random(2)), 3, 1, tr);//chord3(int mode, float chordnum, float barstart, float bardur, float pow, float w, float octave, int envmode)
    }
  }

  //sub

  selectstrokecolor();
  for (int i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<50) {
      additive2(p, i, bardiv, random(8, 32), 0, 2, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
    }
  }
}

void h10_bells() {//tonal bells
  r5_bells();
  hole4(0, width, 4, 0);
  selectstrokecolor();

  //saw bass
  for (int i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<50) {
      additive(p, i, 32, int(random(6, 12)), 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
    }
  }

  //sub short
  selectstrokecolor();
  stroke(255);
  if (random(100)<50) {
    for (float i=0; i<bars; i++) {
      int p=0;
      int rt=rootList[int(i)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i)];
      p=p+rt+tr;

      if (random(100)<50) {
        additive2(p, i+0.75+0.125, 2, random(8, 32), 0, 0, random(5), 2);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow) {
      }
    }
  }
}

void h11_melodiesAndChords() { //melodies


  selectstrokecolor();
  int envmod=int(random(4));
  int lines=int(random(3));
  int chordenv=int(random(4));
  if (lines==0) {
    melody(int(random(2)), 0, envmod, int(bars), 0, 5, 2, int(random(8, bardiv)), 2, 2, int(random(1, 4))); //melody(int paintmode, int mode, int envmode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  }
  if (lines==1) {
    melody(int(random(2)), 1, envmod, int(bars), 0, 6, 3, int(random(8, bardiv)), 2, 2, int(random(1, 4))); //melody(int paintmode, int mode, int envmode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  }
  if (lines==2) {
    melody(int(random(2)), 0, envmod, int(bars), 0, 5, 2, int(random(8, bardiv)), 2, 2, int(random(1, 4))); //melody(int paintmode, int mode, int envmode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
    melody(int(random(2)), 1, envmod, int(bars), 0, 6, 3, int(random(8, bardiv)), 2, 2, int(random(1, 4))); //melody(int paintmode, int mode, int envmode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  }
  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    if (random(100)<66) {
      chord3(0, 3+int(random(3)), i, 2, 0, 1, 2+int(random(2)), chordenv, 6, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }
}

void h12_UKClub() { //ukbreaks
  float stepsize=(width/bars)/bardiv;

  //sincop chords
  selectstrokecolor();
  for (float i=0; i<bars; i+=1) { //additive monadic bass
    int tr=transposeList[int(i)];
    float speed=1*(1+(int(random(2))))*(1+(int(random(2))));
    int num=3+int(random(4));
    for (int j=0; j<round(5/speed); j++) {
      chord3(0, num, i+((0.1875*speed)*j), 0.1875*speed, 0, 4, 3+int(random(2)), 1, 1, tr);
    }
  }

  //electro bass
  selectstrokecolor();
  float div[]={8, 16};
  float tempo=div[int(random(div.length))];
  float randindex[]={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  for (int i=0; i<bars; i++) {
    randindex[i]=int(random(2));
  }
  for (float i=0; i<bars; i+=1/tempo) {
    float part=int(random(4, 20));
    int octave=12*(int(random(2)));
    int index=int(i);
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (randindex[index]==1) {
      if (random(100)<50) {
        additive(octave+p, i, 1, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
      }
    }
  }

  //baix cabezon
  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    additive(-12+p, i, 32, int(random(8, 24)), 1); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  //sub
  selectstrokecolor();
  stroke(255);
  strokeWeight(1);
  for (float i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<50) {
      additive2(p, i+0.75+0.125, 2, random(8, 32), 0, 0, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
    }
  }

  //reese
  selectstrokecolor();
  for (int i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<25) {
      additive2(p, i, bardiv, random(8, 32), 0, 2, 4, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
    }
  }
}

void h13_trance() { //bassline trancero
  float barsize=width/bars;
  fill(255, 255);
  selectcolor();
  if (random(100)<50) {
    perlin2(0.4, 0.4);
    vignette(4);
    hole4(0, width, 4, 0);
  }

  //electronic bassline
  stroke(255);
  float div[]={8, 12, 16};
  float tempo=div[int(random(div.length))];
  float randindex[]={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int partmode=int(random(2))*2;
  for (int i=0; i<bars; i++) {
    randindex[i]=int(random(2));
  }
  for (float i=0; i<bars; i+=1/tempo) {
    float part=int(random(4, 20));
    int octave=12*(int(random(2)));
    float probgrad=i/bars;
    probgrad=1-(abs((probgrad*2)-1));

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<100) {
      additive(octave+p, i, 1, part, partmode); //additive(float p, float barpos, float notedur, float partials, int partmode)
    }
  }
  //strum
  selectstrokecolor();
  for (int i=0; i<bars; i+=4) {
    if (random(100)<50) {
      int tr=transposeList[int(i)];
      float stepsize=1+((random(3))/2);
      float num=6+int(random(6));
      strum(i, random(0.125, 0.25), barsize*2, num, 12, stepsize, 2, 4, 12, tr);
    }
  }

  //reverse sub
  selectstrokecolor();
  stroke(255);
  if (random(100)<50) {
    for (float i=0; i<bars; i+=4) {
      int p=0;
      int rt=rootList[int(i)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i)];
      p=p+rt+tr;

      if (random(100)<50) {
        float det=random(5);
        additive2(p, i-2, 32, random(16, 32), 0, 3, det, 6);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow) {
        additive2(p, i-2, 32, random(16, 32), 0, 3, det, 6);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow) {
        additive2(p, i-2, 32, random(16, 32), 0, 3, det, 6);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow) {
      }
    }
  }

  //baix cabezon
  selectstrokecolor();
  if (random(100)<50) {
    for (float i=0; i<bars; i++) {
      int p=0;
      int rt=rootList[int(i)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i)];
      p=p+rt+tr;

      additive(p, i, 16, int(random(8, 12)), 2); //additive(float p, float barpos, float notedur, float partials, int partmode)
    }
  }
}

void h14_dubstep() {//dubstep
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  stroke(255);
  selectcolor();
  perlin2(0.4, 1);
  hole4(0, width, 4, 0);
  melody(0, 0, int(random(4)), int(bars), 0, 2, 2, int(random(8, bardiv)), 2, 2, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)


  for (int i=0; i<2; i++) {
    harmonics(12, 4, 0, 16);
  }
  for (float i=0; i<bars; i++) {
    freeze(i, 1);//freeze(barpos,barlen);
    gater(i, 1, 1, 1, 1, 3); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
  }

  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    int p=0+tr;
    additive2(p, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }

  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0, tr);//chord2(int mode, float barstart, float bardur)
  }

  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      singlegate(i+0.5, 0.5);
    }
  }
  if (random(100)<50) {
    pointchords(0.25+(1/8.), bars, 3, 2, 2, 8); ////pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
    pointchords(0.25, bars, 3, 3, 2, 8);
  }
  //harmonics(12,4,0,32);
  //harmonics(12,4,0,32);

  //arpeggio
  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    strum(i, 0.5, stepsize*12, 4, 0, 0.5+random(3), 2+int(random(2)), 8, 6, tr);//arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, int modulo)
    //strum(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int strokew, float pw){
  }

  //dotted square bass
  selectstrokecolor();
  float mult=int(random(2))+1;
  float num=2.66666*mult;
  for (float i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<10) {
      rectMode(CORNER);
      fill(0);
      noStroke();
      rect((i*barsize), 0, barsize, height);
      stroke(255);
      for (float j=0; j<num-1; j++) {
        additive2(p, i+(j/num), 8, random(16, 64), 2, 1, 2, 4*mult);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
      }
    }
  }

  //bass cabezon
  for (float i=0; i<bars; i++) {
    float part=1+int(random(2, 16));
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;
    additive(p, i, 16, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  //sub
  selectstrokecolor();
  stroke(255);
  for (float i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<50) {
      if (random(100)<50) {
        additive2(p, i+0.75+0.125, 2, random(8, 32), 0, 0, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
      } else {
        additive2(p, i+0.75, 4, random(8, 32), 0, 0, random(5), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
      }
    }
  }

  /*
  for (int i=0; i<bars; i++) {
   int trans[]={0, 1};
   int tr=trans[int(random(trans.length))];
   transpose(i, 1, tr);//transpose(float barposx, int barw, float semitones)
   }
   */
}

void h15_xenakisPoly() { //multixenakis
  for (int i=0; i<5; i++) {
    float sigm=int(random(2))*0.5;
    stroke(255);
    xenakis(0, int(random(5, 12)), 1, bars, 0.25, i+1, int(random(2))+1, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  }
}

void  h16_freeze() { //freeze
  //h6_clouds();
  //h17_eno();
  if (random(100)<50) {
    h14_dubstep();
  } else {
    h19_partialMelodies();
  }
  float inc=1;
  float count=0;
  int mode=int(random(2));
  mode=0;
  switch(mode) {

  case 0:

    for (float i=0; i<bars*2; i+=inc) {
      freeze(count, inc);//freeze(barpos,barlen);
      count+=inc;
      float raninc[]={0.25, 0.5, 1, 2};
      float ri=raninc[int(random(raninc.length))];
      inc=ri;
    }
    break;

  case 1:
    float periods[]={1, 2, 2.666666, 4, 5.3333, 8, 12, 16};
    float per=periods[int(random(periods.length))];
    freezevibes(per);


    break;
  }

  //hole4(0, width, 4, 0);
}

void h17_eno() {//enoesque
  atmosvibes2();
  cloud();
  vignette(4);
  resetcolors();
  for (float i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    freeze(i, 2);//freeze(barpos,barlen);
    float part=1+int(random(2, 16));
    float octave=12*int(random(2));
    gater(i, 2, 1, 1, int(random(2))+1, 3); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
    if (random(100)<33) {
      stroke(255);
      additive(octave+tr, i, 64, part, int(random(2))*2); //additive(float p, float barpos, float notedur, float partials, int partmode)
    }
  }
  resetcolors();
  if (random(100)<50) {
    melody(0, 0, int(random(4)), int(bars), 0, 4, 2, int(random(8, bardiv)), 2, 2, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  }
  resetcolors();
  if (random(100)<50) {
    melody(0, 1, int(random(4)), int(bars), 0, 6, 2, int(random(8, bardiv)), 2, 2, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  }
  resetcolors();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0, tr);//chord2(int mode, float barstart, float bardur)
  }
}

void h18_bach() { //bach arpegios
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  resetcolors();
  resetcolors();


  fill(255, 255);
  resetcolors();
  stroke(255);
  for (float i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<33) {

      //additive(0, i, 32, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
      additive2(p, i, 64, 4, 0, 2, 4, 8);
      additive2(p, i, 64, 4, 0, 2, 4, 8);
      additive2(p, i, 64, 4, 0, 2, 4, 8);
    }
    //additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }
  int strok=1+int(random(6));
  stroke(255);
  //resetcolors();
  for (int i=0; i<bars; i++) {
    int tr=transposeList[int(i)];
    float nums[]={2, 4, 8, 12, 16, 24, 32};
    float num=nums[int(random(nums.length))];
    //num=num/(int(random(2))+1);
    //arpeggio(i, 1, num, 1+random(1), 3, 4+int(random(4)), 6); //arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, int modulo, int detune)
    strum2(i, 1, (stepsize*64)/num, num, 0, 1+random(1), 3, 4+int(random(6)), int(random(4)), strok, 4, tr); //strum(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int modulo, int dir, int strokew, float pw) {
  }
  strok=1+int(random(6));
  //resetcolors();
  for (int i=0; i<bars; i++) {
    int tr=transposeList[int(i)];
    float nums[]={2, 4, 8, 12, 16, 24, 32};
    float num=nums[int(random(nums.length))];
    if (random(100)<33) {
      strum2(i, 1, (stepsize*64)/num, num, 0, 1+random(1), 2, 4+int(random(6)), int(random(4)), strok, 4, tr); //strum(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int modulo, int strokew, float pw) {
    }
  }

  selectstrokecolor();
  strok=1+int(random(6));
  for (float i=0; i<bars; i+=0.25) {
    int tr=transposeList[int(i)];
    float nums[]={32, 48, 64};
    float num=nums[int(random(nums.length))];
    num=num/4;
    if (random(100)<10) {
      strum2(i+0.75, 0.25, (stepsize*16)/num, num, 0, 1+random(1), 3, 8+int(random(8)), int(random(4)), strok, 4, tr); //strum(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int modulo, int strokew, float pw) {
    }
  }
}

void h19_partialMelodies() { //melodies parcials 2
  float slower=(16/bars);
  stroke(255);
  selectcolor();

  //merlodies random
  selectcolor();
  selectstrokecolor();
  float inc=1;
  float count=0;
  if (random(100)<100) {
    for (float i=0; i<bars*2; i+=inc) {
      float raninc[]={0.125, 0.25};
      float ri=raninc[int(random(raninc.length))];
      inc=ri;
      int oct=12*(int(random(4)));
      int tr=transposeList[int(i)];
      int p=scale[int(random(scales[selsc].length))]+oct+tr;
      if (random(100)<40) {
        harmonics2(p, i, inc*4*(int(random(2))+1), 1, int(random(4)), 1, 24);//harmonics2(float p, float barpos, float bardur, int mode, int partmode, int envmode,int maxparts)
      }
      count+=inc;
    }
  }

  //sub
  selectstrokecolor();
  for (float i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<25) {
      float parts=4+int(random(16));

      //additive(0, i, 32, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
      additive2(p, i, 64, parts, 0, 2, 1, 8);
      additive2(p, i, 64, parts, 0, 2, 1, 8);
      additive2(p, i, 64, parts, 0, 2, 1, 8);
    }
    //additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }

  selectstrokecolor();
  selectcolor();

  for (int i=0; i<bars; i+=2) {
    if (random(100)<33) {
      int tr=transposeList[int(i)];
      chord3(0, 3+int(random(3)), i, 2, 0, 1, 2+int(random(2)), 3, 3, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }



  //iridiscencies AM
  strokeCap(SQUARE);
  float w=width;
  float x=0;
  float h=1;
  selectstrokecolor();

  for (float y=0; y<notegrid; y++) {
    int pos=int((y%(scales[selsc].length)));
    float noteheight=height/float(notegrid);
    int tr=transposeList[0];
    float step=scale[pos];
    int next=int((y/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    float maxfreq=random(8, 24);
    float noiseScale=random(0.001, 0.004)/slower;
    int ran=int(random(200000));
    if (random(100)<10) {

      brownianblock(x, step, w, h, noiseScale, maxfreq, ran, 2, 0);
    }
  }
}

void harm20() { //repeat
  h19_partialMelodies();
  for (int i=0; i<bars; i+=1)
  {
    if (random(100)<50) {
      transpose(i, 2, 6*int(random(2)));//transpose(float barposx, int barw, float semitones)
    }
  }
  float inc=1;
  float count=0;
  for (float i=0; i<bars; i+=inc) {
    float sign=((i%2)*2)-1;
    float mult=int(random(2))+1;
    float divs[]={1, 2, 3, 4, 6, 8, 12, 16, 24};
    float temp=divs[int(random(divs.length))];
    float len[]={1, 2};
    float l=len[int(random(len.length))];
    beatRepeat2(count, inc, temp*l, 0.666, 12*sign*mult); //beatRepeat2(float barposx, float bardur, float num, float gate, float semitones)
    count+=inc;
    inc=l;
  }
  for (int i=0; i<bars; i++) {
    int sino=int(random(4));
    float len=0.5*(int(random(2))+1);
    if (sino==1) {
      freeze(i+len, len);//freeze(float barposx, float barlen)
    }
  }
}

void h21_dub() { //generic dub

  int mode=int(random(3));
  selectcolor();
  //perlin2(0.4, 0.4);
  //hole4(0, width, 2, 0);
  //vignette(4);
  selectcolor();
  harmonics(0, 2, 0, 32);
  selectcolor();
  melody(mode, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);
  selectcolor();
  for (float i=0; i<bars; i+=1) { //additive monadic bass
    float part=int(random(2, 16));
    float octave=12*int(random(2));

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    additive(p, i, 16, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }
  selectcolor();
  chord(mode);
  stroke(255);
  if (random(100)<25) {
    //portaseq(0, 4, 3, 2, 24, 0.85, 1); //portaseq(float barstart, float w, int octavestart, int octaverange, int num, float t, float vib)
  }
  selectcolor();
  for (int i=0; i<bars-2; i+=2) {
    int p=0;
    int tr=transposeList[int(i)];
    additive2(p+tr, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }
  selectcolor();
  pointchords(0.25, bars, 2, 3, 2, 8);
}

void h22_kangding() { //kangding

  gatevibes();
  selectcolor();
  selectstrokecolor();
  float div[]={8, 10.666666, 12, 16};
  float tempo=div[int(random(div.length))];
  if (random(100)<50) {
    for (float i=0; i<bars; i+=1/tempo) { //additive melody
      float part=int(random(4, 18));
      int octave=12*(int(random(2)));
      int tr=transposeList[int(i)];
      if (random(100)<100) {
        additive(octave+tr, i, 1, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
      }
    }
  }
  selectcolor();
  selectstrokecolor();
  for (float i=0; i<bars; i+=2) { //additive monadic bass
    float part=1+int(random(3, 8));
    float octave=12*int(random(2));
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;
    additive(p, i, 64, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }
}

void h23_wendy() { //wendy
  selectcolor();
  selectstrokecolor();
  perlin(0.4, 0.5);
  hole4(0, width, 2, 0);

  selectcolor();
  selectstrokecolor();
  for (float i=0; i<bars; i+=4) { //additive monadic bass
    float part=1+int(random(3, 18));
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<40) {
      additive2(p, i, 128, part, 0, 2, 6, 4); ////additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
      additive2(p, i, 128, part, 0, 2, 6, 4); //additive(float p, float barpos, float notedur, float partials, int partmode)
    }
  }
  vignette(4);
  for (int i=0; i<bars-2; i+=2) {
    int tr=transposeList[int(i)];
    int p=scale[int(random(scales[selsc].length))]+-12+tr;
    additive2(p, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }
  selectcolor();
  selectstrokecolor();
  for (float i=0; i<bars; i++) {
    int tr=transposeList[int(i)];
    int oct=12*(int(random(3))+2);
    int p=scale[int(random(scales[selsc].length))]+oct+tr;
    additive2(p, i, 32, 8, 1, 2, 6, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }
  selectcolor();
  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0, tr);//chord2(int mode, float barstart, float bardur)
  }

  selectcolor();
  selectstrokecolor();
  float inc=1;
  float count=0;
  for (float i=0; i<bars*2; i+=inc) {
    int tr=transposeList[int(i)];
    int oct=12*(int(random(4)));
    int p=scale[int(random(scales[selsc].length))]+oct+tr;
    harmonics2(p, i, 4, 1, 1, 1, 16);//harmonics2(float p, float barpos, float bardur, int mode, int partmode, int envmode,int maxparts)
    count+=inc;
    float raninc[]={0.125, 0.25, 0.5, 1};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }
}

void h24_bells2() { //bells2
  int inc=1;
  float inc2=1;
  int mode=int(random(3));
  int prob=int(random(10, 50));
  for (float j=0; j<width; j+=inc2) {
    float inclist[]={0.5, 1, 2, 4}; //6
    float selinc=inclist[int(random(inclist.length))];
    inc2=int((width/bars/8))*selinc;
    for (int i=0; i<height; i+=inc) {
      float pow=1+int(random(6));
      pow=1;
      inc=int(random(height/90, height/8));
      selectstrokecolor();
      if (random(100)<prob) {

        if (mode==0) {
          if (random(100)<50) {
            spectralblockx(j, i, inc2*(int(random(4))+1), inc, 0.0001*bars*random(1, 50), 1, random(3, 6), 3*pow);//xywh sc envmode pow
          } else {
            spectralblockb(j, i, inc2*(int(random(4))+1), inc, 0.0001*bars*random(1, 80), 1, random(3, 6), 6*pow);
          }
        }

        if (mode==1) {
          spectralblockx(j, i, inc2*(int(random(4))+1), inc, 0.0001*bars*random(1, 50), 1, random(3, 6), 3*pow);//xywh sc envmode pow
        }

        if (mode==2) {
          spectralblockb(j, i, inc2*(int(random(4))+1), inc, 0.0001*bars*random(1, 80), 1, random(3, 6), 6*pow);//xywh sc envmode pow
        }
      }
    }
  }
  hole4(0, width, 4, 0);
}

void h25_chords() { //chords


  selectstrokecolor();
  int envmod=int(random(4));
  int lines=int(random(3));
  int chordenv=int(random(4));
  int AM=int(random(2))*2;
  envmod=0;
  chordenv=0;

  chordenv=int(random(4));
  selectstrokecolor();
  for (float i=0; i<bars; i+=0.5) {
    int tr=transposeList[int(i)];
    if (random(100)<25) {
      chord3(envmod, 3+int(random(8)), i, 0.5, 0, AM, 4+int(random(2)), chordenv, 1, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }

  chordenv=int(random(4));
  selectstrokecolor();
  for (float i=0; i<bars; i++) {
    int tr=transposeList[int(i)];
    if (random(100)<25) {
      chord3(envmod, 3+int(random(8)), i, 1, AM, 1, 3+int(random(2)), chordenv, 1, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }


  chordenv=int(random(4));
  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    if (random(100)<25) {
      chord3(envmod, 3+int(random(4)), i, 2, AM, 1, 2+int(random(2)), chordenv, 4, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }

  chordenv=int(random(4));
  selectstrokecolor();
  for (int i=0; i<bars; i+=4) {
    int tr=transposeList[int(i)];
    if (random(100)<25) {
      chord3(envmod, 3+int(random(8)), i, 4, AM, 1, 2+int(random(2)), chordenv, 8, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }

  chordenv=int(random(4));
  selectstrokecolor();
  for (int i=0; i<bars; i+=8) {
    int tr=transposeList[int(i)];
    if (random(100)<25) {
      chord3(envmod, 2+int(random(2)), i, 8, AM, 1, 1+int(random(2)), chordenv, 8, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }

  chordenv=int(random(4));
  selectstrokecolor();
  for (int i=0; i<bars; i+=16) {
    int tr=transposeList[int(i)];
    if (random(100)<25) {
      chord3(envmod, int(random(2)), i, 16, AM, 1, int(random(2)), chordenv, 8, tr);//chord3(int mode, int chordnum, float barstart, float bardur, float pow, float strokew, float octave, int envmode, int strokw ){
    }
  }
}

void h26_clouds2() { //tonal perlin clouds
  selectcolor();
  perlin(0.4, 1);
  vignette(4);
  hole4(0, width, int(random(3))+1, int(random(50)));
}

void h27_reagge() {//reagge chords

  stroke(255);
  strokeWeight(1);
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;

  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=1;
  int partialmode1=int(random(3));
  int partialmode2=int(random(3));
  float ampow=random(2, 6);
  float lfopow=random(1, 10);
  int partials1=int(random(4, 12));
  int partials2=int(random(4, 12));
  float detune=random(3);
  float vol=1;

  for (float i=0; i<bars; i+=0.5) {
    float x=barsize*i;
    int num=int(random(3, 7));
    for (int j=0; j<num; j++) {
      int tr=transposeList[int(i)];
      int p=scale[int(random(scales[selsc].length))]+tr;
      int octave=int(random(3))*12;
      float partdet=0;
      note(x+(barsize*0.25)+(barsize*0.125), p+octave+12, barsize/4, partials1, partialmode1, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }

    num=int(random(3, 7));
    for (int j=0; j<num; j++) {
      int tr=transposeList[int(i)];
      int p=scale[int(random(scales[selsc].length))]+tr;
      int octave=int(random(3))*12;
      float partdet=0;
      note(x+(barsize*0.25), p+octave+24, barsize/4, partials2, partialmode2, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }
  }
}

void h28_brossaBrown() {
  strokeWeight(2);
  float amp=random(1, 3);
  brownamp(0.002*amp, random(1000000), random(1, 4), 8);
}

void h29_brossaXenakis() {
  //xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  float sigm=int(random(2))*0.5;
  sigm=0;
  stroke(255);
  xenakis2(0, 2+int(random(5)), 1, bars, 2, 3, 4, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  //xenakis2(0, 1, 1, bars, 2, 2, 4, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  //xenakis2(0, 1, 1, bars, 2, 2, 4, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  //xenakis2(0, 1, 1, bars, 2, 2, 4, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
}

void h30_brossaBranch() {
  noFill();
  strokeWeight(3);
  float prevy=0;
  float actualy=0;
  float prev2y=0;
  float actual2y=0;
  float prev3y=0;
  float actual3y=0;
  float prev4y=0;
  float actual4y=0;
  float tens=2;

  float noteh=(height/float(notegrid));
  float octavestart=3;
  float octaverange=2;
  float octave=int(random(octaverange))*12;
  float starty=(octavestart*12)*noteh;

  float barsize=width/bars;
  float periods[]={1, 2, 4};
  float per=periods[int(random(periods.length))];
  float inc=barsize/per;

  float peri=(int(random(2))+1)*(int(random(2))+1)*(int(random(2))+1);

  selectstrokecolor();

  color a=customColour[int(random(ncol))];
  color b=customColour[int(random(ncol))];
  color c=customColour[int(random(ncol))];
  color d=customColour[int(random(ncol))];

  for (float i=0; i<width; i+=inc) {
    per=periods[int(random(periods.length))];
    per=peri;
    inc=barsize/per;
    float ph=i/width;
    ph=1-(abs((ph*2)-1));
    ph=pow(ph, 2);
    int tr=transposeList[int(i/barsize)];
    octave=int(random(octaverange))*12*((int(random(2))*2)-1);
    float note1=(octave+(scale[int(random(scales[selsc].length))])*((1)))+tr;
    octave=int(random(octaverange))*12*((int(random(2))*2)-1);
    float note2=(octave+(scale[int(random(scales[selsc].length))])*((1)))+tr;
    octave=int(random(octaverange))*12*((int(random(2))*2)-1);
    float note3=(octave+(scale[int(random(scales[selsc].length))])*((1)))+tr;
    octave=int(random(octaverange))*12*((int(random(2))*2)-1);
    float note4=(octave+(scale[int(random(scales[selsc].length))])*((1)))+tr;

    if (random(100)<50) {
      actualy=note1*noteh;
      if (random(100)<ph*100) {
        if (random(100)<50) {
          actual2y=note2*noteh;
        }
      } else {
        actual2y=actualy;
      }
      if (random(100)<ph*100) {
        if (random(100)<50) {
          actual3y=note3*noteh;
        }
      } else {
        actual3y=actual2y;
      }
      if (random(100)<ph*100) {
        if (random(100)<50) {
          actual4y=note4*noteh;
        }
      } else {
        actual4y=actual3y;
      }
    }


    float posx1=i;
    float posy1=height-(prevy+starty);
    float pos2y1=height-(prev2y+starty);
    float pos3y1=height-(prev3y+starty);
    float pos4y1=height-(prev4y+starty);
    float posx2=i+inc;
    float posy2=height-(actualy+starty);
    float pos2y2=height-(actual2y+starty);
    float pos3y2=height-(actual3y+starty);
    float pos4y2=height-(actual4y+starty);
    stroke(a);
    bezier(posx1, posy1, posx1+(inc/tens), posy1, posx2-(inc/tens), posy2, posx2, posy2);
    stroke(b);
    bezier(posx1, pos2y1, posx1+(inc/tens), pos2y1, posx2-(inc/tens), pos2y2, posx2, pos2y2);
    stroke(c);
    bezier(posx1, pos3y1, posx1+(inc/tens), pos3y1, posx2-(inc/tens), pos3y2, posx2, pos3y2);
    stroke(d);
    bezier(posx1, pos4y1, posx1+(inc/tens), pos4y1, posx2-(inc/tens), pos4y2, posx2, pos4y2);
    prevy=actualy;
    prev2y=actual2y;
    prev3y=actual3y;
    prev4y=actual4y;
  }
}

void h31_brossaXenakis2() {
  float figs[]={1, 0.5, 0.25};
  float barsize=width/bars;
  float incs[]=new float[200];
  for (int i=0; i<200; i++) {
    float fig=figs[int(random(figs.length))];
    incs[i]=barsize*fig;
  }

  int sustain[]=new int[200];
  for (int i=0; i<200; i++) {
    if (i%2==0) {
      sustain[i]=1;
    } else {
      sustain[i]=0;
    }
  }

  int converge[]=new int[200];
  for (int i=0; i<200; i++) {
    if (random(100)<25) {
      converge[i]=1;
    } else {
      converge[i]=0;
    }
  }

  //strokeWeight(3);
  noFill();
  int num=3+int(random(7));
  for (int i=0; i<num; i++) {
    selectstrokecolor();
    xenakis4(incs, sustain, converge);
  }
}

void h32_brossaXenakis3() {
  float figs[]={1, 0.5, 0.25};
  float barsize=width/bars;
  float incs[]=new float[64];
  for (int i=0; i<64; i++) {
    float fig=figs[int(random(figs.length))];
    incs[i]=barsize*fig;
  }

  int sustain[]=new int[64];
  for (int i=0; i<64; i++) {
    if (i%2==0) {
      sustain[i]=1;
    } else {
      sustain[i]=0;
    }
  }

  int converge[]=new int[64];
  for (int i=0; i<64; i++) {
    if (random(100)<25) {
      converge[i]=1;
    } else {
      converge[i]=0;
    }
  }

  int parallel[]=new int[64];
  for (int i=0; i<64; i++) {
    if (random(100)<50) {
      float v=scale[int(random(scales[selsc].length))];
      parallel[i]=int(v);
    } else {
      parallel[i]=0;
    }
  }

  int pitch[]=new int[64];
  for (int i=0; i<64; i++) {
    float v=scale[int(random(scales[selsc].length))]+(12*int(random(3))+1);
    pitch[i]=int(v);
  }

  //int[] parallel, int[] pitch, int[] instrumentindex
  int num=3+int(random(7));
  for (int i=0; i<num; i++) {
    selectstrokecolor();
    xenakis3(incs, sustain, converge, parallel, pitch);
  }
}

void h33_portamentoBass() {
  noFill();
  stroke(255, 0, 0);
  strokeWeight(2);
  float tens=random(0.9, 1);
  float noteh=height/float(notegrid);
  int detune=1+int(random(noteh/2));
  int partials=int(random(8, 16));

  for (float j=1; j<partials; j++) {
    float y0=height-(((scale[rootList[0]%scales[selsc].length])+transposeList[0])*noteh);
    float fade=j/partials;
    fade=pow(fade, 0.75);
    fade=255-(fade*255);
    stroke(255, fade);
    for (int i=0; i<bars+1; i++) {

      int p=0;
      int rt=rootList[int(i)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i)];
      p=p+rt+tr;

      float y1=height-(f2p((p2f(p)*j))*noteh);
      float x0=(i*(width/bars));
      float x1=(i*(width/bars))+(width/bars);
      portamento(x0-((width/bars)/2), y0+detune, x1-((width/bars)/2), y1+detune, tens, 0, 0, 0);
      portamento(x0-((width/bars)/2), y0, x1-((width/bars)/2), y1, tens, 0, 0, 0);
      portamento(x0-((width/bars)/2), y0-detune, x1-((width/bars)/2), y1-detune, tens, 0, 0, 0);
      //portamento(float x0, float y0, float x1, float y1, float tens, float vib, float perlinfreq, float perlinampinsemitones)
      y0=y1;
      //line(x0,0,x0,height);
    }
  }
}

void h34_filterBass() {
  float barsize=width/bars;
  float notewidth=(barsize/bardiv);
  //additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  //void spectralblock(float x, float y, float w, float h, float noisesc, int envmode, float power)
  float incs[]={0.0625, 0.0625, 0.0625, 0.125, 0.125, 0.25};
  float inc=incs[int(random(incs.length))];
  float dur=(barsize/notewidth)*inc;
  int envm=int(random(2));
  selectstrokecolor();
  strokeWeight(1);
  if (random(100)<90) {
    for (float i=0; i<bars; i+=inc) {

      int p=0;
      int rt=rootList[int(i)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i)];
      p=p+rt+tr;

      additive2(p, i, dur, int(random(120))+8, int(random(4)), int(random(2)), 0, 2);
    }
  }
  float fig=1/inc;
  float inc2=barsize/fig;
  stroke(0);
  for (int i=0; i<width; i+=inc2) {
    float sc=pow(random(100)/100, 4);
    sc=map(sc, 0., 1., 0.005, 0.05);
    spectralblockb(i, 0, inc2, height, sc, 0, 1, 1);
    spectralblockb(i, 0, inc2, height, sc, 0, 2, 2);
  }
  stroke(255);
}

void h35_filterBass2() {
  selectstrokecolor();
  strokeWeight(1);
  float barsize=width/bars;
  float notewidth=(barsize/bardiv);
  //additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  float incs[]={0.0625};
  float inc=incs[int(random(incs.length))];
  float dur=(barsize/notewidth)*inc;
  for (float i=0; i<bars; i+=inc) {

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    float numpart=random(100)/100.;
    numpart=pow(numpart, 4);
    if (random(100)<50) {
      if (random(100)<25) {
        fill(0);
        noStroke();
        rect(i*barsize, 0, barsize*inc, height);
      }
      additive2(p, i, dur, int((numpart*124))+4, int(random(4)), int(random(2)), random(3), 2);
    }
  }
}

void h36_centralBass() {
  float barsize=width/bars;
  int partials = 40;
  int partialmode=0;
  float locutpow=0;
  float detune=random(2);
  float tremamp=random(0, 0.1);
  float tremcyc=(int(random(4))+1);
  float vibamp=0;
  float vibcyc=8*(int(random(4))+1);

  partials=int(random(2, 80));
  partialmode=int(random(6));
  int firstpartial=1;
  detune=random(3);
  int tr=transposeList[int((width/2)/barsize)];
  int octave=int(random(2))*12;
  float partdet=0;
  stroke(255);
  note(0, 0+tr-octave, width, partials, partialmode, firstpartial, 2, locutpow, 2, 2, 2, 1, 0, 2, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, 1);
  //void note(float x,int p, float w,int partials, int partialmode, int firstpartial, float hicutpow,float locutpow,int ampshape,float ampow,int lfoshape,
}

void h37_randomNotes() {

  selectstrokecolor();
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int num=int(random(10, 40));


  for (int i=0; i<num; i++) {
    float chunk=(barsize/8);
    float x=int(random(width/chunk))*chunk;
    int partials=int(random(2, 80));
    int partialmode=int(random(6));
    float lfopow=random(2, 80);
    float w=(1+int(random(8)))*chunk;

    tremcyc=(8*(int(random(4))+1))/(barsize/w);
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    tremamp=random(0, 0.5)*int(random(2))*int(random(2));
    vibamp=random(0, 3)*int(random(2))*int(random(2));

    float detune=random(3);
    int lfoshape=int(random(3));
    int ampshape=int(random(3));
    int p=scale[int(random(scales[selsc].length))];
    int firstpartial=1;
    int tr=transposeList[int(x/barsize)];
    p=p+(12*int(random(5)))+tr;
    float partdet=0;
    
    note(x, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}


void h38_sequentialNotes() {

  strokeWeight(2);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;

  float incs[]={2, 4, 8, 12, 16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;
  int firstpartial=1;

  for (int i=0; i<width; i+=inc) {
    float chunk=inc;
    float x=i;

    int partials=int(random(3, 80));
    int partialmode=int(random(6));
    float lfopow=random(2, 80);
    float w=chunk*(1+int(random(2)));

    tremcyc=(8*(int(random(4))+1))/(barsize/w);
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    tremamp=random(0, 0.5)*int(random(2))*int(random(2));
    vibamp=random(0, 3)*int(random(2))*int(random(2));
    tremamp=0;
    vibamp=2*int(random(2));

    float detune=random(3);
    int lfoshape=int(random(3));
    int ampshape=int(random(3));
    lfoshape=0;
    ampshape=0;
    int p=scale[int(random(scales[selsc].length))];
    int tr=transposeList[int(i/barsize)];
    p=p+(12*int(random(5)))+tr;
    float partdet=0;

    note(x, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h39_arpNotes() {

  selectstrokecolor();
  strokeWeight(2);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  float incs[]={8, 16, 24};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  int partialmode=int(random(6));
  float lfopow=random(1, 40);
  int partials=int(random(4, 40));
  int firstpartial=1;
  float detune=0;

  int direction=int(random(4));
  int steps=int(random(4, 16));
  int stepsize=int(random(2))+1;
  int octave=(int(random(2))*12)+12;
  int interval=int(random(scales[selsc].length))+1;
  int chordsize=int(random(4))+1;

  for (int j=0; j<chordsize; j++) {
    int count =0;

    for (int i=0; i<width; i+=inc) {
      float x=i;
      int countmod=int(barsize/inc)/(int(random(2)+1));
      count=count%countmod;//resset del arp a cada bar
      int tr=transposeList[int(i/barsize)];
      int p=arp(count+j+interval, direction, steps, stepsize)+octave+tr;
      float partdet=0;
      note(x, p, inc, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      count++;
    }
  }
}

void h40_bassNotes() {

  stroke(255);
  float strw=3;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;

  int lfohp=0;
  float hicutpow=0.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=0;


  int num=1+int(random(2));
  for (int h=0; h<num; h++) {
    int partialmode=int(random(4));
    float ampow=random(1, 6);
    float lfopow=random(1, 10);
    int partials=int(random(8, 40));
    float detune=random(3);
    int fullseq[] = new int[32];
    int octseq[]=new int[32];

    //euclidean(int idx, int steps, int fills, int shift)
    for (int k=0; k<4; k++) {
      int fills[]={1, 2, 2, 3, 3, 3, 3, 5};
      int fill=fills[int(random(fills.length))];
      int shift=int(random(4))*2;

      for (int i=0; i<8; i++) {
        int index=i+(k*8);

        fullseq[index]=euclidean(index, 8, fill, shift);
        octseq[index]=12*(int(random(2))*int(random(2)));
      }
    }


    for (int i=0; i<bars*16; i++) {
      float x=(barsize/16)*i;
      int idx=i%16;
      float partdet=0;
      int p=0;
      int rt=rootList[int(i/16)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i/16)];
      p=p+rt+tr;

      if (fullseq[idx]==1) {
        note(x+(strw/2), p+octseq[idx], barsize/4, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
      if (idx%16==0) {
        if (random(100)<25) {
          note(x+(barsize/2)+(strw/2), p, barsize/2, partials, 0, firstpartial, hicutpow, locutpow, 1, ampow, 1, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
        }
      }
    }
  }
}

void h41_noiseNotes() {

  selectstrokecolor();
  strokeWeight(2);
  float barsize=width/bars;
  float lfocycles=bars;

  int lfohp=0;
  float hicutpow=1;
  float locutpow=1;
  float vol=1;
  float tremamp=0;
  float tremcyc=16;
  float vibamp=0;
  float vibcyc=16;
  int lfoshape=4;
  int ampshape=2;

  float inc=barsize*bars;
  for (float j=0; j<width; j+=inc) {
    int partialmode=int(random(6));
    float ampow=random(1, 3);
    float lfopow=random(1, 8);
    float partdet=0;
    float detune=random(3);

    for (int i=0; i<5; i++) {
      int partials=int(random(5, 15));
      int p=scale[int(random(scales[selsc].length))];
      int tr=transposeList[int(j/barsize)];
      p=p+(12*int(random(4)))+12+tr;
      note(j, p, inc, partials, partialmode, 1, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      note(j, 0, inc, partials, partialmode, 1, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }
  }
}

void h42_cloudNotes() {

  selectstrokecolor();
  strokeWeight(1);
  float barsize=width/bars;


  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=16;
  float vibamp=0;
  float vibcyc=16;
  int lfoshape=4;
  int ampshape=2;
  float partdet=0;

  float inc=barsize*bars;
  for (float j=0; j<barsize*bars; j+=inc) {
    int partialmode=0;
    float ampow=1;
    float lfopow=2;
    int prob=int(random(10, 50));
  

    for (int i=0; i<notegrid; i++) {
      float lfocycles=(bars/2)*(int(random(8))+1);
      float ph=i/float(notegrid);
      ph=pow(ph, 0.5);
      //ph=(ph/2)+0.5;
      int not=i%(scales[selsc].length);
      int oct=(i/scales[selsc].length)*12;
      int tr=transposeList[int(j/barsize)];
      int p=scale[not]+oct+tr;
      if (random(100)<(prob*ph)) {
        int partials=int(random(2, 3));
        float detune=random(2);
        note(j, p, inc, partials, partialmode, 0, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }


  locutpow=0;
  tremamp=random(0, 0.25);
  tremcyc=4*(int(random(4))+1);
  vibamp=0;
  vibcyc=8*(int(random(4))+1);

  int partials=int(random(2, 10));
  int partialmode=0;
  float detune=random(3);
  stroke(255);
  note(0, 0, barsize*bars, partials, partialmode, 1, 2, locutpow, 2, 0.75, 2, 1, 0, 1, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, 1);
}


void h43_counterBass() {

  stroke(255);
  float strw=3;
  strokeWeight(strw);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  int lfocycles=1;

  int lfohp=0;
  float hicutpow=0.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
float partdet=0;
  int partialmode=int(random(4));
  float ampow=random(2, 3);
  float lfopow=random(2, 10);
  int partials=int(random(8, 24));
  float detune=random(3);

  //random fills
  int seed=int(random(2000))*int(random(100));
  int steps=2+int(random(7));
  for (int j=0; j<width; j+=width/bars) {
    int p=0;
    int barnow=int(j/barsize);
    int rt=rootList[barnow];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(j/barsize)];
    p=p+rt+tr;

    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        noStroke();
        fill(0);
        rectMode(CORNER);
        rect(j+(i*stepsize), 0, barsize/8, height);
        stroke(255);
        note(j+(i*stepsize)+(strw/2), p, barsize/8, partials, partialmode, 1, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
}

void h44_arpNotes2() {

  selectstrokecolor();
  strokeWeight(2);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  float incs[]={8, 16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  int partialmode=int(random(4));
  float lfopow=random(1, 40);
  int partials=int(random(6, 20));
  int firstpartial=1;
  float detune=0;
float partdet=0;
  int direction=int(random(4));
  int steps=int(random(4, 16));
  int stepsize=int(random(2))+1;
  int octave=12*int(random(1, 2));
  int interval=int(random(scales[selsc].length))+1;
  int chordsize=int(random(4))+2;

  for (int j=0; j<chordsize; j++) {
    int count =0;

    for (int i=0; i<width; i+=inc) {
      float x=i;
      int countmod=int(barsize/inc)/4;
      count=count%countmod;//resset del arp a cada bar
      int rt=rootList[int(i/barsize)];
      rt=scale[rt%scales[selsc].length];

      int tr=transposeList[int(i/barsize)];
      int p=arp(count+j+interval, direction, steps, stepsize)+octave+tr;
      note(x+(barsize/16), p, inc, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      count++;
    }
  }
}

void h45_counterSynth() {

  selectstrokecolor();
  int strokeCol=g.strokeColor;
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  int lfocycles=1;

  int lfohp=0;
  float hicutpow=0.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  int partialmode=int(random(4));
  float ampow=0;
  float lfopow=random(3, 20);
  int partials=int(random(8, 40));
  float detune=random(3);
  float partdet=0;

  //random fills
  int seed=millis();
  int steps=2+int(random(7));
  int pitches[] = new int[steps];
  int parts[] = new int[steps];
  int partmode[] = new int[steps];
  int shape[] = new int[steps];
  float locut[] = new float[steps];
  for (int i=0; i<steps; i++) {
    pitches[i]=scale[int(random(scales[selsc].length))]+(12);//*(int(random(2))+1));
    parts[i]=int(random(8, 24));
    shape[i]=0;
    locut[i]=0;
    partmode[i]=int(random(5));
  }
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        noStroke();
        fill(0);
        rectMode(CORNER);
        rect(j+(i*stepsize), 0, barsize/8, height);
        stroke(red(strokeCol), green(strokeCol), blue(strokeCol));
        strokeWeight(strw);
        int tr=transposeList[int(j/barsize)];
        note(j+(i*2*stepsize)+(strw/2), pitches[i]+tr, barsize/8, parts[i], partmode[i], 1, hicutpow, locut[i], ampshape, ampow, shape[i], lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed*6);
      if ((eval==1)) {
        noStroke();
        fill(0);
        rectMode(CORNER);
        rect(j+(i*stepsize), 0, barsize/8, height);
        stroke(red(strokeCol), green(strokeCol), blue(strokeCol));
        int tr=transposeList[int(j/barsize)];
        note(j+(i*stepsize)+(strw/2), pitches[i]+tr, barsize/8, parts[i], partmode[i], 1, hicutpow, locut[i], ampshape, ampow, shape[i], lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
  strokeWeight(1);
}

void h46_padChords() {

  selectstrokecolor();
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int num=int(random(4, 30));
  float partdet=0;


  for (int i=0; i<num; i++) {

    int partials=int(random(2, 10));
    int partialmode=int(random(6));
    float lfopow=random(2, 80);
    float w=barsize+(int(random(width-barsize)));
    float x=int(random(width-w));

    tremcyc=(8*(int(random(4))+1))/(barsize/w);
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    tremamp=random(0, 0.2)*int(random(2))*int(random(2));
    vibamp=0;

    float detune=random(3);
    int lfoshape=2;
    int ampshape=2;
    int numnotes=int(random(5));
    for (int g=0; g<numnotes; g++) {
      int p=scale[int(random(scales[selsc].length))];
      int tr=transposeList[int(x/barsize)];
      int firstpartial=1;
      p=p+(12*int(random(5)))+tr;

      note(x, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      /*void note(float x,int p, float w,int partials, int partialmode, int firstpartial, float hicutpow,float locutpow,int ampshape,float ampow,int lfoshape,
       float lfocycles, int lfohp, float lfopow, float tremamp, float tremcyc,float vibamp, float vibcyc, float detune, float vol){
       */
    }
  }
}

void h47_bellNotes() {//bells
  float strw=random(1, 3);
  strokeWeight(strw);
  float barsize=width/bars;
  float partdet=0;
  for (int i=0; i<bars; i++) {
    float nums[]={1, 2, 2.66666, 4, 5.33333, 8};
    float n=nums[int(random(nums.length))];
    int octave=12+(12*int(random(4)));
    int tr=transposeList[int(i)];
    for (int k=0; k<n; k++) {
      int partials=int(random(1, 4));
      int partialmode=int(random(3));


      float detune=0;
      int numnotes=int(random(2, 10));
      int x=int((barsize*i)+((barsize/n)*k));
      float w=random(barsize/n, width-x);
      selectstrokecolor();
      for (int g=0; g<numnotes; g++) {
        int p=scale[int(random(scales[selsc].length))];
        int firstpartial=1;
        p=p+octave+tr;
        note(x+(strw/2), p, w, partials, partialmode, firstpartial, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, detune, partdet, 1);
      }
    }
  }
}

void h48_padPage() {

  selectstrokecolor();
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=0.33;
  int lfohp=0;
  float hicutpow=2;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  float lfopow=0;
  float w=width;
  float x=0;
  vibcyc=(8*(int(random(4))+1))/(barsize/w);
  vibamp=0;
  float partdet=0;

  float detune=random(1);
  int lfoshape=2;
  int ampshape=2;
  int numnotes=int(random(3, 18));

  for (int g=0; g<numnotes; g++) {
    vol=random(1);
    int partials=int(random(1, 5));
    int partialmode=int(random(3));
    tremcyc=(1*(int(random(4))+1))/(barsize/w);
    tremamp=random(0, 0.5)*int(random(2))*int(random(2));
    int p=scale[int(random(scales[selsc].length))];
    int tr=transposeList[int(x/barsize)];
    int firstpartial=1;
    p=24+p+(12*int(random(4)))+tr;

    note(x, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    /*void note(float x,int p, float w,int partials, int partialmode, int firstpartial, float hicutpow,float locutpow,int ampshape,float ampow,int lfoshape,
     float lfocycles, int lfohp, float lfopow, float tremamp, float tremcyc,float vibamp, float vibcyc, float detune, float vol){
     */
  }
}

void h49_bassBar() {

  stroke(255);
  float strw=3;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=1;
  int partialmode=int(random(4));
  float ampow=random(2, 6);
  float lfopow=random(1, 10);
  int partials=int(random(8, 24));
  float detune=random(3);
  float partdet=0;

  for (int i=0; i<bars; i++) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    float x=barsize*i;
    note(x+(strw/2), p, barsize, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h50_strumBar() {
  selectstrokecolor();
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  float mult=int(random(2))+1;
  int dir=int(random(2));
  dir=0;
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    if (random(100)<50) {
      strum3(i+((strw/2)/barsize), 0.5/mult, (stepsize*24), int(random(3, 5)), 0, 0.5+random(3), 2+int(random(2)), 8, dir, tr);//arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, int modulo)
      //strum(float barstart, float bardur, float notewidth, float numnotes, float rndmoff, float stepsize, float octavestart, int strokew, float pw){
    }
  }
  strokeWeight(1);
}

void h51_bassRumble() { //rumble
  float barsize=width/bars;
  strokeWeight(3);
  fill(255);
  stroke(255);
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=1;
  int firstpartial=1;
  int partialmode=int(random(4));
  float ampow=random(2, 8);
  float lfopow=0;
  int partials=int(random(8, 24));
  float detune=random(3);
  float partdet=0;


  for (float i=0; i<bars; i+=0.25) {

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    float w=(0.25*barsize);
    float x=i*barsize;
    note(x-4, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h52_harmPoints() {
  float barsize=width/bars;
  float noteh=height/float(notegrid);
  for (float i=0; i<width; i+=(barsize/bardiv)) {

    int n=int(random(3, 8));
    for (int j=0; j<n; j++) {
      int tr=transposeList[int(i/barsize)];
      float p=scale[int(random(scales[selsc].length))]+tr;
      float octave=int(random(9))*12;
      stroke(255, random(255));
      strokeWeight(0.25+random(3));
      point(i, height-((p+octave)*noteh));
    }
  }
}

void h53_chordBar() {

  selectstrokecolor();
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;

  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=1;
  int partialmode=int(random(3));
  float ampow=random(2, 6);
  float lfopow=random(1, 10);
  int partials=int(random(4, 12));
  float detune=random(3);
  float partdet=0;


  for (int i=0; i<bars; i++) {
    float x=barsize*i;
    int num=int(random(3, 12));
    if (random(100)<50) {
      for (int j=0; j<num; j++) {
        float vol=random(1);
        int tr=transposeList[int(i)];
        int p=scale[int(random(scales[selsc].length))]+tr;
        int octave=int(random(4))*12;
        note(x+random(stepsize)+(strw/2), p+octave, barsize*2, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
  strokeWeight(1);
}

void h54_anaChord() { //vlocking anacrusa chord

  float strw=random(1, 3);
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;

  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=1;
  int firstpartial=1;
  float ampow=random(4);


  float[] figs={8, 4};

  for (float i=0; i<bars; i++) {
    float fig=figs[int(random(figs.length))];
    float w=(barsize/fig);
    float x=(i*barsize)+(barsize-w);

    float partials=(int(random(100))/100.);
    partials=(pow(partials, 2)*80)+6;
    int partialmode=int(random(6));
    float lfopow=0;
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    vibamp=random(0, 3)*int(random(2))*int(random(2));
    vibamp=2*int(random(2));
    float detune=random(3);
    float partdet=0;

    if (random(100)<8) {

      fill(0);
      stroke(0);
      rect(x, 0, w, height);


      fill(255);
      selectstrokecolor();
      strokeWeight(strw);
      int num=int(random(3, 18));
      for (int j=0; j<num; j++) {
        float vol=random(0.5, 1);
        int tr=transposeList[int(i)];
        int p=scale[int(random(scales[selsc].length))]+tr;
        int octave=int(random(5))*12;
        note(x+(strw/2), p+octave, w, int(partials), partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
}

void h55_anaBass() { //blocking anacrusa bass

  float barsize=width/bars;
  int lfocycles=0;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;

  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=1;
  int firstpartial=1;
  float ampow=random(0.5, 2);
  float[] figs={8, 4};

  for (float i=0; i<bars; i++) {
    float fig=figs[int(random(figs.length))];
    float w=(barsize/fig);
    float x=(i*barsize)+(barsize-w);

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    int partials=int(random(6, 120));
    int partialmode=int(random(6));
    float lfopow=random(2, 80);
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    vibamp=random(0, 3)*int(random(2))*int(random(2));
    vibamp=2*int(random(2));
    float detune=random(3);
    float partdet=0;

    if (random(100)<25) {
      if (random(100)<50) {
        fill(0);
        stroke(0);
        rect(x, 0, w, height);
      }

      fill(255);
      stroke(255);
      float strw=random(1, 3);
      strokeWeight(strw);
      note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, 1);
    }
  }
}

void h56_notePeriods() {

  //strokeWeight(2);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int firstpartial=1;
  int lfoshape=0;
  int ampshape=0;
  int bardiv=int(random(2))+1;
  float partdet=0;

  for (float i=0; i<width; i+=barsize/bardiv) {
    float strw=random(1, 3);
    strokeWeight(strw);

    if (random(100)<50) {
      float nums[]={2.666, 5.3333, 6, 12};
      float num=nums[int(random(nums.length))]/bardiv;
      float chunk=(barsize/bardiv)/num;
      float w=chunk;
      for (int j=0; j<num; j++) {
        float x=i+(j*chunk);
        int partials=int(random(3, 80));
        int partialmode=int(random(6));
        float lfopow=random(2, 80);
        vibcyc=(8*(int(random(4))+1))/(barsize/w);
        vibamp=random(0, 3)*int(random(2))*int(random(2));
        vibamp=2*int(random(2));
        float detune=random(3);
        int p=scale[int(random(scales[selsc].length))];
        int tr=transposeList[int(i/barsize)];
        p=p+(12*int(random(4)))+tr;
        note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
}


void h57_bassPeriods() {


  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=0.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int firstpartial=1;
  int lfoshape=0;
  int ampshape=0;

  int partials=int(random(6, 80));
  int partialmode=int(random(4));
  float lfopow=random(2, 60);

  float detune=random(3);
  float partdet=0;

  //float bardivs[]={0.125, 0.25, 0.5,1};
  float bardivs[]={1};
  float bardiv=bardivs[int(random(bardivs.length))];

  float nums[]={2.666, 5.3333, 6, 12};
  float num=nums[int(random(nums.length))]/bardiv;
  float chunk=(barsize/bardiv)/num;
  float w=chunk*2;

  float stepsize=(barsize/bardiv);
  float stepsahead=(stepsize*2)*int(random(2));
  float strw=random(1, 3);
  strokeWeight(strw);

  for (float i=0; i<width; i+=barsize/bardiv) {

    stroke(255);

    if (random(100)<100) {

      for (int j=0; j<num; j++) {
        float x=i+(j*chunk);

        int p=0;
        int barnow=int((i/barsize));
        int rt=rootList[int(barnow)];
        rt=scale[rt%scales[selsc].length];
        int tr=transposeList[int(barnow)];
        p=p+rt+tr;

        //int p=scale[int(random(scales[selsc].length))];
        //p=p+(12*int(random(4)));
        note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
}

void h58_pageBass() {

  noFill();
  stroke(255, 0, 0);
  strokeWeight(2);
  float noteh=height/float(notegrid);
  int detune=1+int(random(noteh/2));//
  //detune=0;
  int num=int(bars/(int(random(2)+1)));
  num=constrain(num, 1, 128);
  int partials=int((pow(random(1), 3)*300)+2);
  // partials=600;//
  int[] notes=new int[num+1];
  for (int i=0; i<num+1; i++) {
    if (random(100)<100) {
      notes[i]=scale[0];
    } else {
      notes[i]=scale[1];
    }
  }

  for (float j=1; j<partials; j++) {
    float fade=j/partials;
    fade=pow(fade, 0.75);
    fade=255-(fade*255);
    stroke(255, fade);
    for (int i=0; i<num+1; i++) {
      int tr=transposeList[int(i)];
      float y=height-(f2p((p2f((notes[i])+tr)*j))*noteh);
      float x0=(i*(width/num));
      float x1=(i*(width/num))+(width/num);
      line(x0-((width/num)/2), y+detune, x1-((width/num)/2)-2, y+detune);
      line(x0-((width/num)/2), y, x1-((width/num)/2)-2, y);
      line(x0-((width/num)/2), y-detune, x1-((width/num)/2)-2, y-detune);
    }
  }
}

void h59_filterBass3() {
  selectstrokecolor();
  strokeWeight(1);
  float barsize=width/bars;
  float stepsize=(barsize/bardiv);
  int partmode=int(random(4));
  //additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)

  for (float i=0; i<bars; i+=0.25) {
    float doub=int(random(2))+1;
    float numpart=random(100)/100.;
    numpart=pow(numpart, 3);

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (random(100)<15) {
      fill(0);
      noStroke();
      rect((i*barsize)-(stepsize*doub), 0, (stepsize*doub), height);
      additive2(p, i-(0.0625*doub), doub, int((numpart*110))+6, partmode, int(random(2)), random(3), 2);
    }
  }
}

void h60_fmBells() {


  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;

  float incs[]={4, 8, 8, 8, 8, 16, 16, 16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;
  float partdet=0;


  for (int i=0; i<width; i+=inc) {
    float strw=random(1, 3);
    strokeWeight(strw);

    selectstrokecolor();
    int firstpartial=int(random(15))+1;
    float chunk=inc;
    float x=i;

    int partials=int(random(3, 80));
    int partialmode=4+int(random(2));
    float lfopow=random(2, 60);
    float w=chunk*(1+int(random(4)));

    tremcyc=(8*(int(random(4))+1))/(barsize/w);
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    tremamp=random(0, 0.5)*int(random(2))*int(random(2));
    vibamp=random(0, 3)*int(random(2))*int(random(2));
    tremamp=0;
    vibamp=2*int(random(2));

    float detune=random(3);
    int lfoshape=int(random(3));
    int ampshape=int(random(3));
    lfoshape=0;
    ampshape=0;

    int tr=transposeList[int(i/barsize)];
    int p=scale[int(random(scales[selsc].length))];
    p=p+(12*int(random(5)))+tr;
    note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    inc=barsize/incs[int(random(incs.length))];
  }
}

void h61_quarterSub() {


  stroke(255);
  float strw=3;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=0;
  int partialmode=0;
  float ampow=random(2, 6);
  float lfopow=random(1, 10);
  int partials=int(random(5, 8));
  float detune=0;
  float partdet=0;

  for (float i=0; i<bars; i+=0.25) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    float x=barsize*i;
    note(x+(strw/2), p, barsize/2, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h62_tranceBass() {
  float barsize=width/bars;
  int parts=int(random(32))+4;
  for (float i=0; i<bars; i+=0.0625) {

    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    additive3(p, i*barsize, barsize/8, parts, 0, 1, random(3), 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }
}

void h63_randomSequentialNotes() {

  selectstrokecolor();
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  float partdet=0;

  float incs[]={2, 4, 8, 12, 16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  for (int i=0; i<width; i+=inc) {
    float chunk=inc;
    float x=i;

    int partials=int(random(2, 80));
    int partialmode=int(random(6));
    float lfopow=random(2, 80);
    float w=(1+int(random(8)))*chunk;

    tremcyc=(8*(int(random(4))+1))/(barsize/w);
    vibcyc=(8*(int(random(4))+1))/(barsize/w);
    tremamp=random(0, 0.5)*int(random(2))*int(random(2));
    vibamp=random(0, 3)*int(random(2))*int(random(2));

    float detune=random(3);
    int lfoshape=int(random(3));
    int ampshape=int(random(3));
    int p=scale[int(random(scales[selsc].length))];
    int firstpartial=1;

    int tr=transposeList[int(i/barsize)];
    p=p+(12*int(random(5)))+tr;

    note(x, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h64_arpLoop() {
  selectstrokecolor();
  int count=0;
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  float incs[]={16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  float lens[]={1, 2, 4};
  float len=lens[int(random(lens.length))];

  float notelens[]={2, 4, 8};
  float notelen=notelens[int(random(notelens.length))];

  int partialmode=int(random(4));
  float lfopow=random(1, 30);
  int partials=int(random(1, 14));
  int firstpartial=0;
  float detune=0;
  float partdet=0;

  int direction=int(random(3));
  int steps=int(random(4, 16));
  int stepsize=int(random(2))+1;
  int octave=(int(random(2))*12)+12;
  int startnote=int(random(scales[selsc].length));
  int interval=int(random(scales[selsc].length))+1;



  for (int i=0; i<width; i+=inc) {
    float x=i;
    int countmod=int((barsize/inc)/len);
    count=count%countmod;//resset del arp a cada bar
    int tr=transposeList[int(i/barsize)];
    int p=arp(startnote+count+interval, direction, steps, stepsize)+octave+tr;


    note(x+(strw/2), p, inc*notelen, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    count++;
  }
  strokeWeight(1);
}

void h65_counterSub() {
  stroke(255);
  float strw=3;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=0;
  int partialmode=0;
  float ampow=random(2, 6);
  float lfopow=random(1, 10);
  int partials=int(random(2, 8));
  float detune=0;
  float partdet=0;

  for (float i=0; i<bars; i+=0.25) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    float x=barsize*(i+0.125);
    note(x+(strw/2), p, barsize/2, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h66_electroBass() {
  float barsize=width/bars;

  for (float i=0; i<bars; i+=0.0625) {
    int parts=int(pow((random(100)/100.), 2.3)*64)+4;
    float p=0;
    if (random(100)<3) {
      p=12;
    } else {
      p=0;
    }

    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    additive3(p, i*barsize, barsize/8, parts, 0, 1, random(2), 7);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }
}

void h67_tranceBass2() {
  float barsize=width/bars;
  int steps=4*(int(random(2))+1);
  int[] parts=new int[steps];
  int count=0;
  for (int i=0; i<steps; i++) {
    parts[i]=int(pow((random(100)/100.), 2.3)*120)+4;
  }

  for (float i=0; i<bars; i+=0.0625) {
    int st=count%steps;
    float p=0;
    if (random(100)<3) {
      p=12;
    } else {
      p=0;
    }

    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;


    additive3(p, i*barsize, barsize/8, parts[st], 0, 1, random(2), 7);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
    count++;
  }
}

void h68_meloProb() {

  int[] stepchances={75, 0, 30, 10, 40, 10, 30, 10, 50, 10, 30, 10, 30, 15, 30, 5};
  int[] stepresult=new int[int(bardiv)];
  int[] stepnotes=new int[int(bardiv)];
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  stepresult=probsteps(stepchances);
  int notedur=(int(random(4))+1);
  selectstrokecolor();
  float strw=random(8)+2;
  strokeWeight(strw);


  int lfocycles=1;

  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=tremamp=random(0, 0.5)*int(random(2))*int(random(2));
  float tremcyc=(8*(int(random(4))+1))/(barsize/(stepsize*notedur));
  float vibcyc=vibcyc=(8*(int(random(4))+1))/(barsize/(stepsize*notedur));
  float vibamp=2*int(random(2));
  int lfoshape=0;
  int ampshape=0;
  float lfopow=random(2, 60);
  int partialmode=int(random(4));
  float ampow=random(2);
  int partials=int(random(2, 8));
  float detune=random(4);
  float partdet=0;

  int octave=(12*(int(random(2))+1));

  int seed=millis();
  int steps=int(bardiv);

  for (int i=0; i<steps; i++) {
    stepnotes[i]=scale[int(random(scales[selsc].length))]+(12*(int(random(2))+1))+octave;
  }


  strokeCap(SQUARE);
  for (int i=0; i<bars; i++) {

    int tr=transposeList[int(i)];

    for (int j=0; j<bardiv; j++) {
      if (stepresult[j]==1) {
        note((j*stepsize)+(i*barsize)+(strw/2), stepnotes[j]+tr, (barsize/4)*notedur, partials, partialmode, 1, hicutpow, 0, ampshape, ampow, 0, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
  strokeCap(ROUND);
}

void h69_arpNotes3() {

  selectstrokecolor();
  float strw=random(1, 3);
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  float incs[]={8, 16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  int partials=int(random(3, 30));
  int partialmode=int(random(4));
  float lfopow=random(1, 40);
  vibcyc=(8*(int(random(4))+1))/(barsize/16);
  vibamp=random(0, 3)*int(random(2))*int(random(2));
  vibamp=2*int(random(2));
  float detune=random(3);
  int firstpartial=0;
  float partdet=0;


  int direction=int(random(4));
  int steps=int(random(4, 16));
  int stepsize=int(random(2))+1;
  int octave=12*int(random(1, 2));
  int interval=int(random(scales[selsc].length))+1;
  int chordsize=int(random(4))+2;

  for (int j=0; j<chordsize; j++) {
    int count =0;

    for (int i=0; i<width; i+=inc) {
      float x=i;
      int countmod=int(barsize/inc)/4;
      count=count%countmod;//resset del arp a cada bar
      int rt=rootList[int(i/barsize)];
      rt=scale[rt%scales[selsc].length];

      int tr=transposeList[int(i/barsize)];
      int p=arp((count*interval)+j+rt, direction, steps, stepsize)+octave+tr;
      note(x+(barsize/16)+strw/2, p, inc, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      count++;
    }
  }
}

void h70_lastBass() {


  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int firstpartial=1;
  int lfoshape=0;
  int ampshape=0;

  int partials=int(random(15, 100));
  int partialmode=int(random(4));
  float lfopow=random(2, 60);

  float detune=random(3);
  float partdet=0;

  //float bardivs[]={0.125, 0.25, 0.5,1};
  float bardivs[]={1};
  float bardiv=bardivs[int(random(bardivs.length))];

  float nums[]={2.666, 6, 12};
  float num=nums[int(random(nums.length))]/bardiv;
  float chunk=(barsize/bardiv)/num;
  float w=chunk*2;

  float stepsize=(barsize/bardiv);
  float stepsahead=(stepsize*2)*int(random(2));
  float strw=random(1, 3);
  strokeWeight(strw);

  for (float i=(bars*barsize)-barsize; i<width; i+=barsize/bardiv) {



    if (random(100)<20) {

      noStroke();
      fill(0);
      rect((bars*barsize)-barsize, 0, barsize, height);
      println(bars*barsize);

      for (int j=0; j<num; j++) {
        float x=i+(j*chunk);

        int p=0;
        int barnow=int((i/barsize));
        int rt=rootList[int(barnow)];
        rt=scale[rt%scales[selsc].length];
        int tr=transposeList[int(barnow)];
        p=p+rt+tr;


        stroke(255);
        strokeWeight(strw);

        //int p=scale[int(random(scales[selsc].length))];
        //p=p+(12*int(random(4)));
        note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
}

void h71_euclideanChords() {

  selectstrokecolor();
  float strw=3;
  strokeWeight(strw);
  strokeCap(PROJECT);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=0;
  int partialmode=int(random(4));
  float ampow=random(1, 6);
  float lfopow=random(1, 10);
  int partials=int(random(1, 12));
  float detune=random(2);
  int duration=int((barsize/3)/(int(random(4))+1));
  float partdet=0;

  int chordsize=int(random(3, 6));
  int hitseq[] = new int[int(bardiv)];
  int octseq[]=new int[int(bardiv)];
  int noteseq[][]=new int[int(bardiv)][chordsize];

  int steps[]={5, 7, 8, 9};
  int step=steps[int(random(steps.length))];
  int fills[]={2, 3};
  int fill=fills[int(random(fills.length))];
  int shift=int(random(step));

  int interval=int(random(1, scales[selsc].length-1));

  for (int i=0; i<bardiv; i++) {
    hitseq[i]=euclidean(i, step, fill, shift);
    octseq[i]=12*(int(random(2))*int(random(2)));
    int rootNote=int(random(scales[selsc].length));

    for (int j=0; j<chordsize; j++) {
      int selnote=(rootNote+(j*interval))%scales[selsc].length;
      int seloctave=int((rootNote+(j*interval))/scales[selsc].length)*12;
      noteseq[i][j]=scale[selnote]+seloctave;
    }
  }

  int oct=12+(int(random(2))*12);
  for (int i=0; i<bars; i++) {
    for (int j=0; j<bardiv; j++) {
      float x=(i*barsize)+(j*stepsize);

      int tr=transposeList[i];
      int p=oct+tr;
      if (hitseq[j]==1) {
        //line(x,600,x+20,600);
        for (int k=0; k<chordsize; k++) {
          note(x+(strw/2), p+octseq[j]+noteseq[j][k], duration, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
        }
      }
    }
  }
}

void h72_arpLoop2() {
  selectstrokecolor();
  int count=0;
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  float incs[]={16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  float lens[]={1, 2, 4};
  float len=lens[int(random(lens.length))];

  float notelens[]={2, 4, 8};
  float notelen=notelens[int(random(notelens.length))];

  int partialmode=int(random(3));
  float lfopow=random(1, 30);
  int partials=int(random(1, 14));
  int firstpartial=0;
  float detune=0;
  float partdet=0;

  int direction=int(random(3));
  int steps=int(random(4, 16));
  int stepsize=int(random(2))+1;
  int octave=(int(random(2))*12)+12;
  int startnote=int(random(scales[selsc].length));
  int interval=int(random(scales[selsc].length))+1;
  int loop=4; //2 o 4
  for (int i=0; i<(bars*loop); i++) {
    int tr=transposeList[int(i/loop)];
    for (int j=0; j<(sel/loop); j++) {
      //int idx=j%
      float x=(i*(barsize/loop))+(j*((barsize/loop)/(sel/loop)));
      int p=arp(startnote+j+interval, direction, steps, stepsize)+octave+tr;
      note(x+(strw/2), p, ((barsize/loop)/(sel/loop))*notelen, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }
  }
  strokeWeight(1);
}

void h73_arpLoopBlock() {
  selectstrokecolor();
  int count=0;
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=1;
  int lfohp=0;
  float hicutpow=1.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  float incs[]={16};
  float sel=incs[int(random(incs.length))];
  float inc=barsize/sel;

  float lens[]={1, 2, 4};
  float len=lens[int(random(lens.length))];

  float notelens[]={2, 4, 8};
  float notelen=notelens[int(random(notelens.length))];

  int partialmode=int(random(3));
  float lfopow=random(1, 30);
  int partials=int(random(3, 20));
  int firstpartial=0;
  float detune=0;
  float partdet=0;

  int direction=int(random(3));
  int steps=int(random(4, 16));
  int stepsize=int(random(2))+1;
  int octave=(int(random(2))*12)+12;
  int startnote=int(random(scales[selsc].length));
  int interval=int(random(scales[selsc].length))+1;
  int loop=((int(random(2)))*2)+2; //2 o 4
  rectMode(CORNER);

  for (int i=0; i<(bars*loop); i++) {
    if (i%2==1&&random(100)<10) {
      int tr=transposeList[int(i/loop)];
      fill(0);
      noStroke();
      rect(i*(barsize/loop), 0, (barsize/loop), height);
      stroke(255);
      strokeWeight(strw);

      for (int j=0; j<(sel/loop); j++) {
        float x=(i*(barsize/loop))+(j*((barsize/loop)/(sel/loop)));
        int p=arp(startnote+j+interval, direction, steps, stepsize)+octave+tr;

        note(x+(strw/2), p, ((barsize/loop)/(sel/loop))*notelen, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
      }
    }
  }
  strokeWeight(1);
}

void h74_tranceBassBlock() {
  float barsize=width/bars;
  int steps=4*(int(random(2))+1);
  int[] parts=new int[steps];
  for (int i=0; i<steps; i++) {
    parts[i]=int(pow((random(100)/100.), 2)*140)+8;
  }


  float inc=(steps*0.25)/4;
  int count=0;
  for (float i=0; i<bars; i+=inc) {
    float p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;

    if (count%2!=0&&count%4!=2&&random(100)<10) {
      fill(0);
      noStroke();
      rect(i*barsize, 0, barsize*inc, height);
      stroke(255);
      for (int j=0; j<steps; j++) {
        if (random(100)<3) {
          p=12;
        } else {
          p=0;
        }

        additive3(p, (i*barsize)+(j*(barsize/bardiv)), barsize/8, parts[j], 0, 1, random(2), 7);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
      }
    }
    count++;
  }
}

void h75_vibratos() {
  //vibrato(int num, float octsart, float octrange)
  int num=int(random(10));
  vibrato(num, 2, 3);
}

void h76_bassLFO() {

  float barsize=width/bars;
  float ampow=0;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int firstpartial=0;
  int ampshape=0;
  float detune=random(2);
  float partdet=0;
  float lfocycles[]={16,12, 8, 6, 5.33333, 4, 2.66666,2,1};

  

  for (int i=0; i<bars; i++) {
    
    int partials=int(random(12, 80));
    int partialmode=int(random(4));
    int lfoshape=2;
    float lfopow=random(1, 8);
    float cycles=lfocycles[int(random(lfocycles.length))];
    
    float strw=random(1, 3);
    strokeWeight(strw);
    stroke(255);
    
    int p=0;
    int rt=rootList[i];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[i];
    p=p+rt+tr;

    note((i*barsize)+(strw/2), p, barsize, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, cycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  }
}

void h77_detunedBells() {//bells
  float strw=random(1, 3);
  strokeWeight(strw);
  float barsize=width/bars;
  float partdet=1;
  for (int i=0; i<bars; i++) {
    float nums[]={1, 2, 2.66666, 4, 5.33333, 8};
    float n=nums[int(random(nums.length))];
    int octave=12+(12*int(random(4)));
    int tr=transposeList[int(i)];
    for (int k=0; k<n; k++) {
      int partials=int(random(4, 12));
      int partialmode=int(random(4));

      float detune=0;
      int numnotes=int(random(2, 10));
      int x=int((barsize*i)+((barsize/n)*k));
      float w=random((barsize/n)/2, barsize);
      selectstrokecolor();
      for (int g=0; g<numnotes; g++) {
        int p=scale[int(random(scales[selsc].length))];
        int firstpartial=0;
        p=p+octave+tr;
        note(x+(strw/2), p, w, partials, partialmode, firstpartial, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, detune, partdet, 1);
      }
    }
  }
}

void h78_dunes() {
  noFill();
  stroke(255, 0, 0);
  strokeWeight(2);
  float tens=random(0.9, 1);
  float noteh=height/float(notegrid);
  int detune=1+int(random(noteh/2));
  int partials=int(random(8, 16));

  for (float j=1; j<partials; j++) {
    float perlincycles=random(1,3);
    float y0=height-(((scale[rootList[0]%scales[selsc].length])+transposeList[0])*noteh);
    float fade=j/partials;
    fade=pow(fade, 0.75);
    fade=255-(fade*255);
    stroke(255, fade);
    for (int i=0; i<bars+1; i++) {

      int p=0;
      int rt=rootList[int(i)];
      rt=scale[rt%scales[selsc].length];
      int tr=transposeList[int(i)];
      p=p+rt+tr;

      float y1=height-(f2p((p2f(p)*j))*noteh);
      float x0=(i*(width/bars));
      float x1=(i*(width/bars))+(width/bars);
      portamento(x0-((width/bars)/2), y0, x1-((width/bars)/2), y1, tens,1,perlincycles/6,2);
      y0=y1;
      //line(x0,0,x0,height);
    }
  }
}

void h79_stepPartialDetune() {


  stroke(255);
  
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=0;
  int partialmode=0;
  
  float detune=0;
  

  for (float i=0; i<bars; i+=0.0625) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;
    float partdet=random(1,3);
    int partials=int(random(10, 45));
    float ampow=random(2, 6);
    float lfopow=random(1, 10); 
    float w=(barsize/2)/(int(random(4))+1);
    float x=barsize*i;
    float strw=3;
    strokeWeight(strw);
    if(random(100)<15){
      note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }
  }
}

void h80_bassLFOBlock() {

  float barsize=width/bars;
  float ampow=0;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int firstpartial=0;
  int ampshape=0;
  float detune=random(2);
  float partdet=0;
  float lfocycles[]={16,12, 8, 6, 5.33333, 4};

  

  for (int i=0; i<bars; i++) {
    
    int partials=int(random(16, 96));
    int partialmode=int(random(4));
    int lfoshape=int(random(4));
    while(lfoshape==2){
      lfoshape=int(random(4));
    }
    float lfopow=random(1, 8);
    if (lfoshape==3){
      lfopow=random(1, 16);
    }
    else{
      lfopow=random(32);
    }
    float cycles=lfocycles[int(random(lfocycles.length))]/2;
    
    
    
    int p=0;
    int rt=rootList[i];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[i];
    p=p+rt+tr;

    if(random(100)<8&&i==(bars-1)){
      fill(0);
      noStroke();
      rect((i*barsize)+(barsize/2),0,barsize/2,height);
      float strw=random(1,3);
      strokeWeight(strw);
      stroke(255);
      note((i*barsize)+(barsize/2)+(strw/2), p, barsize/2, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, cycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }
  }
}

void h81_partialMelodies3() { //partial melodies

  float inc=1;
  float barsize=width/bars;
  int lfocycles=0;
  float ampow=2;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;

  
  for (float i=0; i<bars; i+=inc) { 
    float x=i*barsize;
    int partials=int(random(4, 12));
    int partialmode=int(random(5));
    float lfopow=random(6, 90);
    float w=barsize*(int(random(3))+1);

    float detune=random(3);

    int lfoshape=int(random(3));
    int ampshape=2;
    int firstpartial=0;
    float partdet=0;
    
    int p=scale[int(random(scales[selsc].length))];   
    int tr=transposeList[int(i)];
    p=12+p+(12*int(random(4)))+tr;
    
    float strw=random(1,4);
    strokeWeight(strw);
    selectstrokecolor();
    note(x, p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
  
    float raninc[]={0.0625,0.125, 0.25, 0.5};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }
}

void h82_noiseNotes2() {

  
  
  float barsize=width/bars;
  float lfocycles=bars;

  int lfohp=0;
  float hicutpow=1;
  float locutpow=1;
  float vol=1;
  float tremamp=0;
  float tremcyc=16;
  float vibamp=0;
  float vibcyc=16;
  int lfoshape=4;
  int ampshape=2;
  float partdet=0;
    
    int num=int(random(8,16));

    for (int i=0; i<num; i++) {
      int partialmode=int(random(6));
      float detune=random(3);
      float ampow=random(0.5, 2);
      float lfopow=random(1, 8);
      float strw=random(1,4);
      strokeWeight(strw);
      selectstrokecolor();
      int partials=int(random(2, 8));
      int p=scale[int(random(scales[selsc].length))];
      p=p+(12*int(random(5)))+12;
      note2(0, p, barsize*bars, partials, partialmode, 1, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }

}

void h83_stepBassSolo(){
  float barsize=width/bars;
  int lfocycles=1;
  float ampow=2;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int firstpartial=1;
  int lfoshape=0;
  int ampshape=0;

  int partials=int(random(15, 100));
  int partialmode=int(random(4));
  float lfopow=random(2, 8);
  float detune=random(4);
  float partdet=2;
  int step=int(random(1,4));
  float strw=random(2,4);
  
  float quarter=4;
  for(int j=0;j<bars;j++){
    for(int i=0;i<quarter;i++){
      if(i==3 || i==1){
        if(random(100)<15){
          
          for(int k=0;k<4;k++){
            if(k==step){
              float x=(j*barsize)+(i*(barsize/4))+(k*(barsize/16));
              float w2=((j*barsize)+((i+1)*(barsize/4)))-x;
              noStroke();
              fill(0);
              rect(x,0,w2,height);
              int p=0;
              int rt=rootList[int(j)];
              rt=scale[rt%scales[selsc].length];
              int tr=transposeList[int(j)];
              p=p+rt+tr;
              float w=(barsize/4);
              stroke(255);
              strokeWeight(strw);
              note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
              note(x+(strw/2), p+12, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
              //note(x+(strw/2), p-12, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);

            }
          }
        }
      }
    }
  }
}

void h84_stepBassGroup() {


  stroke(255);
  
  float barsize=width/bars;
  int lfocycles=1;
  int lfohp=0;
  float hicutpow=1;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;
  int firstpartial=0;
  int partialmode=0;
  
  float detune=0;
  

  for (float i=0; i<bars; i+=0.0625) {
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;
    float partdet=0;
    int partials=int(random(10, 45));
    float ampow=random(2, 6);
    float lfopow=random(1, 10); 
    float w=(barsize/2)/(int(random(4))+1);
    float x=barsize*i;
    float strw=3;
    strokeWeight(strw);
    if(random(100)<25){
      note(x+(strw/2), p, w, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
    }
  }
}

void h85_counterSynth2() {

  selectstrokecolor();
  int strokeCol=g.strokeColor;
  float strw=random(4)+1;
  strokeWeight(strw);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  int lfocycles=1;

  int lfohp=0;
  float hicutpow=0.5;
  float locutpow=0;
  float vol=1;
  float tremamp=0;
  float tremcyc=0;
  float vibamp=0;
  float vibcyc=0;
  int lfoshape=0;
  int ampshape=0;

  int partialmode=int(random(4));
  float ampow=1;
  float lfopow=random(3, 20);
  int partials=int(random(8, 48));
  float detune=random(3);
  float partdet=0;

  //random fills
  int seed=millis();
  int steps=4+int(random(13));
  int pitches[] = new int[steps];
  int parts[] = new int[steps];
  int partmode[] = new int[steps];
  int shape[] = new int[steps];
  float locut[] = new float[steps];
  int interval=int(random(3))+1;
  int chordnum=int(random(4))+2;
  int startnote=int(random(scales[selsc].length));
  int startoctave=int(random(2))*12;
  for (int i=0; i<steps; i++) {
    pitches[i]=scale[int(random(scales[selsc].length))]+(12);//*(int(random(2))+1));
    parts[i]=int(random(10, 24));
    shape[i]=0;
    locut[i]=0;
    partmode[i]=int(random(5));    
  }
  for (int j=0; j<width; j+=width/bars) {
    int tr=transposeList[int(j/barsize)];
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        stroke(red(strokeCol), green(strokeCol), blue(strokeCol));
        strokeWeight(strw);
        
        for(int k=0;k<chordnum;k++){
          int p=scale[(k*interval)%scales[selsc].length]+(int((k*interval)/scales[selsc].length)*12)+12+startoctave;
          note(j+(i*stepsize)+(strw/2), p+tr, barsize/8, parts[i], partmode[i], 1, hicutpow, locut[i], ampshape, ampow, shape[i], lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);
          note(j+(i*stepsize)+(strw/2), p+tr, barsize/8, parts[i], partmode[i], 1, hicutpow, locut[i], ampshape, ampow, shape[i], lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);

      }
        
      }
    }
  }

  strokeWeight(1);
}
