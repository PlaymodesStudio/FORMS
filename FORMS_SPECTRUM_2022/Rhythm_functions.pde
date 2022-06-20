void gradblock(float x, float y, float w, float h, float pow){
  int strokeColor=g.strokeColor;
  for (float j=0; j<h; j++) {
          float ph=j/h;
          ph=1-((cos(ph*TWO_PI)+1)/2.);
          ph=pow(ph, pow);
          stroke(red(strokeColor), green(strokeColor), blue(strokeColor), 255*ph);
          line(x, y+j, x+w, y+j);
        }
}


void spectralGradient(float x0, float y0a, float y0b, float x1, float y1a, float y1b, float op0, float op1, float powW, float powH){
  float w=x1-x0;
  float hvarup=y1b-y0b;
  float hvardown=y1a-y0a;
  float opvar=op1-op0;
  
  for(int i=0;i<w;i++){
    float ph=i/w;
    float op=(op0+(ph*opvar));
    op=pow(op,powW);
    
    float lineh=abs((y0b+(ph*hvarup))-(y0a+(ph*hvardown)));
    float linestart=y0a+(ph*hvardown);
    for(float j=0;j<lineh;j++){
      float phj=j/lineh;
      phj=1-((cos(phj*TWO_PI)+1)/2.);
      phj=pow(phj,powH);
      stroke(255,op*255*phj);
      point(x0+i,linestart-j);
    }
  }
}

void marble3(float xpos, float ypos, float phrasesize, float num, float cntr, float pow, float h, float growh, float w, float groww, float growy ) {
  float slower=16/bars;
  float part1=1/cntr;
  float part2=1/(1-cntr);
  float stepsize=phrasesize/num;
  float powgrowh=4+random(8);
  float powgroww=4+random(8);
  float powgrowy=1+random(8);
  //powgroww=powgrowh;

  for (int i=0; i<((num+1)/part1); i++) {
    float ph=(i/(num/part1)); //phasor 0-1
    float phgrowh=pow(ph, powgrowh); //phasor per a h
    float phgroww=pow(ph, powgroww*2); //phasor per a w
    float phgrowy=pow(ph, powgrowy); //phasor per a y
    ph=pow(ph, pow); //pow phasor
    float inch=h+((phgrowh*growh)*h); //acondiciona h
    float incw=w+((phgroww*groww)*w); //acondiciona w
    float incy=((phgrowy*growy)); //acondiciona y
    ph=(num/part1)-(ph*(num/part1)); //acondiciona ph
    float x=ph*stepsize;
    block(x+xpos, (ypos-(inch/2))+incy, incw*(slower/2), inch);
  }
  for (int i=0; i<((num)/part2)-1; i++) {
    float ph=(i/(num/part2));
    float phgrowh=pow(ph, powgrowh);
    float phgroww=pow(ph, powgroww*2);
    float phgrowy=pow(ph, powgrowy); //phasor per a y
    ph=pow(ph, pow);
    float inch=h+((phgrowh*growh)*h);
    float incw=w+((phgroww*groww)*w);
    float incy=((phgrowy*growy)); //acondiciona y
    ph=ph*(num/part2);
    float x=(phrasesize/part1)+(ph*stepsize);
    block(x+xpos, ypos-(inch/2)+incy, incw*(slower/2), inch);
  }
}

void taiko3(float x, float ystart, float w, float power) {
  strokeCap(ROUND);
  strokeWeight(1);
  stroke(255);
  noFill();


  float h=height-ystart;
  for (float i=0; i<w; i++) {
    float ph=i/w;
    float ph2=1-(i/w);
    ph=pow(ph, 0.25);
    ph2=pow(ph2, power*2);
    float y2=(ph*h)+ystart;

    float h2=height-y2;
    for (float j=0; j<h2; j++) {
      float ph3=j/h2;
      ph3=pow(ph3, power/2);
      stroke(255, ph2*255*ph3);
      point(i+x, j+y2);
      point(i+x, j+y2);
    }
  }
}

void taiko2(float x, float y, float w, float y2) {
  strokeCap(ROUND);
  strokeWeight(1);
  noFill();
  float h=y2-y;
  for (float j=0; j<w; j++) {
    float ph=1-(j/w);
    ph=pow(ph, 12);
    for (float k=0; k<h; k++) {
      float ph2=(k)/(h);
      ph2=pow(ph2, 4);
      stroke(255, ph2*ph*255);
      point(x+j, k+y);
      point(x+j, k+y);
    }
  }
}

void taiko(float x, float y, float w, float h) {
  strokeCap(ROUND);
  strokeWeight(1);
  noFill();
  for (float j=0; j<w; j++) {
    float ph=1-(j/w);
    ph=pow(ph, 12);
    stroke(255, ph*255);
    for (float k=y; k<y+h; k++) {
      float ph2=(k-y)/(h);
      ph2=pow(ph2, 4);
      stroke(255, ph2*ph*255);
      point(x+j, k);
      point(x+j, k);
    }
  }
}

void hihat2(float barstart, float bardur, float num, int posy, float linelen) {
  strokeCap(PROJECT);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  int strokeColor=g.strokeColor;
  stroke(red(strokeColor), green(strokeColor), blue(strokeColor), 128);
  float strw=stepsize/4;
  strokeWeight(strw);
  float posx=barstart*barsize;
  for (float i=0; i<num; i++) {
    float inc=(bardur*barsize)/num;
    line(posx+(i*inc)+(strw/2), posy, posx+(i*inc)+(strw/2), posy+linelen);
  }
}

void hihat(float barstart, float bardur, float num) {
  strokeCap(PROJECT);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle], 128);
  float strw=stepsize/4;
  strokeWeight(stepsize/4);
  float noteheight=height/float(notegrid);
  float posx=barstart*barsize;
  float linelen=noteheight*(2+(int(random(8))));
  bardur=bardur*barsize;
  for (float i=posx; i<bardur; i+=bardur/num) {
    line(i+(strw/2), 0, i+(strw/2), linelen);
  }
}

void dots(float barstart, float bardur, float num, float numy, float posy, float h) {
  float slower=(8/bars);
  noStroke();
  int fillColor=g.fillColor;
  fill(red(fillColor), green(fillColor), blue(fillColor));
  ellipseMode(CENTER);

  float barsize=width/bars;
  float posx=barstart*barsize;
  float w=bardur*barsize;

  for (float i=0; i<w; i+=w/num) {
    for (int j=0; j<h; j+=h/numy) {
      ellipse(i+posx, j+posy, constrain(2*slower, 2, 8), 2);
    }
  }
}

void sticks2(float barstart, float bardur, float num) {
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  strokeCap(PROJECT);

  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle], 200);
  strokeWeight(stepsize/2);
  float noteheight=height/float(notegrid);
  float posx=barstart*barsize;

  float linelen=noteheight*(1+(int(random(18))));
  float posy=noteheight*int(random(notegrid-(linelen/noteheight)));
  for (float i=0; i<barsize; i+=barsize/num) {
    line(i+posx, posy, i+posx, posy+linelen);
  }
}


void sticks(int barstart, int bardur, int changetime) {
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle], 200);
  strokeWeight(stepsize/2);
  float noteheight=height/float(notegrid);
  float posx=((barsize/bardiv)*int(random(width/(barsize/bardiv))))-barsize;
  for (float j=0; j<bardur*barsize; j+=(barsize/changetime)) {
    float figs[]={0.333333333, 0.5, 0.666666666, 0.75, 1, 1.5, 1.6666666666, 2, 3, 4, 6};
    float tempo=(barsize/bardiv)*figs[int(random(figs.length))];
    float linelen=noteheight*(1+(int(random(18))));
    float posy=noteheight*int(random(notegrid-(linelen/noteheight)));
    for (float i=0; i<barsize/changetime; i+=tempo) {
      line(j+i+posx, posy, j+i+posx, posy+linelen);
    }
  }
}

void spectralblockx(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2) {
  int strokeColor=g.strokeColor;
  float noiseScale = noisesc;
  float ran=random(20000);

  for (int i=0; i<w; i++) {
    float noiseVal = prng.perlin((y+i*noiseScale), ran*noiseScale);
    noiseVal=pow(noiseVal*1.5, pow2);

    float ph=i/w;
    switch(envmode) {
    case 0://none
      ph=1;
      break;

    case 1://saw out
      ph=1-ph;
      ph=pow(ph, power);
      break;

    case 2://saw in
      ph=pow(ph, power);
      break;

    case 3: //tri
      ph=1-(abs((ph*2)-1));
      ph=pow(ph, power);
      break;
    }
    strokeCap(PROJECT);
    strokeWeight(2);
    stroke(red(strokeColor), green(strokeColor), blue(strokeColor), noiseVal*255*ph);
    line(i+x, y, i+x, y+h);
  }
}

void spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2) {
  int strokeColor=g.strokeColor;
  float noiseScale = noisesc;
  float ran=random(2000);
  for (int i=0; i<h; i++) {
    float ph2=i/h;
    ph2=1-(abs((ph2*2)-1));
    ph2=sigmoid(ph2, 0.75);
    float noiseVal = prng.perlin((x+i*noiseScale), ran*noiseScale);
    noiseVal=pow(noiseVal*1.33, pow2);
    strokeWeight(1);
    for (int j=0; j<w; j++) {
      float ph=j/w;
      switch(envmode) {
      case 0://none
        ph=1;
        break;

      case 1://saw out
        ph=1-ph;
        ph=pow(ph, power);
        break;

      case 2://saw in
        ph=pow(ph, power);
        break;

      case 3: //tri
        ph=1-(abs((ph*2)-1));
        ph=pow(ph, power);
        break;
      }

      strokeCap(PROJECT);
      strokeWeight(2);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), constrain((noiseVal*255*ph*ph2*2), 0, 255));
      point(x+j, i+y);
    }
  }
}

void spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2) {
  int strokeColor=g.strokeColor;
  float noiseScale = noisesc;
  float ran=random(2000);
  for (int i=0; i <h; i++) {
    float noiseVal = prng.perlin((x+i*noiseScale), ran*noiseScale);
    noiseVal=pow(noiseVal*1.33, pow2);
    strokeWeight(1);
    for (int j=0; j<w; j++) {
      float ph=j/w;
      switch(envmode) {
      case 0://none
        ph=1;
        break;

      case 1://saw out
        ph=1-ph;
        ph=pow(ph, power);
        break;

      case 2://saw in
        ph=pow(ph, power);
        break;

      case 3: //tri
        ph=1-(abs((ph*2)-1));
        ph=pow(ph, power);
        break;
      }

      strokeCap(PROJECT);
      strokeWeight(2);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), noiseVal*255*ph);
      point(x+j, i+y);
    }
  }
}

void spectralblock(float x, float y, float w, float h, float noisesc, int envmode, float power) {
  int strokeColor=g.strokeColor;
  float noiseScale = noisesc;
  float ran=random(2000);
  for (int i=0; i <h; i++) {
    float noiseVal = prng.perlin((x+i*noiseScale), ran*noiseScale);
    noiseVal=pow(noiseVal*1.33, 6);
    strokeWeight(1);
    for (int j=0; j<w; j++) {
      float ph=j/w;
      switch(envmode) {
      case 0://none
        ph=1;
        break;

      case 1://saw out
        ph=1-ph;
        ph=pow(ph, power);
        break;

      case 2://saw in
        ph=pow(ph, power);
        break;

      case 3: //tri
        ph=1-(abs((ph*2)-1));
        ph=pow(ph, power);
        break;
      }

      strokeCap(PROJECT);
      strokeWeight(2);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), noiseVal*255*ph);
      point(x+j, i+y);
    }
  }
}

void noiseblock(float barpos, float w, float gateprob) {
  strokeWeight(1);
  strokeCap(ROUND);
  float noteheight=height/float(notegrid);
  float barsize=width/bars;
  float posx=barpos*barsize;
  w=barsize*w;
  float h=noteheight*(4+(int(random(24))));
  float posy=noteheight*int(random((notegrid/1.5)));
  int points=(int(w*100)/2)+(int(random((int(w*100)/2))));
  noStroke();
  rectMode(CORNER);
  fill(0);
  if (random(100)<gateprob) {
    rect(posx, 0, w, height);
  }
  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle], 192);
  for (int i=0; i<points; i++) {
    point(random(w)+posx, random(h)+posy);
  }
}

void block(float x, float y, float w, float h) {

  noStroke();
  rectMode(CENTER);
  rect(x+(w/2), y+(h/2), w, h);
  rectMode(CORNER);
}

void thump3(float barpos, float bardur, float num, float prob) {
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  noFill();
  float posx=barsize*barpos;
  float w=bardur*barsize;
  float sep=w/num;

  if (random(100)<prob) {
    for (float i=0; i<num; i++) {
      stroke(255);
      taiko2(posx+(sep*i), 400, stepsize*8, height);
    }
  }
}

