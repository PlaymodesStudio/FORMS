void portamento(float x0, float y0, float x1, float y1, float tens) {
  float distX = x1 - x0;
  float distY = y1 - y0;
  float pointnum=distX;

  beginShape();
  for (float i=0; i<pointnum; i++) {
    float ph=i/pointnum;
    float x=x0+(ph*distX);
    float y=y0+(sigmoid(ph, tens)*distY);
    vertex(x, y);
  }
  endShape(OPEN);
}

void portamento2(float x0, float y0, float x1, float y1, float tens, float vib, int maxw, int rn, float noisesc) {
  float noteheight=height/float(notegrid);
  float distX = x1 - x0;
  float distY = y1 - y0;
  float pointnum=distX*8;
  for (float i=0; i<pointnum; i+=0.125) {
    float ph=i/pointnum;
    float w=2+abs(sin(ph*10)*30);
    w=pow(brownianvalue((i/8)+x0, 100000, noisesc, 1, rn), 1);
    int strokeColor=g.strokeColor;
    stroke(strokeColor);
    strokeWeight(5+(w*maxw));
    strokeCap(ROUND);
    float sinamp=(1+sin(ph*4))/2;
    float sinus=(sin(ph*48)*sinamp)*(noteheight/2);
    float x=x0+(ph*distX);
    float y=(sinus*vib)+y0+(sigmoid(ph, tens)*distY);

    point(x, y);
  }
}

void tremnote(float x, float y, float w, float amp, int octaves) {
  //float brownianvalue(float idx, float w, float noisesc, float maxfreq, float ran)
  //strokeWeight(4);
  noStroke();
  float barsize=width/bars;
  float notew=barsize/64;
  float w2=(w/notew);
  float pw=random(1, 4);
  float noteh=(height/float(notegrid));
  int selnote=int(random(scales[selsc].length));
  int seloctave=int(random(octaves));
  float y2=y-(((12*(seloctave)+(scale[selnote])))*noteh);
  beginShape();
  for (int i=0; i<w; i++) {
    float ph=i/w;
    float ph2=i/w;
    ph=(sin(ph*PI));
    ph=pow(ph, pw);
    float uai=((sin(ph2*PI*w2)+1)/2);
    uai=pow(uai, 2)+0.15;
    //println(uai);
    uai=uai*amp*ph;
    curveVertex(x+i, y2+uai);
  }
  for (int i=0; i<w; i++) {
    float ph=i/w;
    float ph2=1-(i/w);
    ph=(sin(ph*PI));
    ph=pow(ph, pw);
    float uai=((sin(ph2*PI*w2)+1)/2);
    uai=pow(uai, 2)+0.15;
    uai=uai*amp*ph;
    curveVertex(x+(w-i), y2-uai);
  }
  endShape(CLOSE);
  int fillcolor = g.fillColor;
  fill(255);
  textSize(24);
  fill(fillcolor);
  noFill();
}

void tremseq(float chance, float ystart, int octaves) {
  float barsize=width/bars;
  float periods[]={0.5, 1, 2, 4};
  float per=periods[int(random(periods.length))];
  float inc=barsize/per;

  for (int i=0; i<width; i+=inc) {

    inc=barsize/per;
    if (random(100)<chance) {
      tremnote(i, ystart, inc, random(5, 30), octaves);
    }
    per=periods[int(random(periods.length))];
  }
}