void thump2(float barpos, float bardur, float num, float prob) {
  strokeWeight(2);
  noFill();
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float len=noteheight*18;
  float posx=barsize*barpos;
  float w=bardur*barsize;
  float sep=w/num;

  if (random(100)<prob) {
    for (float i=0; i<num; i++) {
      //stroke(customColour[toggle]);
      stroke(255);
      line(posx+(sep*i), height-len, posx+(sep*i)+1, height);
      for (int j=0; j<sep; j++) {
        float ph=1-(j/sep);
        ph=pow(ph, 2);
        //stroke(customColour[toggle],(ph*255));
        stroke(255, ph*255);
        line((posx+(sep*i)+1)+j, height-(noteheight/4), (posx+(sep*i)+1)+j, height);
      }
    }
  }
}

void thump(float period, int prob, int p) {
  int toggle =int(random(ncol));
  strokeWeight(2);
  noFill();
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float posx=barsize;
  float note=p;

  for (int i=0; i<bars*period; i++) {
    int dice=int(random(100));
    if (dice<prob) {
      //stroke(customColour[toggle]);
      stroke(255);
      line(i*barsize/period, height-(noteheight*24), (i*barsize/period)+(16/bars), height-(note*noteheight));
      for (int j=0; j<(barsize/period); j++) {
        float ph=1-(j/((barsize/period)));
        ph=pow(ph, 2);
        //stroke(customColour[toggle],(ph*255));
        stroke(255, ph*255);
        point((i*barsize/period)+j+1, height-(note*noteheight));
      }
    }
  }
}

void klank(float x, float y, float h, float w, float pow) {
  int toggle =int(random(ncol));
  int fillColor=g.fillColor;
  strokeWeight(1);
  noFill();

  for (float j=0; j<w; j++) {
    float ph=1-(j/w);
    ph=pow(ph, pow);
    stroke(red(fillColor), green(fillColor), blue(fillColor), ph*255*0.75);
    line(x+j, y, x+j, y+h);
  }
}

void clank(float barpos, float w) {
  float noteheight=height/float(notegrid);
  float barsize=width/bars;
  float posx=barpos*barsize;
  w=barsize*w;
  float h=noteheight*(2+(int(random(8))));
  float posy=noteheight*int(random((notegrid/1.5)));
  int toggle =int(random(ncol));
  strokeWeight(1);
  noFill();

  for (float j=0; j<w; j++) {
    float ph=1-(j/w);
    ph=pow(ph, 12);
    stroke(customColour[toggle], ph*255*0.75);
    line(posx+j, posy, posx+j, posy+h);
  }
}


void snare3(float barpos, float bardur, float num, float prob) {
  strokeWeight(1);
  noFill();
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float posx=barpos*barsize;
  float note=scale[int(random(scales[selsc].length/2))];
  float w=barsize*bardur;
  float sep=w/num;
  float len=int(random(50, 250));
  float posy=int(random(200, 400));

  for (float i=0; i<num; i++) {

    float xpos=(posx+(i*sep));
    if (random(100)<prob) {
      for (float j=0; j<w; j++) {
        float ph=1-(j/w);
        ph=pow(ph, 12);
        for (float k=posy; k<posy+len; k++) {
          float ph2=(k-posy)/(len);
          ph2=pow(ph2, 2);
          stroke(255, ph2*ph*255*0.5);
          point(xpos+j, k);
          point(xpos+j, k);
          point(xpos+j, k);
        }
      }
    }
  }
}

void snare2(float barpos, float bardur, float num, float prob) {
  int toggle =int(random(ncol));
  strokeWeight(1);
  noFill();
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float posx=barpos*barsize;
  float note=scale[int(random(scales[selsc].length/2))];
  float w=barsize*bardur;
  float sep=w/num;
  float len=int(random(50, 250));
  float posy=int(random(200, 400));

  for (float i=0; i<num; i++) {

    float xpos=(posx+(i*sep));
    if (random(100)<prob) {
      for (float j=0; j<w; j++) {
        float ph=1-(j/w);
        ph=pow(ph, 12);
        stroke(customColour[toggle], ph*255*0.5);
        //line(xpos+j,150,xpos+j/2,500);
        for (float k=posy; k<posy+len; k++) {
          float ph2=(k-posy)/(len);
          ph2=pow(ph2, 2);
          stroke(customColour[toggle], ph2*ph*255*0.5);
          point(xpos+j, k);
        }
      }
    }
  }
}
void snare(float period, int prob, float bardur) {
  int toggle =int(random(ncol));
  strokeWeight(2);
  noFill();
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float posx=barsize;
  float note=scale[int(random(scales[selsc].length/2))];

  for (int i=0; i<bars*period; i++) {
    float len=int(random(50, 250));
    float posy=int(random(200, 400));
    int dice=int(random(100));
    float xpos=(i*(barsize/period))+((barsize/period)/2);
    if (dice<prob) {
      int wide=int(barsize*bardur);
      //stroke(255);
      //line(xpos,posy,xpos,posy+len);
      for (float j=0; j<wide; j++) {
        float ph=1-(j/wide);
        ph=pow(ph, 12);
        //stroke(customColour[toggle],ph*255*0.5);
        stroke(255, ph*255*0.75);
        //line(xpos+j,150,xpos+j/2,500);
        //line(xpos+j,posy,xpos+j,posy+len);
        for (float k=posy; k<posy+len; k++) {
          float ph2=(k-posy)/(len);
          ph2=pow(ph2, 2);
          //stroke(customColour[toggle],ph2*ph*255*0.5);
          stroke(255, ph2*ph*255*0.75);
          point(xpos+j, k);
          point(xpos+j, k);
        }
      }
    }
  }
}

void zap(float posx, float bardur) {
  int toggle =int(random(ncol));
  strokeWeight(2);
  noFill();
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float wide=int(barsize*bardur);
  float xpos=(posx*barsize)-wide;
  float note=scale[int(random(scales[selsc].length/2))];
  float len=int(random(50, 250));
  float posy=int(random(200, 400));

  for (float j=0; j<wide; j++) {
    float ph=(j/wide);
    ph=pow(ph, 12);
    stroke(customColour[toggle], ph*255*0.5);
    //line(xpos+j,150,xpos+j/2,500);
    for (float k=posy; k<posy+len; k++) {
      float ph2=(k-posy)/(len);
      ph2=pow(ph2, 2);
      stroke(customColour[toggle], ph2*ph*255*0.5);
      point(xpos+j, k);
    }
  }
}

void hat(int posx, float h, float vel, float dur) {
  float barsize=width/bars;
  float stepsize=(barsize/bardiv);
  dur=stepsize*dur;
  strokeWeight(stepsize/2);
  strokeCap(PROJECT);
  for (float i=0; i<dur; i++) {
    float ph=1-(i/dur);
    ph=pow(ph, 8);
    stroke(255, 255*ph*vel);
    line(posx+i, 0, posx+i, h);
  }
}

void marble2(float barstart, int bardur, float y, float sizey, float num, float modey, float dir, float ydir, float ldir, float maxstroke) {
  float slower=16/bars;

  float noteheight=height/float(notegrid);
  float barsize=(width/bars);
  float xstart=barsize*barstart;
  float off=0;

  float sizex=(barsize*bardur);
  if ((xstart+sizex)>width) {
    sizex=width-sizex;
  }
  float x=xstart+off;
  float yoff=0;
  float loff=0;
  float pow=random(2, 6);
  float ypow=random(1, 6);
  float lpow=random(1, 6);

  for (float i=0; i<num; i++) {

    yoff=i/num;
    yoff=abs(ydir-(pow(yoff, ypow)));
    yoff=yoff*sizey;

    off=(i/num);
    off=abs(dir-(pow(off, pow)));
    off=off*num*(sizex/num);

    loff=i/num;
    loff=abs(ldir-(pow(loff, lpow)));
    loff=loff*255;

    strokeCap(ROUND);
    float ph=pow(i/num, pow*6);
    float strokegrow=1.5+(ph*maxstroke);
    strokeWeight(strokegrow*slower);
    fill(255);

    if (modey==1) {
      //line(x+off+(strokegrow/2), y-yoff, x+off+(strokegrow/2), y+yoff);
      rect(x+off+(strokegrow/2), y-yoff, strokegrow*slower, yoff*2);
    } else {
      //line(x+off+(strokegrow/2), y-sizey/2, x+off+(strokegrow/2), y+sizey-sizey/2);
      rect(x+off+(strokegrow/2), y-sizey/2, strokegrow*slower, sizey);
    }
    strokeCap(ROUND);
  }
}

void marble(float barstart, int bardur) {
  float noteheight=height/float(notegrid);
  float barsize=(width/bars);
  float xstart=barsize*barstart;
  float off=((barsize/2)*int(random(2)));
  off=0;

  float sizex=(barsize*bardur)-off;
  if ((xstart+sizex)>width) {
    sizex=width-sizex;
  }
  float sizey=random(noteheight, noteheight*12);
  float x=xstart+off;
  float y=sizey+random(height-(sizey*2)-200);
  float num=random(10, 75);
  float yoff=0;
  float loff=0;
  float pow=random(2, 6);
  float ypow=random(1, 6);
  float lpow=random(1, 6);
  float dir=int(random(2));
  float ydir=int(random(2));
  float ldir=int(random(2));
  int modey=int(random(100));
  int model=int(random(100));
  selectstrokecolor();

  for (float i=0; i<num; i++) {

    yoff=i/num;
    yoff=abs(ydir-(pow(yoff, ypow)));
    yoff=yoff*sizey;

    off=(i/num);
    off=abs(dir-(pow(off, pow)));
    off=off*num*(sizex/num);

    loff=i/num;
    loff=abs(ldir-(pow(loff, lpow)));
    loff=loff*255;

    strokeCap(PROJECT);
    float ph=pow(i/num, pow*8);
    float strokegrow=ph*(bardur*4);
    strokeWeight(1.5+strokegrow);

    if (model>100) {
      stroke(255, loff);
    } else {
    }

    if (modey<75) {
      line(x+off, y-yoff, x+off, y+yoff);
    } else {
      line(x+off, y, x+off, y+sizey);
    }
    strokeCap(ROUND);
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////
void r1_general() { //general rich rhythm

  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //sticks
  if (random(100)<50) {
    for (int i=0; i<bars; i++) {
      if (random(100)<50) {
        float nums[]={2.66666, 3, 4, 5.333333, 6, 8, 12, 16, 24};
        float n=nums[int(random(nums.length))];
        sticks2(i, 1, n);//sticks2(float barstart, float bardur,float num)
      }
    }
  }

  //hihats
  hihat(0, bars, (bars*bardiv)/(int(random(2))+1));

  //euclidean hats
  if (random(100)<50) {
    int hatnum=int(random(10));
    for (int i=0; i<hatnum; i++) {
      int h=int(random(8))+1;
      int steps[]={7, 8, 9, 11, 12, 16};
      int fills[]={2, 3, 4, 5};
      float divs[]={1, 2};
      int step=steps[int(random(steps.length))];
      int fill=fills[int(random(fills.length))];
      float div=divs[int(random(divs.length))];
      eurhythm(0, bars, div, 12+(i*(notegrid/hatnum)), h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
    }
  }

  //kicks
  int periode=(int(random(2))+1)*(int(random(2))+1);
  int rndmp=400;

  for (int i=0; i<width; i+=((width/bars))/periode) {
    taiko(i, rndmp, stepsize*8, height-rndmp); //xywh
    taiko(i, rndmp, stepsize*8, height-rndmp); //xywh
    taiko(i, rndmp, stepsize*8, height-rndmp); //xywh
    taiko(i, rndmp, stepsize*8, height-rndmp); //xywh
  }

  //roll
  float slower=16/bars;
  if (random(100)<50) {
    int toggle =int(random(ncol));
    fill(customColour[toggle]);
    float len=(width/bars)/8;
    float num=4;
    for (int i=0; i<bars; i++) {
      if (random(100)<25) {
        for (int j=0; j<num; j++) {
          block(((i*barsize)-len)+(j*(len/num)), 200, 2*slower, 100);
        }
      }
    }
  }

  //gate fx
  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<50) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }


  snare(int(random(2))+1, 100, int(random(3))+1);


  // reverse snare (zap)
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(4))+1));//zap(float posx, float bardur)
    }
  }

  //noiseblocks
  if (random(100)<50) {
    for (int i=0; i<bars; i++) {
      if (random(100)<50) {
        float ranshift=0.125*(1+int(random(7)));
        noiseblock(i+ranshift, 1-ranshift, 50);  //(float barpos, float w)
      }
    }
  }

  //clanks

  for (int i=0; i<bars; i++) {
    if (random(100)<50) {
      float ranshift=0.125*(1+int(random(7)));
      clank(i+ranshift, 1-ranshift);  //(float barpos, float w)
    }
  }

  //points
  if (random(100)<50) {
    //pointchords(0.25, bars, 2, 3, 2, 8); //void pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  }
}

void r2_fencesUngrouped() { //filtered noise, static period
  float barsize=width/(bars*8);
  for (int i=0; i<bars*8; i++) {
    int toggle =int(random(ncol));
    fill(customColour[toggle]);
    float h=50+random(300);
    float y=random(height-h);
    float w=barsize/(int(random(4))+1);
    block(i*barsize, y, w, h);
    //block(i*barsize, 100, 10, 100);
  }
}

void r3_fencesUngroupedWeights() { //filtered noise, new period every bar
  //pointchords(0.25, bars, 2, 3, 2, 8); //void pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  float barsize=width/bars;
  for (int i=0; i<bars; i++) {
    int toggle =int(random(ncol));
    fill(customColour[toggle]);
    float h=50+random(300);
    float y=random(height-h);
    float nums[]={1, 2, 2.66666, 4, 5.333333, 8, 16};
    float n=nums[int(random(nums.length))];
    for (float j=0; j<n; j++) {
      float w=(barsize/n)/4;
      block((i*barsize)+((barsize/n)*j), y, w, h);
    }
  }
}

void r4_fencesUngroupedWeights2() { //filtered noise, new period every bar, random y
  //  pointchords(0.25,bars,2,3,2,8); //void pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  float barsize=width/bars;
  for (int i=0; i<bars; i++) {
    int toggle =int(random(ncol));
    fill(customColour[toggle]);

    float nums[]={1, 2, 2.66666, 4, 5.333333, 8, 16};
    float n=nums[int(random(nums.length))];
    for (float j=0; j<n; j++) {
      float h=50+random(300);
      float y=random(height-h);
      float w=(barsize/n)/4;
      block((i*barsize)+((barsize/n)*j), y, w, h);
    }
  }
}

void r5_bells() {//bells
  /*
  if(random(100)<50){
   perlin(1,0.4);
   hole(0);
   }
   */
  strokeWeight(1);
  float barsize=width/bars;
  for (int i=0; i<bars; i++) {
    float nums[]={1, 2, 2.66666, 4, 5.33333, 8};
    float n=nums[int(random(nums.length))];
    for (int k=0; k<n; k++) {
      int toggle =int(random(ncol));
      stroke(customColour[toggle], 255);
      int len=int((barsize*8)/(1+(random(8))));
      int partials=8+int(random(50));
      int rng=50+int(random(height/2));
      int y=int(random(height-rng));
      float power=1+random(8);
      for (int j=0; j<partials; j++) {
        int x=int((barsize*i)+((barsize/n)*k));
        if ((x+len)<width) {
          if (random(100)<50) {
            linesaw(x, int(random(rng))+y, len, power, 1);
          }
        }
      }
    }
  }
}

void r6_euclideanFencesSpectral() {//euclidean anything
  //euclidean(int idx, int steps, int fills, int shift)
  strokeWeight(1);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  fill(255);
  int steplen=16;
  int steps=int(random(5, 16));
  float stepw=(barsize/steplen);
  float phraselen=stepw*steps;
  int phrasenum=4;
  float blocklen=phraselen*phrasenum;
  for (int k=0; k<8; k++) {
    int fills=2+int(random(steps-2));
    int toggle =int(random(ncol));
    stroke(customColour[toggle]);
    fill(customColour[toggle]);



    for (int j=0; j<phrasenum; j++) {
      float h=100+random(600);
      float y=random(400);
      float len=random(1, 4);
      for (int i=0; i<steps; i++) {
        float sc=random(0.0001, 0.02);
        if (euclidean(i, steps, fills, 0)==1) {
          float x=(i*stepw)+(j*(phraselen)+(k*blocklen));
          //for (int l=0; l<h; l++) {
          spectralblockc(x, y, (phraselen/fills)*len, h, sc, 1, 8, random(2, 4));
          //}
        }
      }
    }
  }



  //kick
  /*
  int rndmp=300;
   int rndmthin=300;
   for (int i=0; i<width; i+=barsize*4) {
   
   taiko(i, rndmp, stepsize*16*2, height-rndmp); //xywh
   taiko(i, rndmp, stepsize*16*2, height-rndmp); //xywh
   taiko(i, rndmp, stepsize*16*2, height-rndmp); //xywh
   }
   */


  //dots
  /*
  if (random(100)<75) {
   for (int i=0; i<bars; i++) {
   float nums[]={8, 12, 16, 24, 32};
   float n=nums[int(random(nums.length))];
   float h=100+random(200);
   float y=random(height-h);
   fill(255);
   if (i%4==0) {
   } else {
   if (random(100)<25) {
   dots(i, 1, n, int(random(8, 24)), y, h);
   }
   }
   }
   
   //dots(float barstart, float bardur, float num, float numy, float posy, float h)
   }
   */
}

void r7_fillsDots() {//random fills
  float slower=16/bars;
  int y=0;
  int strokeColor=g.strokeColor;
  stroke(red(strokeColor), green(strokeColor), blue(strokeColor));
  strokeWeight(1);
  int stepnum=3+int(random(6));
  int[] fills = new int[stepnum];
  for (int i=0; i<stepnum; i++) {
    float ran=random(1);
    ran=pow(ran, 1.5);
    fills[i]=round(ran);
  }
  float barsize=width/bars;
  float stepsize=(barsize/16);
  int toggle =int(random(ncol));
  fill(customColour[toggle]);
  int repeats=1+int(random(8));
  float phrasesize=stepsize*stepnum;
  repeats=int(width/phrasesize);
  int h=20+int(random(80));
  y=200+int(random(200-h))+h;
  int seed=int(random(10000));
  int sign=int(random(3))-1;
  int steps=3+int(random(6));
  int posy=int(random(350));
  int ranh=80+int(random(300));
  noStroke();
  float ranw=(stepsize*2)+(stepsize*random(2));
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        //taiko(j+(i*stepsize), 150+posy, ranw, ranh); //xywh
        rect(j+(i*stepsize), 150+posy, stepsize/2, h);
      }
    }
  }


  fill(255);
  float inc=1;
  for (float i=0; i<bars; i+=inc) {
    inc=(int(random(2))+1)/(int(random(2))+1);
    float nums[]={2, 4, 8, 12, 16};
    float n=nums[int(random(nums.length))];
    float h2=50+random(150);
    float y2=random(y-h2-50);
    //dots(float barstart, float bardur, float num, float numy, float posy, float h)
    if (random(100)<25) {
      dots(i, inc, n*inc, int(random(8, 24)), y2, h2);
    }
    h2=100+random(200);
    y2=y+100+random(height-h2-100);
    if (random(100)<40) {
      dots(i, inc, n*inc, int(random(8, 24)), y2, h2);
    }
  }



  float nums[]={32, 64, 128};
  float n=nums[int(random(nums.length))];
  float h2=25+random(100);
  float y2=y+150+random(height-y-100-h2);
  dots(0, bars, n, int(random(2, 8)), y2, h2);
}

void r8_marblesNew() { //caniques skew
  stroke(255);
  strokeWeight(2);
  float barsize=float(width)/bars;
  float phrasesize=barsize*(int(random(2))+1);
  float inc=phrasesize;
  for (float i=0; i<width; i+=inc) {
    inc=phrasesize*(1+(int(random(bars/2))));
    if ((i+inc)<width) {
      if (random(100)<66) {
        int toggle =int(random(ncol));
        fill(customColour[toggle]);
        marble3(i, random(800)+100, inc, 8+random(96), abs((1*int(random(2)))-(random(1)*int(random(2)))), 1+random(12), 20+random(100), random(4)*int(random(2)), 2, random(8), random(200)*int(random(2)));
      }
    }
  }
}

void r9_marblesOld() { //caniques old rework

  float slower=16/bars;
  int num=int(random(3));
  int dur=1;
  int sizevar=int(random(2));
  int strokevar=int(random(2));
  int modey=int(random(2));
  int y=0;

  for (int i=0; i<bars; i+=dur) {
    selectstrokecolor();
    dur=2*(1+int(random(2)))*1+int(random(2))*1+int(random(2))*1+int(random(2));
    if (modey==0) {
      y=540;
    } else {
      y=int(random(150, 900));
    }
    if (random(100)<75) {
      marble2(i, dur, y, random(50, 200), 8+random(60), int(random(2))*sizevar, int(random(2)), int(random(2)), int(random(2)), random(30)*strokevar);
    }
  }
}

void r10_dub() { //dub complete

  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(4))+1));//zap(float posx, float bardur)
    }
  }

  //hihats
  hihat(0, bars, (bars*bardiv)/2);


  //roll
  if (random(100)<50) {
    int toggle =int(random(ncol));
    fill(customColour[toggle]);
    float len=(width/bars)/8;
    float num=4;
    for (int i=0; i<bars; i++) {
      if (random(100)<25) {
        for (int j=0; j<num; j++) {
          block(((i*barsize)-len)+(j*(len/num)), 200, stepsize/4, 100);
        }
      }
    }
  }

  //sticks
  for (int i=0; i<bars; i++) {
    int toggle =int(random(ncol));
    fill(customColour[toggle], 192);
    float h=50+random(300);
    float y=random((height/1.5)-h);
    float nums[]={1, 2, 2.66666, 4, 5.333333, 8, 16};
    float n=nums[int(random(nums.length))];
    if (random(100)<50) {
      for (float j=0; j<n; j++) {
        block((i*barsize)+((barsize/n)*j), y, stepsize/2, h);
      }
    }
  }

  resetcolors();
  //clanks
  for (int i=0; i<bars; i++) {
    if (random(100)<75) {
      float ranshift=0.125*(1+int(random(7)));
      clank(i+ranshift, 1-ranshift);  //(float barpos, float w)
    }
  }
  resetcolors();
  //noiseblocks
  if (random(100)<50) {
    for (int i=0; i<bars; i++) {
      if (random(100)<50) {
        float ranshift=0.125*(1+int(random(7)));
        noiseblock(i+ranshift, 1-ranshift, stepsize*8);  //(float barpos, float w)
      }
    }
  }

  //gateFX
  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<33) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  //taiko kicks
  for (int i=0; i<width; i+=((width/bars))) {
    taiko(i, 300, stepsize*16, 780);
  }
  taiko(0, 300, stepsize*32, 780);

  //snare
  float snrws[]= {0.125, 0.25, 0.5, 1};
  float snw=snrws[int(random(snrws.length))];
  snare(1, 100, snw);


  //snare2
  stroke(255, 255);
  for (int i=0; i<width; i+=barsize*4) {
    if (random(100)<50) {
      spectralblock(i+(3.5*barsize), 250+random(200), barsize*4, 100+random(400), 0.02, 1, 8);
    }
  }

  //rhythmic freeze
  for (float i=0; i<bars; i+=0.5) {
    float ranshift=0.125+(0.125*(int(random(3))+1));
    if (random(100)<33) {
      freeze(i+ranshift, 0.5-ranshift);//freeze(float barposx, float barlen)
    }
  }

  //beatrepeat A
  if (random(100)<50) {
    float inc=1;
    float count=0;
    float add=0;
    for (float i=0; i<bars; i+=inc) {
      float sign=((i%2)*2)-1;
      float mult=int(random(2))+1;
      float divs[]={1, 1.3333, 2, 2.6666, 4, 5.3333, 8, 12, 16};
      float temp=divs[int(random(divs.length))];
      float len[]={0.5, 1};
      float l=len[int(random(len.length))];
      if (random(100)<33) {
        beatRepeat2(count+add, inc, temp*l, 0.666, 0); //beatRepeat2(float barposx, float bardur, float num, float gate, float semitones)
      }
      count+=inc;
      inc=l;
    }
  }

  //open klank
  if (random(100)<50) {
    klank((1*(barsize*8))-(barsize*0.5), 100+random(300), 100+random(400), barsize*4, 12);
  }
}

void r11_UKBreaks() {//hip-hop rhythms
  int seed=int(random(1000));
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //some melodic ambience
  int toggle =int(random(ncol));
  selectstrokecolor();


  //block rhythms
  for (int i=0; i<bars; i++) {
    fill(customColour[toggle], 128);
    float h=50+random(200);
    float y=random((height/2)-h);
    float nums[]={2.66666, 5.333333, 10.6666, 12, 16};
    float n=nums[int(random(nums.length))];
    if (random(100)<50) {
      for (float j=0; j<n; j++) {
        block((i*barsize)+((barsize/n)*j), y, stepsize/4, h);
      }
    }
  }

  //hihat
  selectstrokecolor();
  float vartime=0.5;
  for (float i=0; i<bars; i+=vartime) {
    float nums[]={2, 4};
    float n=(nums[int(random(nums.length))]);
    hihat2(i, vartime, n/vartime, 50, 50);
  }
  //open hat
  selectcolor();
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<25) {
      klank((i*barsize)+(barsize/8), 50, 100, stepsize*16, 12); //xyhwp
    }
  }

  //upbeat drums
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<8; i++) {
      int eval=randomfills(i-1, 7, seed);
      if ((eval==1)&&(i!=2)&&(i!=6)) {
        taiko(j+(i*stepsize), 300, stepsize*8, 780);
      }
    }
  }

  //gatefx
  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<33) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  //roll
  if (random(100)<25) {
    toggle =int(random(ncol));
    fill(customColour[toggle]);
    float len=(width/bars)/8;
    float num=4;
    for (int i=0; i<bars; i++) {
      if (random(100)<25) {
        for (int j=0; j<num; j++) {
          block(((i*barsize)-len)+(j*(len/num)), 200, stepsize/4, 100);
        }
      }
    }
  }

  //snare
  fill(255);
  for (int i=0; i<width; i+=((width/bars))) {
    klank(i+((width/bars)/4), 300, 200, stepsize*16, 12); //xyhwp
    klank(i+(((width/bars)/4)*3), 300, 200, stepsize*16, 12); //xyhwp
  }

  //downbeat drum
  for (int i=0; i<width; i+=((width/bars))) {
    taiko(i, 300, stepsize*8, 780);
  }



  //cool zaps
  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      int mult=int(random(2))+1;
      int div2=int(random(2))+1;
      zap(i+0.75, (0.75*mult)/div2);//zap(float barpos, float bardur)
    }
  }

  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      int mult=int(random(2))+1;
      int div2=int(random(2))+1;
      zap(i, mult/div2);//zap(float barpos, float bardur)
    }
  }

  //freeze
  for (float i=0; i<bars; i+=1) {
    float ranshift=0.0625*((int(random(4))+1));
    if (random(100)<25) {
      freeze(i-ranshift, ranshift);//freeze(float barposx, float barlen)
    }
  }
}