void deceltrill(float x, float y, float w, int octaves) {
  float barsize=width/bars;
  float notewA=barsize/16;
  float notewB=barsize/1+(int(random(2)));
  float noteh=(height/float(notegrid));

  int selnote=int(random(scales[selsc].length));
  int selnote2=((selnote+1)%scales[selsc].length);
  int seloctave2=((selnote+1)/scales[selsc].length)*12;
  int seloctave=12*int(random(octaves));


  float y2=y-((seloctave+(scale[selnote]))*noteh);
  float y3=y-(((seloctave+(scale[selnote2]))+seloctave2)*noteh);


  strokeWeight(3);
  int fillcolor = g.fillColor;
  stroke(fillcolor);
  noFill();
  beginShape();

  float notew=notewA;
  for (float i=0; i<w; i+=notew) {
    float ph=i/w;
    //ph=(ph*2)-1;
    //ph=constrain(ph, 0., 1.);
    ph=pow(ph, 2);
    float rng=(notewB-notewA);
    notew=notewA+(ph*rng);
    vertex(x+i, y2);
    vertex(x+i+(notew/2), y2);
    vertex(x+i+(notew/2), y3);
    vertex(x+i+notew, y3);
  }
  endShape(OPEN);
  fill(255);
  textSize(24);
  fill(fillcolor);
  noFill();
}

void trillnote(float x, float y, float w, int octaves) {
  float barsize=width/bars;
  float notew=(barsize/16)*(int(random(2))+1);
  float noteh=(height/float(notegrid));
  int selnote=int(random(scales[selsc].length));
  int selnote2=((selnote+1)%scales[selsc].length);
  int seloctave2=((selnote+1)/scales[selsc].length)*12;
  int seloctave=12*int(random(octaves));

  float y2=y-((seloctave+(scale[selnote]))*noteh);
  float y3=y-(((seloctave+(scale[selnote2]))+seloctave2)*noteh);

  strokeWeight(3);
  int fillcolor = g.fillColor;
  stroke(fillcolor);
  noFill();
  beginShape();
  for (int i=0; i<w; i+=notew) {
    vertex(x+i, y2);
    vertex(x+i+(notew/2), y2);
    vertex(x+i+(notew/2), y3);
    vertex(x+i+notew, y3);
  }
  endShape(OPEN);
  fill(255);
  textSize(24);
  fill(fillcolor);
  noFill();
}

void trillseq(float chance, float ystart, int octaves) {
  float barsize=width/bars;
  float periods[]={0.5, 1, 2, 4};
  float per=periods[int(random(periods.length))];
  float inc=barsize/per;
  for (int i=0; i<width; i+=inc) {
    inc=barsize/per;
    if (random(100)<chance) {
      trillnote(i, ystart, inc, octaves);
    }
    per=periods[int(random(periods.length))];
  }
}

void caniques(int y, int chance) {
  float barsize=width/bars;
  float noteh=(height/float(notegrid));
  float dir=int(random(2));
  float nums[]={8, 12};
  float periods[]={0.25, 0.5, 1};
  float per=periods[int(random(periods.length))];
  float n=nums[int(random(nums.length))];
  float jittery=(int(random(24))-12)*noteh;
  jittery=0;
  float h=noteh*(int(random(12))+1);
  float inc=barsize/per;
  float w=6;

  for (float i=0; i<width; i+=inc) {
    inc=barsize/per;
    float wok=(w/(per/2));
    wok=map(wok, 0, 16, 2, 6);
    float growh=int(random(3))*((int(random(2))*2)-1);
    if (random(100)<chance) {
      marble3(i, y+jittery, inc, n/per, dir, random(8)+2, h, growh, w, 0, 0);
      //void marble3(float xpos, float ypos, float phrasesize, float num, float cntr, float pow, float h, float growh, float w, float groww, float growy ) {
    }
    per=periods[int(random(periods.length))];
    jittery=(int(random(12))-6)*noteh;
    jittery=0;
    h=noteh*(int(random(12))+1);
    dir=int(random(2));
  }
}