void r12_fullEuclidean() { //full euclidean
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  int h=0;
  int prevh=0;
  for (int i=0; i<24; i++) {
    h=int(random(8))+1;
    int steps[]={7, 8, 9, 11, 12, 16};
    int fills[]={2, 3, 4, 5};
    float divs[]={1, 2};
    int step=steps[int(random(steps.length))];
    int fill=fills[int(random(fills.length))];
    float div=divs[int(random(divs.length))];
    if (random(100)<60) {
      eurhythm(0, bars, div, prevh, h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
    }
    prevh=prevh+h;
  }



  //freeze
  for (int i=0; i<bars; i++) {
    float ranshift=0.5+(0.125*(1+int(random(2))));
    if (random(100)<33) {
      freeze(i+ranshift, 1-ranshift);
    }
  }


  //gate
  for (int i=0; i<bars; i++) {
    float ranshift=0.5+(0.125*(1+int(random(2))));
    if (random(100)<50) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  for (int i=0; i<width; i+=((width/bars))) {
    taiko(i, 300, stepsize*8, 780);
  }
  if (random(100)<75) {
    snare(1, 100, 1);
  }
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=(0.125*(1+int(random(7))));
    if (random(100)<20) {
      noiseblock(i+ranshift, 1-ranshift, 50);
    }
  }
  for (int i=0; i<bars; i++) {
    float ranshift=(0.125*(1+int(random(2))));
    if (random(100)<20) {
      noiseblock(i+ranshift, 0.5-ranshift, 50);
    }
  }

  //beratrepeat B
  if (random(100)<50) {
    for (int i=0; i<bars; i++) {
      float ranshift=0.25*(1+int(random(3)));
      float divs[]={2, 2.6666, 4, 5.3333, 8};
      float temp=divs[int(random(divs.length))];
      if (random(100)<33) {
        beatRepeat2(i+ranshift, 1-ranshift, temp, 0.666, 0);
      }
    }
  }
}

void r13_techno() { //techno
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //hihat

  selectstrokecolor();
  float vartime=0.5;
  float lenvar=random(60);
  float lenvar2=random(50);
  float posvar=random(100);
  float posvar2=random(100);
  float powvar=int(random(10));
  if (random(100)<50) {
    for (float i=0; i<bars; i+=vartime) {
      float nums[]={4};
      float n=(nums[int(random(nums.length))]);
      hihat2(i, vartime, n/vartime, 50+int(posvar2), 30+lenvar2);
    }
  }
  //open hat
  if (random(100)<50) {
    selectcolor();
    for (float i=0; i<bars; i+=0.25) {
      if (random(100)<100) {
        klank((i*barsize)+(barsize/8), 50+posvar, 20+lenvar, stepsize*16, 10+powvar); //xyhwp
      }
    }
  }
  selectstrokecolor();
  //spectralzap
  for (float i=0; i<bars; i+=4) {
    float zaph=random(height/2);
    float zapy=random(height-zaph);
    int div2=int(random(2))+1;
    if (random(100)<50) {
      spectralblockb(i*barsize, zapy, barsize*4, zaph, 0.03, 2, 12, 6);
      spectralblockb(i*barsize, random(height/2), barsize*4, 50+random(height/8), 0.03, 1, 20, 6);
      //void spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power) {
    }
  }
  selectstrokecolor();




  //snare
  fill(255);
  float snrw=(stepsize*2)+(stepsize*(random(16)));
  float yvar=random(350);
  float hvar=random(250);
  float pvar=random(10);
  for (int i=0; i<width; i+=((width/bars))) {
    klank(i+((width/bars)/4), 150+yvar, 50+hvar, snrw, 10+pvar); //xyhwp
    klank(i+(((width/bars)/4)*3), 150+yvar, 50+hvar, snrw, 10+pvar); //xyhwp
  }

  //noiseblocks
  for (float i=0; i<bars; i+=0.5) {
    float ranshift=(0.0625*(1+int(random(2))));
    if (random(100)<25) {
      noiseblock(i-ranshift, ranshift, 50);
    }
  }

  //random polyrhythm
  int seed=int(random(1000));
  int steps=3+int(random(6));
  int posy=int(random(350));
  int ranh=80+int(random(300));
  float ranw=(stepsize*2)+(stepsize*random(2));
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        taiko(j+(i*stepsize), 150+posy, ranw, ranh); //xywh
      }
    }
  }

  //cool zaps
  for (float i=0; i<bars; i++) {
    if (random(100)<33) {
      int div2=int(random(2))+1;
      zap(i+0.75, (0.75)/div2);//zap(float barpos, float bardur)
    }
  }

  //kickdrum
  float power=int(random(8))+3;
  float wi=stepsize*(int(random(4))+4);
  float uai=int(random(200));
  for (int i=0; i<width; i+=((width/bars))/4) {
    taiko3(i, -uai, wi, power); //xywh
  }

  int parts=int(random(4))+4;
  int root=int(random(2))*12;
  for (float i=0; i<bars; i+=0.25) {
    additive2(-root, i, 8, parts, 0, 1, 3, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }
}

void r14_ikeda() {//spectral rhythmic blocks

  float barsize=width/bars;
  float inc=0.5;
  if (random(100)<50) {
    for (float i=0; i<bars; i+=inc) {
      inc=0.5/((int(random(2))+1)*(int(random(2))+1));
      float nums[]={4, 8, 16};
      float n=nums[int(random(nums.length))];
      int h=int(random(100, height/2));
      int y=int(random(100, height-h-200));
      if (random(100)<85) {
        for (float j=0; j<(n*inc); j++) {
          if (random(100)<85) {

            float sc=0.05/random(10);
            float w=((barsize*inc)/(n*inc))/2;
            stroke(255);
            spectralblock((i*barsize)+((barsize/(n))*j), y, w, h, sc, 0, 1);
          }
        }
      }
    }
  } else {
    float nums[]={4, 8, 16};
    float n=nums[int(random(nums.length))];
    for (float i=0; i<bars; i++) {
      if (random(100)<100) {
        for (float j=0; j<n; j++) {
          int h=int(random(100, height/2));
          int y=int(random(100, height-h-100));
          if (random(100)<75) {
            float sc=0.05/random(10);
            float w=(barsize/n)/(2/random(2));
            stroke(255);
            spectralblock((i*barsize)+((barsize/n)*j), y, w, h, sc, 0, 4);
          }
        }
      }
    }
  }
  //t3_clouds();
  //r9_marblesOld();
}

void r15_spectralBreathe() {//spectral periodic mass blocks
  float barsize=width/bars;
  float nums[]={0.5, 1, 2, 4, 8, 16};
  float n=nums[int(random(nums.length))];
  int envclass=int(random(2));
  int envmode=int(random(4));
  for (float i=0; i<bars; i++) {
    if (random(100)<100) {
      for (float j=0; j<n; j++) {
        int h=height;
        int y=0;
        if (random(100)<75) {
          float pow=1+int(random(6));
          float sc=0.05/random(10);
          float w=(barsize/n);
          stroke(50+int(random(205)));
          if (envclass==1) {
            envmode=1+int(random(3));
          }
          spectralblock((i*barsize)+((barsize/n)*j), y, w, h, sc, envmode, pow);
        }
      }
    }
  }
  //t3_clouds();
}

void r16_qebrus() {//qebrus
  strokeCap(ROUND);
  float barsize=width/bars;
  float nums[]={1, 2, 6, 8, 12, 16, 16, 24};
  float n=nums[int(random(nums.length))];
  float incs[]={1, 0.5, 0.25, 0.125, 0.0625};
  float inc=incs[int(random(incs.length))];

  int envclass=int(random(2));
  int envmode=int(random(4));

  int tonemasking=int(random(2));


  for (float i=0; i<bars; i+=inc) {
    if (random(100)<85) {
      n=nums[int(random(nums.length))];
      inc=incs[int(random(incs.length))];
      for (float j=0; j<n*inc; j++) {
        if (random(100)<100) {
          int h=height;
          int y=0;
          float pow=2+int(random(6));
          float sc=0.05/random(10);
          float w=(barsize/n)/(1+random(1));
          stroke(50+int(random(205)));
          if (envclass==1) {
            envmode=1+int(random(3));
          }
          spectralblock((i*barsize)+((barsize/n)*j), y, w, h, sc, envmode, pow);
          if (random(100)<33*tonemasking) {

            hole4((i*barsize)+((barsize/n)*j), w, 1, 0);//hole3(float x, float w, int strokew)
          }
        }
      }
    }
  }
}

void r17_batucada() { //euclidean spectral
  strokeCap(ROUND);
  float barsize=width/bars;

  for (int j=0; j<bars; j++) {
    int steps=16;

    int fillslist[]={3, 4, 5, 6, 7, 9}; //6
    int fills=fillslist[int(random(fillslist.length))];

    float stepw=barsize/steps;


    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          float sc=0.05/random(10);
          selectstrokecolor();
          float pow=2+int(random(6));
          spectralblock((j*barsize)+(i*stepw), 0, stepw*2, height, sc, 1, pow);
        }
        if (random(100)<15) {
          hole4((j*barsize)+(i*stepw), stepw, 1, 0);
        }
      }
    }

    float ranshift=0.5+(0.125*(1+int(random(2))));
    if (random(100)<50) {
      singlegate(j+ranshift, 1-ranshift);
    }



    steps=8;


    int fillslist2[]={2, 3, 5}; //3
    fills=fillslist2[int(random(fillslist2.length))];

    stepw=barsize/steps;

    if (random(100)<75) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          float sc=0.05/random(10);
          stroke(255);
          float pow=4+int(random(6));
          spectralblock((j*barsize)+(i*stepw), 0, stepw*3, height, sc, 1, pow);
        }
      }
    }

    ranshift=0.5+(0.125*(1+int(random(2))));
    if (random(100)<50) {
      singlegate(j+ranshift, 1-ranshift);
    }

    //noiseblocks
    for (float i=0; i<bars; i+=0.5) {
      ranshift=(0.0625*(1+int(random(2))));
      if (random(100)<12) {
        freeze(i-ranshift, ranshift);
      }
    }

    if (random(100)<50) {
      steps=16;
    } else {
      steps=12*(1+(int(random(2))));
    }

    int fillslist3[]={6, 7, 8, 9, 10, 11, 12, 13, 14}; //6
    fills=fillslist3[int(random(fillslist3.length))];
    stepw=barsize/steps;

    if (random(100)<66) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          float sc=0.05/random(10);
          selectstrokecolor();
          spectralblock((j*barsize)+(i*stepw), 0, stepw, height/2, sc, 1, 8);
        }
      }
    }

    steps=4;

    int fillslist4[]={1, 2, 3}; //6
    fills=fillslist4[int(random(fillslist4.length))];
    stepw=barsize/steps;

    if (random(100)<75) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          float sc=0.05/random(10);
          stroke(255);
          float pow=2+int(random(6));
          spectralblock((j*barsize)+(i*stepw), height/2, stepw, height/2, sc, 1, pow);
        }
      }
    }

    ranshift=(0.25*(1+int(random(6))));
    if (random(100)<33) {
      fill(0);
      noStroke();
      rect((j+ranshift)*barsize, 0, (1-ranshift)*barsize, height);
      float sc=0.05/random(10);
      selectstrokecolor();
      float pow=2+int(random(6));
      spectralblock((j+ranshift)*barsize, 0, (1-ranshift)*barsize, height, sc, int(random(3)), pow);
      if (random(100)<15) {
        hole4((j+ranshift)*barsize, (1-ranshift)*barsize, 1, 0);
      }
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.5*int(random(2));
    float divs[]={1.333, 2.6666, 8, 16};
    float temp=divs[int(random(divs.length))];
    if (random(100)<10) {
      beatRepeat2(i+ranshift, 1-ranshift, temp, 0.75, 0);
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.5+(int(random(2))*0.25);
    float divs[]={6};
    float temp=divs[int(random(divs.length))];
    if (random(100)<10) {
      beatRepeat2(i+ranshift, 1-ranshift, temp, 0.75, 0);
    }
  }
}