void brownamp(float noisesc, float offx, float pow, float amp) {

  float noteh=(height/float(notegrid));
  float v1c=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
  float v2c=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
  float vac=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;
  float vcc=height-((12*(int(random(3))+2)+(scale[int(random(scales[selsc].length))])))*noteh;


  float[] main=new float[width];
  float[] main2=new float[width];
  float[] main3=new float[width];

  float[] contour=new float[width];
  //float brownianvalue(float idx, float w, float noisesc, float maxfreq, float ran)
  fill(255);

  for (int i=0; i<width; i++) {
    contour[i]=brownianvalue(i+(offx*200), width, 0.002, 0.5, 0);
    contour[i]=0;
  }

  // 1
  selectallcolor();
  beginShape();
  for (int i=0; i<width; i++) {
    float uai=brownianvalue(i+offx, width, noisesc, 0.5, 0);
    uai=pow(uai, pow);
    main[i]=pow(uai, 3);
    uai=pow(uai, 1.5);
    uai=uai*amp;
    curveVertex(i, uai+v1c+(contour[i]*100));
  }
  for (int i=0; i<width; i++) {
    float uai=((brownianvalue(width-i+offx, width, noisesc, 0.5, 0)));
    uai=pow(uai, 1.5);
    uai=1-(pow(uai, pow))*amp;
    curveVertex(width-i, uai+v1c+(contour[width-(i+1)]*100));
  }
  endShape(CLOSE);


  // 2
  selectallcolor();
  beginShape();
  for (int i=0; i<width; i++) {
    float env=1-(main[i]);
    float uai=brownianvalue(i+offx+width, width, noisesc, 0.5, 0)*env;
    uai=pow(uai, pow);
    main2[i]=pow(uai, 2);
    uai=uai*amp;
    vertex(i, uai+v2c);
  }
  for (int i=0; i<width; i++) {
    int invi=width-(i+1);
    float env=1-(main[invi]);
    float uai=brownianvalue(invi+offx+width, width, noisesc, 0.5, 0)*env;
    uai=pow(uai, pow);
    uai=uai*-amp;
    vertex(invi, uai+v2c);
  }
  endShape(OPEN);


  // 3
  selectallcolor();
  beginShape();
  for (int i=0; i<width; i++) {
    float env=1-(main2[i]);
    float env2=1-(main[i]);
    float uai=brownianvalue(i+offx+width+width, width, noisesc, 0.5, 0)*env*env2;
    uai=pow(uai, pow);
    main3[i]=pow(uai, 2);
    uai=uai*amp;
    vertex(i, uai+vac);
  }
  for (int i=0; i<width; i++) {
    int invi=width-(i+1);
    float env=1-(main2[invi]);
    float env2=1-(main[invi]);
    float uai=brownianvalue(invi+offx+width+width, width, noisesc, 0.5, 0)*env*env2;
    uai=pow(uai, pow);
    uai=uai*-amp;
    vertex(invi, uai+vac);
  }
  endShape(OPEN);

  // 4
  selectallcolor();
  beginShape();
  for (int i=0; i<width; i++) {
    float env=1-(main3[i]);
    float env2=1-(main2[i]);
    float env3=1-(main[i]);
    float uai=brownianvalue(i+offx+width+width+width, width, noisesc, 0.5, 0)*env*env2*env3;
    uai=pow(uai, pow);
    uai=uai*amp;
    vertex(i, uai+vcc);
  }
  for (int i=0; i<width; i++) {
    int invi=width-(i+1);
    float env=1-(main3[invi]);
    float env2=1-(main2[invi]);
    float env3=1-(main[invi]);
    float uai=brownianvalue(invi+offx+width+width+width, width, noisesc, 0.5, 0)*env*env2*env3;
    uai=pow(uai, pow);
    uai=uai*-amp;
    vertex(invi, uai+vcc);
  }
  endShape(OPEN);
}

void tear(float x, float y, float w, float h, float pow ) {
  int strokeColor=g.strokeColor;
  float vol=random(0.5, 1);
  println(w);
  for (float i=0; i<w; i++) {
    float ph=i/w;
    ph=1-((cos(ph*TWO_PI)+1)/2);
    ph=pow(ph, pow);
    //println(x)
    for (int j=0; j<h; j++) {
      float ph3=j/h;
      ph3=1-((cos(ph3*TWO_PI)+1)/2);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), (ph*255*vol*ph3)/2.);
      point(x+i, y+j);
    }
  }
}

void gradbox2(float x, float y, float w, float h, float pow, int dir) {
  strokeWeight(1);
  int strokeColor=g.strokeColor;
  //strokeCap(PROJECT);
  for (float i=0; i<w; i++) {
    float ph=i/w;
    if (dir==0) {
      ph=1-ph;
    }
    ph=pow(ph, pow);
    stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255.);
    line(x+i, y, x+i, y+h);
  }
}

void gradbox(float x, float y, float w, float h, float gradsize, float pow) {
  strokeWeight(1);
  int strokeColor=g.strokeColor;
  //strokeCap(PROJECT);
  for (float i=0; i<w; i++) {
    float ph=i/w;
    ph=1-ph;
    ph=pow(ph, pow);
    stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255.);
    line(x+i, y+gradsize, x+i, y+(h-gradsize));
  }
  for (float i=0; i<gradsize; i++) {
    float ph=i/gradsize;
    ph=1-ph;
    ph=pow(ph, 1);
    for (float j=0; j<w; j++) {
      float ph2=j/w;
      ph2=1-ph2;
      ph2=pow(ph2, pow);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph2*ph*255.);
      point(x+j, i+y+(h-gradsize)+1);
      point(x+j, y+gradsize-i-1);
    }
  }
}

int arp(int idx, int direction, int steps, int stepsize) {
  int count=0;

  idx=idx%steps;
  switch(direction) {

  case 0:
    count=idx*stepsize; //up
    break;

  case 1:
    count=(steps*stepsize)-(idx*stepsize); //down
    break;

  case 2:
    if (idx<steps/2) { //updown
      count=idx*stepsize;
    } else {
      count=(steps*stepsize)-(idx*stepsize);
    }
    break;

  case 3:
    if (idx<steps/2) { //downup
      count=(steps*stepsize)-(idx*stepsize);
    } else {
      count=idx*stepsize;
    }
    break;

  case 4:
    count=int(random(steps*stepsize));
    break;
  }

  count=constrain(count, 0, 100);
  int note=count%scales[selsc].length;
  int octave=count/scales[selsc].length;

  int p=scale[note]+(12*octave);

  return p;
}

void note(float x, int p, float w, int partials, int partialmode, int firstpartial, float hicutpow, float locutpow, int ampshape, float ampow, int lfoshape,
  float lfocycles, int lfohp, float lfopow, float tremamp, float tremcyc, float vibamp, float vibcyc, float detune, float partDet, float vol) {

  strokeCap(PROJECT);
  int strokeColor2=g.strokeColor;
  float noteh=height/float(notegrid);
  float ranpartamps=0;
  float partamp=1;
  float partialprob=50;
  int start=firstpartial;
  float inc=1;
  switch(partialmode) {
  case 0: //tots
    partialprob=100;
    start =0;
    inc=1;
    ranpartamps=0;
    p=p;
    break;

  case 1: //even
    partialprob=100;
    start =0;
    inc=2;
    ranpartamps=0;
    p=p-12;
    break;

  case 2: //odd
    partialprob=100;
    start=1;
    inc=2;
    ranpartamps=0;
    p=p;
    break;

  case 3: //ranamps
    partialprob=100;
    start =0;
    inc=1;
    ranpartamps=1;
    p=p;
    break;

  case 4: //random
    partialprob=50;
    start =0;
    inc=1;
    ranpartamps=0;
    p=p;
    break;

  case 5: //thinrandom
    partialprob=20;
    start =0;
    inc=1;
    ranpartamps=0;
    p=p;
    break;
  }

  for (float j=start; j<partials+start; j+=inc) {
    float partdetune=random(partDet);
    float partYoffset=partdetune*noteh;
    float y=height-(f2p((p2f(p)*j))*noteh);
    float ph1=j/partials;
    float locut=pow(ph1, locutpow);
    float hicut=pow(1-ph1, hicutpow);
    if (ranpartamps==1) {
      partamp=random(1);
    } else {
      partamp=1;
    }

    if (random(100)<partialprob) {
      for (float i=0; i<w; i++) {
        float ph2=i/w;
        //ph2=1-ph2;
        float mod=lfomod(ph2, lfoshape, lfocycles, y);
        float env=envelope(ph2, ampshape);

        float trem=lfomod(ph2, 2, tremcyc, 0);
        float vib=(lfomod(ph2, 2, vibcyc, 0)*2)-1;
        trem=trem*tremamp*hicut*locut*(pow(env, 2));
        vib=vib*vibamp*(pow(env, 2));

        //amp env
        if (ampow!=0) {
          env=pow(env, ampow);
        } else {
          env=1;
        }

        //lfo env
        if (lfopow!=0) {
          if (lfohp==1) {
            mod=pow(mod, 1+((1-ph1)*lfopow));
          } else {
            mod=pow(mod, 1+((ph1)*lfopow));
          }
        } else {
          mod=1;
        }

        float alpha=((env*mod*hicut*locut*partamp*vol)-trem)*255;
        alpha=constrain(alpha, 0, 255);

        stroke(red(strokeColor2), green(strokeColor2), blue(strokeColor2), alpha);
        point(x+i, int(y+detune)+vib+partYoffset);
        point(x+i, int(y-detune)+vib+partYoffset);
      }
    }
  }

}