void r18_aperiodicBatucada() { //batucada lenta aperiodica
  float inc=1;
  float inc2=1;
  int mode=int(random(2));
  int prob=int(random(10, 50));
  int speed=(int(random(2))+1)*2;
  speed=2;
  for (float j=0; j<width; j+=inc2) {
    inc2=(width/bars/8)*(1+(int(random(speed))))*(1+(int(random(speed))));
    for (int i=0; i<height; i+=inc) {
      inc=int(random(height/90, height/8));
      selectstrokecolor();
      if (random(100)<prob) {
        if (mode==0) {
          spectralblockx(j, i, inc2*(int(random(3))+1), inc, 0.0001*bars*random(1, 50), 1, random(3, 6), 3);//xywh sc envmode pow
        }
        if (mode==1) {
          spectralblockb(j, i, inc2*(int(random(3))+1), inc, 0.0001*bars*random(1, 80), 1, random(3, 6), 6);//xywh sc envmode pow
        }
        stroke(255);
      }
    }
  }
}

void r19_slow() { //ritme lent
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //clock
  resetcolors();
  float n=2;

  for (float i=0; i<bars; i++) {
    if (random(100)<100) {
      for (float j=0; j<n; j++) {
        int h=((height/3)*2)-100;
        int y=100;
        if (random(100)<100) {
          float pow=4+int(random(6));
          float sc=0.02/random(5);
          float w=(barsize/n)/4;
          stroke(50+int(random(205)));
          spectralblockb((i*barsize)+((barsize/n)*j), y, w, h, sc, 1, pow, 6);
        }
      }
    }
  }

  //kick
  int rndmp=int(random(150));
  for (int i=0; i<width; i+=barsize*2) {
    taiko(i, rndmp, stepsize*32, height-rndmp); //xywh
  }

  //snare
  n=0.25;
  resetcolors();
  for (int i=0; i<bars; i+=2) {
    spectralblockb((i*barsize)+barsize, int(random(height/2)), barsize/2, height/16+int(random(height/4)), 0.02/random(5), 0, 2, 6);
  }

  //sticks
  resetcolors();
  for (int i=0; i<bars; i++) {
    int toggle =int(random(ncol));
    fill(customColour[toggle]);
    float h=50+random(300);
    float y=random((height/2)-h);
    float nums2[]={3, 4, 6, 8, 12, 16};
    n=nums2[int(random(nums2.length))];
    if (random(100)<30) {
      for (float j=0; j<n; j++) {
        float w=(barsize/n)/4;
        //block((i*barsize)+((barsize/n)*j), y, 2, h);
        spectralblockb((i*barsize)+((barsize/n)*j), y, stepsize/2, h, 0.02/random(5), 0, 2, 6);
      }
    }
  }

  //spectralzap
  resetcolors();
  for (float i=0; i<bars; i+=4) {
    float zaph=random(height/2);
    float zapy=random(height-zaph);
    if (random(100)<50) {
      spectralblockb(i*barsize, zapy, barsize*4, zaph, 0.03, 2, 12, 6);
      spectralblockb(i*barsize, random(height/2), barsize*4, 50+random(height/8), 0.03, 1, 20, 6);
      //void spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power) {
    }
  }
}

void r20_dubstep() { //dubstep

  //euclidean hats
  for (int i=0; i<1; i++) {
    int h=int(random(3, 8));
    int steps[]={8};
    int fills[]={2, 3, 4, 5, 6, 7, 8};
    int step=steps[int(random(steps.length))];
    int fill=fills[int(random(fills.length))];
    eurhythm2(0, bars, 1, 58+int(random(20)), h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
  }

  //sticks
  for (int i=0; i<bars; i++) {
    float nums[]={2.66666, 3, 4, 5.333333, 6, 8, 12, 16, 24};
    float n=nums[int(random(nums.length))];
    if (random(100)<50) {
      sticks2(i, 0.5, n/2);//sticks2(float barstart, float bardur,float num)
    }
  }

  //zaps
  for (int i=0; i<bars; i++) {
    if (random(100)<50) {
      zap(i, 0.5);
    }
  }

  for (int i=0; i<bars; i++) {
    if (random(100)<50) {
      zap(i+0.5, 1);
    }
  }

  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      singlegate(i+0.5, 0.5);
    }
  }

  for (float i=0; i<bars; i++) {
    float nums[]={1, 1.33333f, 2, 2.66666, 3, 4};
    float num=nums[int(random(nums.length))];
    snare3(i+0.5, 0.5, num, 80);
    float num2=nums[int(random(nums.length))];
    thump3(i, 0.5, num2, 80);  //thump2(float barpos, float bardur, float num, float prob)
  }
}

void r21_freezee() {
  int rtm=int(random(4));
  switch(rtm) {
  case 0:
    r18_aperiodicBatucada();
    break;

  case 1:
    r20_dubstep();
    break;

  case 2:
    r17_batucada();
    break;

  case 3:
    r19_slow();
    break;
  }

  if (random(100)<50) {
    float nums[]={0.25, 0.25, 0.125, 0.125, 0.125};
    float n=nums[int(random(nums.length))];
    for (float i=0; i<bars; i+=n) {//freeze aperiodic
      n=nums[int(random(nums.length))];
      freeze(i, n);//freeze(barpos,barlen);
    }
  } else {
    float nums2[]={0.5, 0.25, 0.125, 0.0625, 0.03125};
    float n2=nums2[int(random(nums2.length))];
    for (float i=0; i<bars; i++) {//freeze aperiodic
      n2=nums2[int(random(nums2.length))];
      for (float j=0; j<1; j+=n2) {
        freeze(i+j, n2);//freeze(barpos,barlen);
      }
    }
  }

  for (int j=0; j<bars; j++) {
    float ranshift=0.5+(0.125*(1+int(random(2))));
    if (random(100)<50) {
      singlegate(j+ranshift, 1-ranshift);
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.5*int(random(2));
    float divs[]={1.333, 2.6666, 8, 16};
    float temp=divs[int(random(divs.length))];
    if (random(100)<30) {
      beatRepeat2(i+ranshift, 1-ranshift, temp, 0.5, 0);
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.5+(int(random(2))*0.25);
    float divs[]={6};
    float temp=divs[int(random(divs.length))];
    if (random(100)<30) {
      beatRepeat2(i+ranshift, 1-ranshift, temp, 0.5, 0);
    }
  }
}

void r22_zimmer() { //zimmerman
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    float ranshift=0.125*(1+int(random(7)))*(1+int(random(2)));
    float h=200+random(height/3);
    float y=random(height-h-200);
    if (random(100)<30) {
      spectralblockb((i+ranshift)*barsize, y, (2-ranshift)*barsize, h, 0.04/(1+(random(4))), 0, 3, 6);
    }
  }

  selectstrokecolor();
  for (int i=0; i<bars; i+=2) {
    float ranshift=0.125*(1+int(random(7)))*(1+int(random(2)));
    float h=random(height);
    float y=random(height-h);

    if (random(100)<30) {
      spectralblock((i+ranshift)*barsize, y, (2-ranshift)*barsize, h, 0.01/random(6), 2, 4);
    }
  }


  stroke(255, 255);
  int rndmp=int(random(200));
  for (int i=0; i<width; i+=barsize*2) {
    if (random(100)<50) {
      taiko(i, rndmp, stepsize*48, height-rndmp); //xywh
      taiko(i, rndmp, stepsize*48, height-rndmp); //xywh
    }
    if (random(100)<50) {
      spectralblockb(i+barsize, 100+int(random(200)), barsize*2, 150+int(random(600)), 0.02/random(6), 1, 8, 4);  //spectralblockx(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
    }
  }
}

void r23_jazz() { //jazz
  //spectralblockx(float x, float y, float w, float h, float noisesc, int envmode, float power);
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  stroke(255);

  //crash
  for (int i=0; i<width; i+=barsize*4) {
    if (random(100)<33) {
      spectralblock(i, 0, barsize*4, 100, 0.1, 1, 12);
    }
  }

  //open hat
  for (int i=0; i<width; i+=barsize/2) {
    float wid=barsize/2;
    if (random(100)<15) {
      wid=(barsize/2)*(1+int(random(2)))*(1+int(random(2)));
    }
    if (random(100)<75) {
      spectralblock(i, 0, wid, 200, 0.008, 1, 4);
    }
  }

  //closed hat
  for (int i=0; i<width; i+=barsize/2) {

    spectralblock(i+(0.25*barsize), 200, barsize/8, 100, 0.008, 1, 4);
    spectralblock(i+((0.25+0.1875)*barsize), 200, barsize/8, 100, 0.008, 1, 4);
  }

  //snare
  for (int i=0; i<width; i+=barsize) {
    float wid=barsize/4;
    stroke(255);
    if (random(100)<15) {
      selectstrokecolor();
      wid=(barsize)*4;
    }
    spectralblock(i+(0.5*barsize), 300, wid, 350, 0.006, 1, 8);
  }

  //sub dust
  for (int i=0; i<width; i+=barsize) {
    float pos=0.75+(0.125*int(random(2)));
    stroke(255);
    if (random(100)<25) {
      spectralblock(i+(pos*barsize), 800, barsize-(pos*barsize), 280, 0.1, 0, 8);
    }
  }

  //kick
  int rndmp=500;
  for (int i=0; i<width; i+=barsize) {
    if (random(100)<50) {
      taiko(i, rndmp, stepsize*32, height-rndmp); //xywh
    }
  }

  //reverse
  stroke(255);
  for (int i=0; i<bars; i+=2) {
    float ranshift=0.125*(1+int(random(7)))*(1+int(random(2)));
    float h=random(height);
    float y=random(height-h);

    if (random(100)<50) {
      spectralblock((i+ranshift)*barsize, y, (2-ranshift)*barsize, h, 0.01/random(6), 2, 4);
    }
  }
}

void r24_repeat() { //repeatvibes
  r12_fullEuclidean();
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

void r25_genericDub() { //generic dub

  int mode=int(random(3));

  for (int i=0; i<width; i+=(((width/bars)/bardiv))*4) {
    float vel=random(1);
    float dur=0.125;
    int len=100;
    if (random(100)<20) {
      dur=12;
      len=50;
    }
    hat(i, len, 0.15+(vel*0.5), dur);//hat(int posx, int h, int vel, float dur){
  }


  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<25) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    noiseblock(i+ranshift, 1-ranshift, 0);
  }


  for (int i=0; i<bars; i++) {
    thump3(i, 0.5, 1, 100);  //thump2(float barpos, float bardur, float num, float prob)
    thump3(i, 0.5, 1, 100);  //thump2(float barpos, float bardur, float num, float prob)
    thump3(i, 0.5, 1, 100);  //thump2(float barpos, float bardur, float num, float prob)
  }
  snare(1, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }



  for (int i=0; i<bars; i++)
  {
    float figs[]={1, 1.5, 1.6666666666, 2, 3, 4, 6};
    float tempo=figs[int(random(figs.length))];
    float barsize=width/bars;
    float notewidth=barsize/bardiv;
    int num=int(barsize/(tempo*notewidth));
    int sino=int(random(4));
    if (sino==1) {
      beatRepeat(i+0.5, tempo, num/2, 0.66666);//beatRepeat(float barposx, float divw, int num, float gate)
    }
  }

  for (int i=0; i<bars; i++) {
    int sino=int(random(8));
    if (sino==1) {
      freeze(i+0.5, 0.5);//freeze(float barposx, float barlen)
    }
  }
}

void r26_euclideanLines() { //euclidean lines

  int h=0;
  int prevh=0;
  for (int i=0; i<24; i++) {
    h=int(random(12))+4;
    int steps[]={7, 8, 9, 11, 12, 16};
    int fills[]={2, 3, 4, 5};
    float divs[]={1, 2};
    int step=steps[int(random(steps.length))];
    int fill=fills[int(random(fills.length))];
    float div=divs[int(random(divs.length))];
    eurhythm2(0, bars, div, prevh, h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
    prevh=prevh+h;
  }

  /*
  snare(1,100,1);
   for(float i=0; i<bars;i+=0.5){
   if(random(100)<40){
   zap(i,0.5*(int(random(3))+1));//zap(float posx, float bardur)
   }
   }
   
   for(int i=0; i<bars;i++){
   float ranshift=0.125*(1+int(random(7)));
   noiseblock(i+ranshift, 1-ranshift, 0);
   }
   */
}

void r27_ikeda2() {//ikeda fences

  float barsize=width/bars;
  float inc=0.5;
  if (random(100)<25) {
    for (float i=0; i<bars; i+=inc) {
      selectstrokecolor();
      inc=0.5/((int(random(2))+1)*(int(random(2))+1));
      float nums[]={4, 8, 16};
      float n=nums[int(random(nums.length))];
      int h=int(random(100, height/2));
      int y=int(random(100, height-h-200));
      if (random(100)<85) {
        for (float j=0; j<(n*inc); j++) {
          float sc=0.05/random(10);
          float w=((barsize*inc)/(n*inc))/2;
          spectralblock((i*barsize)+((barsize/(n))*j), y, w, h, sc, 0, 1);
        }
      }
    }
  } else {
    float nums[]={1, 2, 2.66666, 4, 5.333333, 8, 16};
    float n=nums[int(random(nums.length))];
    for (float i=0; i<bars; i++) {
      selectstrokecolor();
      int h=int(random(100, height/2));
      int y=int(random(100, height-h-100));
      float sc=0.05/random(10);
      float w=(barsize/n)/(1*(int(random(2)+1)));
      if (random(100)<50) {
        for (float j=0; j<n; j++) {
          spectralblock((i*barsize)+((barsize/n)*j), y, w, h, sc, 0, 4);
        }
      }
    }
  }
  //t3_clouds();
  //r9_marblesOld();
}

void r28_batucadaSincopa() { //batucada abstracta sincopa
  float barsize=width/bars;
  int inc=1;
  float inc2=1;
  int mode=int(random(3));
  int prob=int(random(10, 50));

  for (int j=0; j<bars; j++) {
    int steps=8;

    int fillslist[]={1, 2, 3, 4}; //6
    int fills=fillslist[int(random(fillslist.length))];

    float stepw=barsize/steps;


    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          float sc=0.05/random(10);
          selectstrokecolor();
          float pow=2+int(random(6));
          spectralblock((j*barsize)+(i*stepw), 0, stepw*2, height, sc, 1, pow);
        }
        if (random(100)<15) {
          hole4((j*barsize)+(i*stepw), stepw, 1, 0);
        }
      }
    }
  }

  float stepsize=barsize/bardiv;
  stroke(255, 255);
  int rndmp=int(random(200));
  for (int i=0; i<width; i+=barsize*2) {
    if (random(100)<50) {
      taiko(i, rndmp, stepsize*48, height-rndmp); //xywh
      taiko(i, rndmp, stepsize*48, height-rndmp); //xywh
    }
    if (random(100)<50) {
      spectralblockb(i+barsize, 100+int(random(200)), barsize*2, 150+int(random(600)), 0.02/random(6), 1, 8, 4);  //spectralblockx(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
    }
  }

  //spectral zaps
  float wlist[]={0.5, 1, 2}; //6
  float wzap=wlist[int(random(wlist.length))];
  for (float i=0; i<bars; i+=0.5) {
    resetcolors();
    float zaph=random(height/2);
    float zapy=random(height-zaph);
    if (random(100)<25) {
      spectralblockb(i*barsize, zapy, barsize*wzap, zaph, 0.03, 2, 12, 6);
      spectralblockb(i*barsize, random(height/2), barsize*wzap, 50+random(height/8), 0.03, 1, 20, 6);
      //void spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power)
    }
  }

  //zaps
  resetcolors();
  float wlist2[]={0, 0.25, 0.5, 0.75}; //6
  float wzap2=wlist2[int(random(wlist2.length))];
  for (float i=0; i<bars; i++) {
    if (random(100)<33) {
      zap(i+wzap2, 1-wzap2);//zap(float barpos, float bardur)
    }
  }

  //percs
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
}

void kicktone(float x) {
  float barsize=width/bars;
  float power=int(random(8))+3;
  float uai=int(random(200));
  taiko3(x, -uai, barsize, power); //xywh
  //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
  spectralblockc(x, height/8, barsize/2, height, 0.025, 1, 12, 4);
  spectralblockc(x, height/2, barsize/2, height, 0.01, 1, 12, 4);
  taiko3(x, -uai*2, barsize/2, power*2); //xywh
  additive2(0, x/barsize, 8, 12, 2, 1, 3, 4); //void additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
}

void r29_1kick() { //1kick
  kicktone(0);
}

void r30_euclideanKick() { //euclidean tonekicks
  //euclidean(int idx, int steps, int fills, int shift)
  float barsize=width/bars;
  int steps=8;
  int shift=int(random(2));
  int fillslist[]={1, 2, 3, 5}; //6
  int fills=fillslist[int(random(fillslist.length))];
  float stepw=barsize/steps;
  for (int j=0; j<bars; j++) {
    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          kicktone((j*barsize)+(i*stepw));
        }
      }
    }
  }
}

void r31_blockingSnares() { //blocking snares
  pushMatrix();
  popMatrix();
  rectMode(CORNER);
  blendMode(BLEND);
  float[] speeds={2, 2, 4, 4, 4, 8, 8, 8, 16, 16, 16, 16};
  float speed=speeds[int(random(speeds.length))];
  float barsize=(width/bars)/speed;
  for (int i=0; i<bars*speed; i++) {
    float posx=i*barsize;
    float noteh=height/float(notegrid);
    float posy=random(height/2)-(height/6);
    int h=int(random(noteh*12, noteh*48));
    float pw=1+random(4);
    int prob=int(random(5, 15));
    if (random(100)<prob) {
      if (i%2==1) {
        noStroke();
        fill(0);
        rect(posx-1, 0, barsize+1, height);
        for (float j=0; j<h; j++) {
          float ph=j/h;
          ph=1-((cos(ph*TWO_PI)+1)/2.);
          ph=pow(ph, pw);

          stroke(255*ph);
          line(posx-1, posy+j, posx+barsize-1, posy+j);
        }
      }
    }
  }
}

void r32_euclideanSnares() { //euclidean bigsnares
  //euclidean(int idx, int steps, int fills, int shift)
  stroke(255);
  float barsize=width/bars;
  int steps=8;
  int fillslist[]={1, 2, 3, 5}; //6
  int fills=fillslist[int(random(fillslist.length))];
  float stepw=barsize/steps;
  int toggle =int(random(ncol));
  fill(customColour[toggle]);
  stroke(customColour[toggle]);
  for (int j=0; j<bars; j++) {
    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, 0)==1) {
          //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
          spectralblockc((j*barsize)+(i*stepw)+barsize/4, int(random(-height/8, height/8)), barsize, random(height/2, height), random(0.01, 0.05), 1, 12, 2);
        }
      }
    }
  }
}

void r33_euclideanHats() { //euclidean hihats
  //euclidean(int idx, int steps, int fills, int shift)
  stroke(255);
  float barsize=width/bars;
  int steps=16;
  int fillslist[]={3, 5, 6, 7, 9, 10, 11, 12, 13}; //6
  int fills=fillslist[int(random(fillslist.length))];
  int fillslist2[]={1, 2, 3}; //6
  int fills2=fillslist2[int(random(fillslist2.length))];
  float stepw=barsize/steps;
  int toggle =int(random(ncol));
  float posy=int(random(0, height/6));
  float posy2=int(random(0, height/6));
  float heigh=int(random(height/8, height/4));
  float heigh2=int(random(height/8, height/4));
  int shift=int(random(steps));
  int shift2=int(random(steps));

  toggle =int(random(ncol));
  fill(customColour[toggle]);
  stroke(customColour[toggle], 64);
  for (int j=0; j<bars; j++) {
    if (random(100)<50) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, shift)==1) { //closed hih
          //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
          spectralblockc((j*barsize)+(i*stepw), posy, barsize/random(12, 32), heigh, random(0.02, 0.1), 1, 12, 1);
        }
      }
    }
  }
  toggle =int(random(ncol));
  fill(customColour[toggle]);
  stroke(customColour[toggle], 64);
  for (int j=0; j<bars; j++) {
    if (random(100)<50) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills2, shift2)==1) { //openh
          //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
          spectralblockc((j*barsize)+(i*stepw), posy2, barsize/random(2, 8), heigh2, random(0.02, 0.1), 1, 10, 1);
        }
      }
    }
  }
}

void r34_euclideanDrumSet() { //euclideanfull
  r33_euclideanHats();
  r32_euclideanSnares();
  r30_euclideanKick();

  float barsize=width/bars;
  stroke(255);
  for (int i=0; i<bars; i+=2) {
    float ranshift=0.125*(1+int(random(7)))*(1+int(random(2)));
    float h=random(height);
    float y=random(height-h);

    if (random(100)<50) {
      spectralblock((i+ranshift)*barsize, y, (2-ranshift)*barsize, h, 0.05/random(6), 2, 4);
    }
  }
  stroke(255, 255);
  for (float i=0; i<bars; i+=2) {
    if (random(100)<25) {
      float h=random(height);
      float y=random(height-h);
      spectralblock(i*barsize, y, barsize/4, h, 0.1/random(6), 2, 4);
    }
  }
}

void r35_techno2() { //techno2
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //hihat

  selectstrokecolor();
  float vartime=0.5;
  float lenvar=random(60);
  float lenvar2=random(50);
  float posvar=random(100);
  float posvar2=random(100);
  float powvar=int(random(10));
  if (random(100)<50) {
    for (float i=0; i<bars; i+=vartime) {
      float nums[]={4};
      float n=(nums[int(random(nums.length))]);
      hihat2(i, vartime, n/vartime, 50+int(posvar2), 30+lenvar2);
    }
  }
  //open hat
  if (random(100)<50) {
    selectcolor();
    for (float i=0; i<bars; i+=0.25) {
      if (random(100)<100) {
        klank((i*barsize)+(barsize/8), 50+posvar, 20+lenvar, stepsize*16, 10+powvar); //xyhwp
      }
    }
  }
  selectstrokecolor();
  //spectralzap
  for (float i=0; i<bars; i+=4) {
    float zaph=random(height/2);
    float zapy=random(height-zaph);
    int div2=int(random(2))+1;
    if (random(100)<50) {
      spectralblockc(i*barsize, zapy, barsize*4, zaph, 0.03, 2, 12, 6);
      spectralblockc(i*barsize, random(height/2), barsize*4, 50+random(height/8), 0.03, 1, 20, 6);
      //void spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power) {
    }
  }
  selectstrokecolor();

  //random polyrhythm
  int seed=int(random(1000));
  int steps=3+int(random(6));
  int posy=int(random(350));
  int ranh=80+int(random(300));
  float ranw=(stepsize*2)+(stepsize*random(2));
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        taiko(j+(i*stepsize), 150+posy, ranw, ranh); //xywh
        taiko(j+(i*stepsize), 150+posy, ranw, ranh); //xywh
      }
    }
  }

  //cool zaps
  for (float i=0; i<bars; i++) {
    if (random(100)<33) {
      int div2=int(random(2))+1;
      zap(i+0.75, (0.75)/div2);//zap(float barpos, float bardur)
    }
  }

  stroke(255);
  for (int i=0; i<bars; i+=2) {
    float ranshift=0.125*(1+int(random(7)))*(1+int(random(2)));
    float h=random(height);
    float y=random(height-h);

    if (random(100)<50) {
      spectralblock((i+ranshift)*barsize, y, (2-ranshift)*barsize, h, 0.05/random(6), 2, 4);
    }
  }

  //kickdrum
  float power=int(random(8))+3;
  float wi=stepsize*(int(random(4))+4);
  float uai=int(random(200));
  for (int i=0; i<width; i+=((width/bars))/4) {
    taiko3(i, -uai, wi, power); //xywh
    kicktone(i);
  }

  int parts=int(random(4))+4;
  int root=int(random(2))*12;
  for (float i=0; i<bars; i+=0.25) {
    additive2(-root, i, 8, parts, 0, 1, 3, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
    //additive2(-root, i, 8, parts, 0, 1, 3, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }

  //noiseblocks
  for (float i=0; i<bars; i+=0.5) {
    float ranshift=(0.0625*(1+int(random(2))));
    if (random(100)<25) {
      fill(0);
      noStroke();
      rect((i-ranshift)*barsize, 0, ranshift*barsize, height);
      selectcolor();
      noiseblock(i-ranshift, ranshift, 50);
    }
  }

  //blackblocks
  for (float i=0; i<bars; i++) {
    float ranshift=(0.03125*(1+int(random(2))));
    if (random(100)<25) {
      fill(0);
      noStroke();
      rect((i-ranshift)*barsize, 0, ranshift*barsize, height);
    }
  }

  //blockingsnares
  float[] speeds={4, 8, 16};
  float speed=speeds[int(random(speeds.length))];
  barsize=(width/bars)/speed;
  for (int i=0; i<bars*speed; i++) {
    float posx=i*barsize;
    float noteh=height/float(notegrid);
    float posyy=random(height/2)-(height/6);
    int h=int(random(noteh*12, noteh*48));
    float pw=1+random(4);
    int prob=int(random(5, 25));
    if (random(100)<prob) {
      if (i%2==1) {
        noStroke();
        fill(0);
        rect(posx-1, 0, barsize+1, height);
        for (float j=0; j<h; j++) {
          float ph=j/h;
          ph=1-((cos(ph*TWO_PI)+1)/2.);
          ph=pow(ph, pw);

          stroke(255*ph);
          line(posx-1, posyy+j, posx+barsize-1, posyy+j);
        }
      }
    }
  }
}

void r36_euclideanKickShift() { //euclidean tonekicks shift
  //euclidean(int idx, int steps, int fills, int shift)
  float barsize=width/bars;
  int steps=(int(random(2))+1)*8;
  int shift=int(random(steps));
  int fillslist[]={1, 2, 3, 3, 5}; //6
  int fills=fillslist[int(random(fillslist.length))];
  float stepw=barsize/steps;
  for (int j=0; j<bars; j++) {
    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, shift)==1) {
          if (random(100)<100) {
            kicktone((j*barsize)+(i*stepw));
          }
        }
      }
    }
  }
}