void note2(float x, int p, float w, int partials, int partialmode, int firstpartial, float hicutpow, float locutpow, int ampshape, float ampow, int lfoshape,
  float lfocycles, int lfohp, float lfopow, float tremamp, float tremcyc, float vibamp, float vibcyc, float detune, float partDet, float vol) {
  float barsize=width/bars;
  strokeCap(PROJECT);
  int strokeColor2=g.strokeColor;
  float noteh=height/float(notegrid);
  float ranpartamps=0;
  float partamp=1;
  float partialprob=50;
  int start=firstpartial;
  float inc=1;
  switch(partialmode) {
  case 0: //tots
    partialprob=100;
    start =0;
    inc=1;
    ranpartamps=0;
    p=p;
    break;

  case 1: //even
    partialprob=100;
    start =0;
    inc=2;
    ranpartamps=0;
    p=p-12;
    break;

  case 2: //odd
    partialprob=100;
    start=1;
    inc=2;
    ranpartamps=0;
    p=p;
    break;

  case 3: //ranamps
    partialprob=100;
    start =0;
    inc=1;
    ranpartamps=1;
    p=p;
    break;

  case 4: //random
    partialprob=50;
    start =0;
    inc=1;
    ranpartamps=0;
    p=p;
    break;

  case 5: //thinrandom
    partialprob=20;
    start =0;
    inc=1;
    ranpartamps=0;
    p=p;
    break;
  }

  for (float j=start; j<partials+start; j+=inc) {
    float partdetune=random(partDet);
    float partYoffset=partdetune*noteh;
    
    float y=height-(f2p((p2f(p)*j))*noteh);
    float ph1=j/partials;
    float locut=pow(ph1, locutpow);
    float hicut=pow(1-ph1, hicutpow);
    if (ranpartamps==1) {
      partamp=random(1);
    } else {
      partamp=1;
    }

    if (random(100)<partialprob) {
      for (float i=0; i<w; i++) {
        float ph2=i/w;
        //ph2=1-ph2;
        float mod=lfomod(ph2, lfoshape, lfocycles, y);
        float env=envelope(ph2, ampshape);

        float trem=lfomod(ph2, 2, tremcyc, 0);
        float vib=(lfomod(ph2, 2, vibcyc, 0)*2)-1;
        trem=trem*tremamp*hicut*locut*(pow(env, 2));
        vib=vib*vibamp*(pow(env, 2));
        int tr=transposeList[int((x+i)/barsize)];
        tr=int(tr*noteh);

        //amp env
        if (ampow!=0) {
          env=pow(env, ampow);
        } else {
          env=1;
        }

        //lfo env
        if (lfopow!=0) {
          if (lfohp==1) {
            mod=pow(mod, 1+((1-ph1)*lfopow));
          } else {
            mod=pow(mod, 1+((ph1)*lfopow));
          }
        } else {
          mod=1;
        }
        
        float alpha=((env*mod*hicut*locut*partamp*vol)-trem)*255;
        alpha=constrain(alpha, 0, 255);

        stroke(red(strokeColor2), green(strokeColor2), blue(strokeColor2), alpha);
        point(x+i, int(y+detune)+vib+partYoffset-tr);
        point(x+i, int(y-detune)+vib+partYoffset-tr);
      }
    }
  }

}


float envelope(float ph, int shape) {
  float result=0;
  switch(shape) {
  case 0: // saw
    result=1-((ph)%1);
    break;

  case 1:  //isaw
    result=((ph)%1);
    break;

  case 2: //cos
    result=1-(((cos(ph*TWO_PI))+1)/2);
    break;
  }
  return result;
}

float lfomod(float ph, int shape, float cycles, float noisey) {
  float result=0;
  switch(shape) {
  case 0: // saw
    result=1-((ph*cycles)%1);
    break;

  case 1:  //isaw
    result=((ph*cycles)%1);
    break;

  case 2: //cos
    result=1-(((cos(ph*TWO_PI*cycles))+1)/2.);
    break;

  case 3: //icos
    result=(((cos((ph+0.5)*TWO_PI*cycles))+1)/2.);
    break;

  case 4:
    result=prng.perlin(ph*cycles*2, noisey/(cycles*3));
    result=constrain(result, 0., 1.);
    result=pow(result, 1);
    break;
  }
  return result;
}

void resetcolors() {
  stroke(255);
  fill(255);
  selectstrokecolor();
  selectcolor();
}

float fmsin(float ph, float noisesc, float maxfreq, float ran) { //retorna un float vacquie
  noiseDetail(1, 0.1);
  float env=0;
  float noiseVal = noise(ph*noisesc, ran*noisesc)*2;
  ph=(noiseVal*maxfreq)%1;
  env=(1+sin(TWO_PI*ph))/2;
  return env;
}

void fmamsin(int x, int y, int w, float minh, float maxh, float maxfmfreq, float maxamfreq){
  selectstrokecolor();
  strokeCap(PROJECT);
  float ran=random(100);
  float ran2=random(100);
  for(float i=0;i<w;i++){
    float ph=i/float(w);
    float ar=1-(abs((ph*2)-1));
    //ar=constrain(ar*2,0.,1.);
    float b=fmsin(ph,2,maxfmfreq,ran);
    float y2=fmsin(ph,2,maxamfreq,ran2);
    float linelen=(y2*maxh)+minh;
    for(float j=0;j<linelen;j++){
      float phy=j/linelen;
      phy=1-phy;
      phy=sin(phy*HALF_PI);
      phy=pow(phy,2);
      stroke(255,255*b*ar*phy);
      point(x+i,y-(j/2)-0.5);
      point(x+i,y+(j/2));
    }
  }
  strokeCap(ROUND);
}

void vignette(float w) {
  float wid=width/w;
  strokeWeight(1);
  for (int i=0; i<wid; i++) {

    float ph=1-(i/(wid));
    ph=pow(ph, 2);
    stroke(0, ph*255);
    line(i, 0, i, height);
    line(width-i, 0, width-i, height);
  }
}

void amlfo(float x, float y, float w, float h, float noisescale, float maxfreq) {
  strokeWeight(1);
  strokeCap(ROUND);
  int ran=int(random(2000));
  float nssc=noisescale;
  float mxfq=maxfreq;
  for (int i=0; i<w; i++) {
    float brn=brownianvalue(i, width, nssc, mxfq, ran);
    float env=float(i)/width;
    env=1-(abs((env*2)-1));
    env=constrain(2*env, 0., 1.);
    env=pow(1-env, 1);
    stroke(0, brn*255);
    line(x+i, y, x+i, y+h);
  }
}