void r37_techSimple() { //techno simple
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //random polyrhythm
  int seed=int(random(1000));
  int steps=3+int(random(6));
  int posy=int(random(350));
  int ranh=80+int(random(300));
  float ranw=(stepsize*2)+(stepsize*random(2));
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        taiko(j+(i*stepsize), 150+posy, ranw, ranh); //xywh
      }
    }
  }

  //kickdrum
  float power=int(random(8))+3;
  float wi=stepsize*(int(random(4))+4);
  float uai=int(random(200));
  for (int i=0; i<width; i+=((width/bars))/4) {
    taiko3(i, -uai, wi, power); //xywh
  }

  int parts=int(random(4))+4;
  int root=int(random(2))*12;
  for (float i=0; i<bars; i+=0.25) {
    additive2(-root, i, 8, parts, 0, 1, 3, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
  }
}

void r38_shaker() {
  selectstrokecolor();
  int strokeColor=g.strokeColor;
  float barsize=width/bars;
  float inc=barsize/16;
  float noteh=height/notegrid;
  //int euclidean(int idx, int steps, int fills, int shift)
  float ch=noteh*random(12, 17);
  float oh=ch+(noteh*random(5, 10));
  int count=0;
  int steps=int(random(6, 9));
  int fills=int(random(2, 5));
  int shift=int(random(steps));
  int ohstep=int(random(steps));
  float ohw=1.5;
  for (int i=0; i<width; i+=inc) {
    if (count%16==ohstep) {
      ohw=inc*2;
    } else {
      ohw=inc/4;
    }
    if (euclidean(count, steps, fills, shift)==1) {
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor));
      gradbox(i, 0, ohw, oh, 20, 1);
      //gradbox(float x, float y, float w, float h, float gradsize, float pow)
    } else {
      stroke(red(strokeColor)/2, green(strokeColor)/2, blue(strokeColor)/2);
      gradbox(i, 0, inc/6, ch, 20, 1);
    }
    count++;
  }
}

void r39_anacrusa() {
  float barsize=width/bars;
  float pow=random(1, 6);
  int dir=1;
  float[] figs={8,4};
  
  for (float i=0; i<bars; i++) {
    float fig=figs[int(random(figs.length))];
    float w=(barsize/fig);
    float x=(i*barsize)+(barsize-w);
    float y=50+random((height/3)*2);
    float h=100+random(400);
    if (random(100)<8) {
      if (random(100)<50) {
        fill(0);
        stroke(0);
        rect(x, 0, w, height);
      }
      noFill();
      stroke(255);
      strokeWeight(1);
      strokeCap(PROJECT);
      gradbox2(x, y, w, h, pow, dir);
    }
    //fig=1/figs[int(random(figs.length))];
  }
  //void spectralblockx(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
}

void r40_anacrusaSpectral() { //anacrusa spectral
  float barsize=width/bars;
  float pow=random(1, 6);
  stroke(255);
  float[] figs={8, 4};
  
  for (float i=0; i<bars; i++) {
    float fig=figs[int(random(figs.length))];
    float w=(barsize/fig);
    float x=(i*barsize)+(barsize-w);
    float h=(height/4)+random(height-(height/4));
    float y=random((height-h));
    if (random(100)<25) {

      //gradbox2(x,y,w,h,pow,dir);
      fill(255);
      stroke(255);

      spectralblockc(x, y, w, h, 0.02/random(0, 5), 2, 4, 2);
    }
    //fig=1/figs[int(random(figs.length))];
  }
}

void r41_anacrusaSpectralBlocking() { //blocking anacrusa spectral
  float barsize=width/bars;
  float pow=random(1, 6);
  stroke(255);
  float[] figs={8, 4};
  
  for (float i=0; i<bars; i++) {
    float fig=figs[int(random(figs.length))];
    float w=(barsize/fig);
    float x=(i*barsize)+(barsize-w);
    float h=(height/4)+random(height-(height/4));
    float y=random((height-h));
    if (random(100)<8) {
      if (random(100)<50) {
        fill(0);
        stroke(0);
        rect(x, 0, w, height);
      }
      //gradbox2(x,y,w,h,pow,dir);
      fill(255);
      stroke(255);

      spectralblockc(x, y, w, h, 0.02/random(0, 5), 2, 4, 2);
    }
    //fig=1/figs[int(random(figs.length))];
  }
}

void r42_ikedaLess() {//ikeda lesschance

  float barsize=width/bars;
  float inc=0.5;
  if (random(100)<50) {
    for (float i=0; i<bars; i+=inc) {
      inc=0.5/((int(random(2))+1)*(int(random(2))+1));
      float nums[]={4, 8, 16};
      float n=nums[int(random(nums.length))];
      int h=int(random(100, height/2));
      int y=int(random(100, height-h-200));
      if (random(100)<33) {
        for (float j=0; j<(n*inc); j++) {
          if (random(100)<85) {

            float sc=0.05/random(10);
            float w=((barsize*inc)/(n*inc))/2;
            stroke(255);
            spectralblock((i*barsize)+((barsize/(n))*j), y, w, h, sc, 0, 1);
          }
        }
      }
    }
  } else {
    float nums[]={4, 8, 16};
    float n=nums[int(random(nums.length))];
    for (float i=0; i<bars; i++) {
      if (random(100)<33) {
        for (float j=0; j<n; j++) {
          int h=int(random(100, height/2));
          int y=int(random(100, height-h-100));
          if (random(100)<75) {
            float sc=0.05/random(10);
            float w=(barsize/n)/(2/random(2));
            stroke(255);
            spectralblock((i*barsize)+((barsize/n)*j), y, w, h, sc, 0, 4);
          }
        }
      }
    }
  }
  //t3_clouds();
  //r9_marblesOld();
}

void r43_rumble() { //rumble
  float barsize=width/bars;
  float pow=random(1, 6);
  stroke(255);
  float h=(random(height/4, height-(height/4)));
  float sc=random(0.02, 0.05);

  for (float i=0; i<bars; i+=0.25) {
    float w=(0.25*barsize);
    float x=(i*barsize)-4;
    float y=(height-h)+(height/8);


    fill(192);
    stroke(192);
    //randomSeed(20);
    spectralblockc(x, y, w, h, sc, 2, 4, 2);
  }
}

void r44_bigSnare() { //bigsnare
  stroke(255);
  float barsize=width/bars;

  for (int j=0; j<bars; j+=2) {
    if (random(100)<10) {
      float x=(j*barsize)+((barsize/4)*3);
      float h=random(height/3, height/1.5);
      float y=int(random(height/4, height-h-(height/6)));
      float w=barsize;

      noStroke();
      fill(0);
      rect(x, 0, w/4, height);
      fill(255);
      stroke(255);
      //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
      spectralblockc(x, y, w*2, h, random(0.002, 0.01), 1, 24, 3);
    }
  }
}

void r45_noiseBlocks() { //noise Blocks
  stroke(255);
  for (float i=0; i<bars; i+=0.5) {
    float ranshift=(0.0625*(1+int(random(2))));
    if (random(100)<33) {
      noiseblock(i-ranshift, ranshift, 50);
    }
  }
}

void gradsnare(float x, float y, float w, float h) { //gradient h snares
  rectMode(CORNER);
  float pw=1+random(4);
  for (float j=0; j<h; j++) {
    float ph=j/h;
    ph=1-((cos(ph*TWO_PI)+1)/2.);
    ph=pow(ph, pw);
    stroke(255,255*ph);
    line(x-1, y+j, x+w, y+j);
  }
}

void r46_simpleSnare(){ //simplesnare
float barsize=width/bars;
float h=random(height/6,height/3);
float y=random(height/4,height-(height/4)-h);
  for(float i=0;i<bars;i+=0.5){
    gradsnare((i*barsize)+barsize/4,y,barsize/4,h);    
  }
}

void r47_anaIkeda(){
  float barsize=width/bars;
  for (float i=1; i<bars+1; i+=0.5) {
    float ranshift=(0.0625*(1+int(random(2))));
    if (random(100)<50) {
      int h=int(random(100, height/2));
      int y=int(random(100, height-h-200));
      float sc=0.05/random(10);
      spectralblock((i-ranshift)*barsize, y, ranshift*barsize, h, sc, 0, 1);
    }
  }
}

void r48_subKickPage(){
  float barsize=width/bars;
  float yy=random(height/2,3*(height/4));
  float ww=barsize*2;
  taiko3(0, yy, ww, 2);
}

void r49_anacrusaPage(){
  stroke(92);
  gradbox2(0, 0, width, height, random(2,8), 1);
}

void r50_hihats(){
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  //hihat

  stroke(255);
  float vartime=0.5;
  float lenvar=random(80);
  float lenvar2=random(80);
  float posvar=random(110);
  float posvar2=random(110);
  float powvar=int(random(10));
  if (random(100)<100) {
    for (float i=0; i<bars; i+=vartime) {
      float nums[]={4};
      float n=(nums[int(random(nums.length))]);
      hihat2(i, vartime, n/vartime, 40+int(posvar2), 30+lenvar2);
    }
  }
  //open hat
  if (random(100)<50) {
    selectcolor();
    for (float i=0; i<bars; i+=0.25) {
      if (random(100)<100) {
        klank((i*barsize)+(barsize/8), 40+posvar, 20+lenvar, stepsize*16, 10+powvar); //xyhwp
      }
    }
  }
  
lenvar=random(60);
posvar=random(110);
  
  float inc=barsize/16;
  int count=0;
  int steps=int(random(6, 9));
  int fills=int(random(2, 5));
  int shift=int(random(steps));
  int ohstep=int(random(steps));
  float ohw=1.5;
  float pw=1;
  selectstrokecolor();
  for (int i=0; i<width; i+=inc) {
    if (count%16==ohstep) {
      ohw=inc*4;
      pw=2;
    } else {
      ohw=inc;
      pw=2;
    }
    if (euclidean(count, steps, fills, shift)==1) {
      gradbox(i, 40+posvar, ohw, 20+lenvar, 0, pw);
      //gradbox(float x, float y, float w, float h, float gradsize, float pow)
    } 
    count++;
  }
}


void r51_techSteps(){
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  
  int seed=128+int(random(1000));
  int steps=3+int(random(6));
  int posy=int(random(30,240));
  int ranh=200+int(random(400));
  float ranw=(stepsize*2)+(stepsize*random(7));
  float shift=(barsize/2)*int(random(2));
  for (int j=0; j<width; j+=width/bars) {
    for (int i=1; i<steps; i++) {
      int eval=randomfills(i-1, steps-1, seed);
      if ((eval==1)) {
        taiko(j+(i*stepsize)+shift, posy, ranw, ranh); //xywh
        taiko(j+(i*stepsize)+shift, posy, ranw, ranh); //xywh
        taiko(j+(i*stepsize)+shift, posy, ranw, ranh); //xywh        
      }
    }
  }
}

void r52_kickQuarter(){
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  
  float power=8;
  float wi=stepsize*6;
  float uai=100;
  for (int i=0; i<width; i+=((width/bars))/4) {
    taiko3(i, -750, wi, power); //xywh
  }
  
}

void r53_snareGrad(){
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  
  fill(255);
  float snrw=(stepsize*8)+(stepsize*(random(16)));
  float yvar=random(350);
  float hvar=150+random(250);
  float pvar=random(8);
  for (int i=0; i<width; i+=((width/bars))) {
    klank(i+((width/bars)/4), 150+yvar, hvar, snrw, 10+pvar); //xyhwp
    klank(i+(((width/bars)/4)*3), 150+yvar, hvar, snrw, 10+pvar); //xyhwp
  }
}

void r54_probKicks(){
  int[] stepchances={75,10,25,10,0,10,25,10,75,10,25,10,0,10,25,10};
  int[] stepresult=new int[int(bardiv)];
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  stepresult=probsteps(stepchances);
  
  int parts=int(random(4))+4;
  int root=int(random(2))*12;
  
  for(int i=0;i<bars;i++){
    for(int j=0;j<bardiv;j++){
      if(stepresult[j]==1){
        additive2(-root, ((i*barsize)+(j*stepsize))/barsize, 8, parts, 0, 1, 3, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, float detune, float pow)
        taiko3((i*barsize)+(j*stepsize), -100, stepsize*6, 6); //xywh
      }
    }
  }
}