void brownianblock(float x, float y, float w, float h, float noisesc, float maxfreq, float ran, float envpow, float tremolo) { //fa un bloc vacquie
  strokeWeight(1);
  int strokeColor=g.strokeColor;
  noiseDetail(1, 0.1);
  float tremfreq=random(1, 32);
  float tremamp=((width/notegrid)/random(8, 32))*tremolo;

  for (int i=0; i<w; i++) {

    float ph=i/w;

    float posy=sin(TWO_PI*ph*tremfreq)*tremamp;
    float noiseVal = prng.perlin(((x*100)+i*noisesc), ran*noisesc);
    noiseVal=pow(noiseVal*2, 2);
    ph=(noiseVal*maxfreq)%1;
    float env=(1+sin(TWO_PI*ph))/2;
    float env2=float(i)/w;
    env2=1-(abs((env2*2)-1));
    env2=constrain(2*env2, 0., 1.);
    env2=pow(env2, envpow);
    stroke(red(strokeColor), green(strokeColor), blue(strokeColor), env*255*env2);
    line(x+i, y-(h/2)+posy, x+i, y+(h/2)+posy);
  }
}

float brownianvalue(float idx, float w, float noisesc, float maxfreq, float ran) { //retorna un float vacquie
  noiseDetail(1, 0.1);
  float env=0;
  float ph=idx/w;
  float noiseVal = prng.perlin((idx*noisesc), ran*noisesc);
  noiseVal=pow(noiseVal*2, 1);
  ph=(noiseVal*maxfreq)%1;
  env=(1+sin(TWO_PI*ph))/2;

  return env;
}

int randomfills(int idx, int steps, int seed) {
  int[] fills = new int[steps];
  randomSeed(seed);
  for (int i=0; i<steps; i++) {
    float ran=random(1);
    ran=pow(ran, 1.5);
    fills[i]=round(ran);
  }
  return fills[idx];
}

float skew(float skewness, float ph) {
  float out=0;
  skewness=(skewness+1)/2;
  if (ph>skewness) {
    if ((ph-skewness)>=0) {
      out=(((ph-skewness)/(1-skewness))*0.5)+0.5;
    }
  } else {
    if ((ph/skewness)>=0) {
      out=(ph/skewness)*0.5;
    }
  }
  return out;
}

void linesaw(int x, int y, float w, float pow, float stroke) {
  float slower=16/bars;
  strokeWeight(stroke);
  strokeCap(ROUND);
  for (float i=0; i<w; i++) {
    float ph=i/w;
    ph=pow(1-ph, pow);
    int strokeColor=g.strokeColor;
    stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255);
    point(x+i, y);
  }
}

void linesin(int x, int y, float w, float pow) {
  for (float i=0; i<w; i++) {
    float ph=i/w;
    ph=(1+cos(TWO_PI*ph))/2;
    ph=pow(1-ph, pow);
    int strokeColor=g.strokeColor;
    stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255);
    point(x+i, y);
  }
}

static final boolean
  containsAnyOfRange(final IntList il, int low, final int high) {
  if (il != null)  while (low <= high)  if (il.hasValue(low++))  return true;
  return false;
}

float sigmoid(float ph, float tens) {
  tens=-tens;
  float norm=(ph*2)-1;
  float out=(((norm-(norm*tens))/((tens-(abs(norm)*2*tens))+1))+1)/2;
  return out;
}

float p2f(float pitch) {
  return(440*(pow(2, (pitch-69)/12)));
}

float f2p(float freq) {
  return(69+12*log2(freq/440));
}

float log2(float x) {
  return(log(x)/log(2));
}

int[] probsteps(int[] chances){
  int[] result=new int[chances.length];
  for(int i=0;i<chances.length;i++){
    if(random(100)<chances[i]){
      result[i]=1;
    }
    else{
      result[i]=0;
    }
  }
  return result;
}

int euclidean(int idx, int steps, int fills, int shift) {
  if ((((idx+shift)*fills)%steps)<fills) {
    return 1;
  } else {
    return 0;
  }
}

float lfofloat(int wave, float w, float idx, float cycles, float pow) {
  float ph=idx/w;
  ph=(cos(ph*TWO_PI*cycles)+1)/2;
  ph=pow(ph, pow);
  return 1-ph;
}