void r55_probSnares(){
  int[] stepchances={0,8,20,8,40,8,20,8,0,8,20,5,40,8,20,8};
  float[] stepdurs={0,0.25,0.5,0.25,1,0.25,0.5,0.25,0,0.25,0.5,0.25,1,0.25,0.5,0.25};
  int[] stepresult=new int[int(bardiv)];
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  float snrw=(stepsize*4)+(stepsize*(random(16)));
  float yvar=random(350);
  float hvar=150+random(250);
  float pvar=random(8);
  stepresult=probsteps(stepchances);
  strokeWeight(1);
  stroke(255,255);
  fill(255);
  strokeCap(ROUND);
  for(int i=0;i<bars;i++){
    for(int j=0;j<bardiv;j++){
      if(stepresult[j]==1){
       klank((i*barsize)+(j*stepsize), 100+yvar, hvar, snrw*stepdurs[j], 10+pvar); //xyhwp
       klank((i*barsize)+(j*stepsize), 100+yvar, hvar, snrw*stepdurs[j], 10+pvar); //xyhwp
      }
    }
  }
}

void r56_endBarMute(){
  float barsize=width/bars;
  noStroke();
  fill(0);
  for(int i=0;i<bars;i++){
    if(random(100)<20){
      int fig=int(random(2))+1;
      rect(((i*barsize)+barsize)-(barsize/(4/fig)),0,(i*barsize)+barsize,height);
    }
  }
}

void r57_openHat(){
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  float lenvar=random(120);
  float posvar=random(110);
  float powvar=int(random(10));
  stroke(255);
  selectcolor();
    selectstrokecolor();
    for (float i=0; i<bars; i+=0.25) {
      if (random(100)<100) {
        klank((i*barsize)+(barsize/8), 40+posvar, 40+lenvar, stepsize*16, 10+powvar); //xyhwp
      }
    }
}

void r58_blockingSnaresHalf() { //blocking snares

  rectMode(CORNER);
  blendMode(BLEND);

  float barsize=(width/bars);
  
  for (int i=0; i<bars; i++) {
    float posx=(i*barsize)+(barsize-(barsize/4));
    float w=barsize/4;
    float noteh=height/float(notegrid);
    float posy=random(height/2-height/6);
    int h=int(random(noteh*12, noteh*48));
    float pw=1+random(4);
    int prob=5;
    if (random(100)<prob) {
        noStroke();
        fill(0);
        rect(posx-1, 0, w, height);
        for (float j=0; j<h; j++) {
          float ph=j/h;
          ph=1-((cos(ph*TWO_PI)+1)/2.);
          ph=pow(ph, pw);
          stroke(255*ph);
          line(posx-1, posy+j, posx+w, posy+j);
        }
    }
  }
}

void r59_sweepAnacrusa(){
  
  float barsize=width/bars;
  float pow=random(1, 6);
  int dir=1;
  float[] figs={8,4,2};
  
  for (float i=0; i<bars; i++) {
    float fig=figs[int(random(figs.length))];
    float w=(barsize/fig);
    float x=(i*barsize)+(barsize-w);
       
    float h=300+random(400);
    
    float y2=random(h,height/2);
    float y=random(height/2,height); 
    
    if (random(100)<5) {
      if (random(100)<50) {
        fill(0);
        stroke(0);
        rect(x, 0, w, height);
      }
      noFill();
      strokeWeight(1);
      strokeCap(PROJECT);
      //gradbox2(x, y, w, h, pow, dir);
      //spectralGradient(x0, y0a, y0b, x1, y1a, y1b, op0, op1, powW, powH)
      spectralGradient(x, y, y-h, x+w, y2, y2-h, 0, 1, random(1,3), random(0,1)); 
    }
  }
 
}

void r60_shaker2() {
  strokeWeight(1);
  selectstrokecolor(); 
  selectcolor();
  int strokeColor=g.strokeColor;
  float barsize=width/bars;
  float inc=barsize/16;
  float noteh=height/notegrid;
  //int euclidean(int idx, int steps, int fills, int shift)
  float ch=noteh*random(8, 12);
  float oh=ch+(noteh*random(4, 8));
  int count=0;
  int steps=int(random(6, 9));
  int fills=int(random(2, 5));
  int shift=int(random(steps));
  int ohstep=int(random(steps));
  float ohw=1.5;
  for (int i=0; i<width; i+=inc) {
    if (count%16==ohstep) {
      ohw=inc*4;
    } else {
      ohw=inc;
    }
    if (euclidean(count, steps, fills, shift)==1) {
      stroke(red(strokeColor)/2, green(strokeColor)/2, blue(strokeColor)/2);
      //gradbox(i, 0, ohw, oh, 20, 1);
      //gradbox(float x, float y, float w, float h, float gradsize, float pow)
       klank(i, 0, oh, ohw, 2); //xyhwp
    } else {
      stroke(red(strokeColor)/4, green(strokeColor)/4, blue(strokeColor)/4);
      //gradbox(i, 0, inc/6, ch, 20, 1);
      klank(i, 0, ch, inc/3, 2); //xyhwp
    }
    count++;
  }
}

void r61_kickBar(){
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  
  float power=8;
  float wi=stepsize*16;
  float uai=100;
  stroke(255);
  
  float strw=3;
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

  strokeWeight(1);
  for (int i=0; i<width; i+=((width/bars))) {
    taiko3(i, -750, wi, power); //xywh
    
    int p=0;
    int rt=rootList[int(i/barsize)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i/barsize)];
    p=p+rt+tr;
    //note(i+(strw/2), p, barsize, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, vol);

  }
  
}

void r62_probKicksWide(){
  int[] stepchances={75,10,25,10,0,10,25,10,75,10,25,10,0,10,25,10};
  int[] stepresult=new int[int(bardiv)];
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  stepresult=probsteps(stepchances);
  
  
  float strw=3;
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
  int partialmode=int(random(3));
  float ampow=random(2, 6);
  float lfopow=random(1, 10);
  int partials=int(random(8, 24));
  float detune=random(3);
  float partdet=0;
  int prev=0;
  
  for(int i=0;i<bars;i++){
    int p=0;
    int rt=rootList[int(i)];
    rt=scale[rt%scales[selsc].length];
    int tr=transposeList[int(i)];
    p=p+rt+tr;
    
    for(int j=0;j<bardiv;j++){
      if(stepresult[j]==1&&prev==0){
        
        strokeWeight(1);
        taiko3((i*barsize)+(j*stepsize), -100, stepsize*6, 6); //xywh
        prev=1;
        strokeWeight(strw);
        note((i*barsize)+(j*stepsize)+(strw/2), p, barsize/3, partials, partialmode, firstpartial, hicutpow, locutpow, ampshape, ampow, lfoshape, lfocycles, lfohp, lfopow, tremamp, tremcyc, vibamp, vibcyc, detune, partdet, vol);

      }
      else{
        prev=0;
      }
    }
  }
}

void r63_batucada3() { //euclidean bigsnares
  //euclidean(int idx, int steps, int fills, int shift)
  float barsize=width/bars;
  int steplist[]={8};
  int steps=steplist[int(random(steplist.length))];
  int fillslist[]={2,3,5}; //6 
  float stepws[]={8,8,8,4,4,4,4,2,1};
  int shift=int(random(steps));
  
  
  for (float j=0; j<bars; j+=0.5) {
    shift=int(random(steps));
    int fills=fillslist[int(random(fillslist.length))];
    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, shift)==1) {
          float stepw=stepws[int(random(stepws.length))];
          float y=int(random(-height/5,height/2.5));
          float h=random(height/6,height-y);
          selectstrokecolor();
          //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
          spectralblockc((j*barsize)+(i*((barsize/2)/steps)), y, barsize/stepw, h, random(0.01, 0.07), 1, 12, 2);
        }
      }
    }
  }
  

  
//reverse
  for (float j=0; j<bars; j+=0.5) {
    shift=int(random(steps));
    int fills=fillslist[int(random(fillslist.length))];
    if (random(100)<100) {
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, shift)==1) {
          float stepw=stepws[int(random(stepws.length))];
          float y=int(random(-height/5,height/2.5));
          float h=random(height/4,height-y);
          selectstrokecolor();
          if(random(100)<15){
          //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
          spectralblockc((j*barsize)+(i*((barsize/2)/steps)), y, barsize/stepw, h, random(0.01, 0.07), 2, 12, 2);
          }
        }
      }
    }
  }
  
  //block
  float stepws2[]={16,16,8};
  for (float j=0; j<bars; j+=0.5) {
    shift=int(random(steps));
    int fills=fillslist[int(random(fillslist.length))];
      for (int i=0; i<steps; i++) {
        if (euclidean(i, steps, fills, shift)==1) {
          float stepw=stepws2[int(random(stepws2.length))];
          float y=int(random(-height/5,height));
          float h=random(height/4,height-y);
          selectstrokecolor();
          if(random(100)<10){
          //spectralblockc(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
          spectralblockc((j*barsize)+(i*((barsize/2)/steps)), y, barsize/stepw, h, random(0.01, 0.07), 0, 12, 2);
          }
        }
      }
  }
}

void r64_gradBlocks(){
  selectstrokecolor();
  float barsize=width/bars;
  float[] incs={0.125,0.0625};
  float inc=incs[int(random(incs.length))];
  float wvar=(int(random(2))+1);
  for(float i=0;i<bars;i+=inc){
    inc=incs[int(random(incs.length))];
    float x=i*barsize;
    float y=random(height/12,height/2);
    float h=random(height/8,height/2);
    float w=(barsize*inc);
    float pow=random(1,4);
    if(random(100)<15){
      gradblock(x,y,w,h,pow);
    }
    
  }
}

void r65_crash(){
  selectstrokecolor();
  int strokeColor=g.strokeColor;
  float barsize=width/bars;
  float y=int(random(height/5));
  float h=random(height/4,height/3);
  if(random(100)<50){
    spectralblockc(0, y, barsize*3, h, random(0.01, 0.07), 1, 12, 2);
  }  
}

void r66_lastBarReverse(){
  selectstrokecolor();
  float barsize=width/bars;
  float y=int(random(height/4));
  float h=random(height/4,height-y);
  if(random(100)<50){
    spectralblockc((bars*barsize)-barsize, y, barsize, h, random(0.01, 0.07), 2, 12, 4);
  }  
}

void r67_gradFences() { //filtered noise, new period every bar, random y
  //  pointchords(0.25,bars,2,3,2,8); //void pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  float barsize=width/bars;
  selectstrokecolor();
  for (int i=0; i<bars; i++) {
    float shift=(barsize/8)*(int(random(2))+1);
    float nums[]={2.66666, 4, 5.333333, 8, 12, 16};
    float n=nums[int(random(nums.length))];
    for (float j=0; j<n; j++) {
      float pow=random(1,4);
      float x=(i*barsize)+((barsize/n)*j)+shift;
      float h=120+random(600);
      float y=random(height/2);
      float w=(barsize/n)/4;
      gradblock(x,y,w,h,pow);
    }
  }
}

void r68_roll(){
  float barsize=width/bars;
  selectstrokecolor();
  for(float i=0;i<bars;i++){
    int num=3*(int(random(2))+1);
    float pow=random(1,4);
    float h=200+random(500);
    float y=random(height/3);
    float w=(barsize/8)/(num*2);
    if(random(100)<15){
      noStroke();
      fill(0);
      rect(((i*barsize)+((i*barsize)-(barsize/8))),0,barsize/8,height);
      strokeWeight(1);
      for(int j=0;j<num;j++){
        float x=((i*barsize)+((i*barsize)-(barsize/8)))+(j*((barsize/8)/num));
        //println(x);
        
        gradblock(x,y,w,h,pow);
      }
    }
  }
}

void r69_8hat(){
  float barsize=width/bars;
  selectstrokecolor();
  int num=8;
    float pow=random(1,4);
    float h=(height/12)+random(height/6);
    float y=random(height/10);
    float w=(barsize/num)/4;
    strokeWeight(1);
    int strokeColor=g.strokeColor;
    stroke(red(strokeColor)/2,green(strokeColor)/2,blue(strokeColor)/2);
  for(float i=0;i<bars;i++){
      for(int j=0;j<num;j++){
        float x=(i*barsize)+(j*((barsize/num)));
        gradblock(x,y,w,h,pow);
      }
  }
}

void r70_difuseSnare(){
  
  float barsize=width/bars;
  int dir=1;
  float h=400+random(400);
  float h2=h*2;    
  float y=random(height/4,height/3); 
  float w=(barsize/3);
    
  for (float i=0; i<bars; i+=0.5) {        
    float x=(i*barsize)+(barsize/4);      
    if (random(100)<100) {
      if (random(100)<15&&(i*2)%2==1) {
        fill(0);
        stroke(0);
        rect(x, 0, barsize/4, height);
      }
      
      noFill();
      strokeWeight(1);
      strokeCap(PROJECT);
      
      //spectralGradient(x0, y0a, y0b, x1, y1a, y1b, op0, op1, powW, powH)
      spectralGradient(x, y+(h*1.5), y-(h*1.5), x+(w/4), y+(h/2), y-(h/2), 1, 0, 2, 4); 
      spectralGradient(x, y+(h/2), y-(h/2), x+w, y+(h2/2), y-(h2/2), 1, 0, random(3,5), random(1,3)); 
    }
  }
 
}