void lfo2(int wave, int filtmode, float x, float w, float cyclesstart, float cyclesend, float starty, float endy, float startamp, float endamp) {
  strokeWeight(1);
  float ran=int(random(2000));
  //
  for (float i=0; i<w; i++) {
    float ph3=brownianvalue(i, w, 0.001, 1, ran);
    float ph=i/w;
    float cyc=cyclesstart+(ph*(cyclesend-cyclesstart));
    float yprog=starty+(ph*(endy-starty));
    float amprog=startamp+(ph*(endamp-startamp));

    if (wave==0) {
      ph=ph*w;
    }
    if (wave==1) {
      ph=ph3*w;
    }
    float y=lfofloat(0, w, ph, cyc, 1);

    if (filtmode==1) {
      stroke(0, 255);
      line(x+i, (y*amprog), x+i, height); //hp
      for (float j=0; j<100; j++) {
        strokeWeight(2);
        float phj=1-(j/100.0);
        stroke(0, 255*pow(phj, 2));
        point(x+i, int((y*amprog)-j)+5);
      }
    }

    if (filtmode==0) {
      stroke(0, 255);
      line(x+i, 0, x+i, (y*amprog)); //lp
      for (float j=0; j<100; j++) {
        strokeWeight(2);
        float phj=1-(j/100.0);
        stroke(0, 255*pow(phj, 2));
        point(x+i, int((y*amprog)+j)-5);
      }
    }
  }
}
void lfo(int wave, float bardur, float cycles, float phase, float cut0, float amp0, float cut1, float amp1, float grad) {
  float barsize=width/bars;
  bardur=bardur*barsize;
  for (int i=0; i<bardur; i++) {
    float ph=(i/bardur);
    float cutamp=(cut1-cut0);
    float ampamp=(amp1-amp0);
    float cut=(cutamp*ph)+cut0;
    float amp=(ampamp*ph)+amp0;
    float gradamp=(amp/height);
    if (wave==0) {
      ph=(ph+((1/cycles)*phase))%1;
      ph=(sin(ph*TWO_PI*cycles)+1)/2;
    }
    if (wave==1) {
      ph=(ph*cycles)%1;
    }
    if (wave==2) {
      ph=1-((ph*cycles)%1);
    }
    if (wave==3) {
      ph=abs((((ph*cycles)%1)*2)-1);
    }
    if (wave==4) {
      ph=brownianvalue(i, bardur, 0.01, cycles/4, 2000);
    }
    ph=cut+(ph*amp);
    filterline(i, int(ph), height, grad/gradamp);
  }
}

void dottedLine(float x1, float y1, float x2, float y2, float steps) {
  for (int i=0; i<=steps; i++) {
    float x = lerp(x1, x2, i/steps);
    float y = lerp(y1, y2, i/steps);
    point(x, y);
  }
}

void dashLine(float x0, float y0, float x1, float y1, float[ ] spacing)
{
  float distance = dist(x0, y0, x1, y1);
  float [ ] xSpacing = new float[spacing.length];
  float [ ] ySpacing = new float[spacing.length];
  float drawn = 0.0;  // amount of distance drawn

  if (distance > 0)
  {
    int i;
    boolean drawLine = true; // alternate between dashes and gaps

    /*
     Figure out x and y distances for each of the spacing values
     I decided to trade memory for time; I'd rather allocate
     a few dozen bytes than have to do a calculation every time
     I draw.
     */
    for (i = 0; i < spacing.length; i++)
    {
      xSpacing[i] = lerp(0, (x1 - x0), spacing[i] / distance);
      ySpacing[i] = lerp(0, (y1 - y0), spacing[i] / distance);
    }

    i = 0;
    while (drawn < distance)
    {
      if (drawLine)
      {
        line(x0, y0, x0 + xSpacing[i], y0 + ySpacing[i]);
      }
      x0 += xSpacing[i];
      y0 += ySpacing[i];
      /* Add distance "drawn" by this line or gap */
      drawn = drawn + mag(xSpacing[i], ySpacing[i]);
      i = (i + 1) % spacing.length;  // cycle through array
      drawLine = !drawLine;  // switch between dash and gap
    }
  }
}
