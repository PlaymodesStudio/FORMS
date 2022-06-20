void singlegate(float barpos, float w) {
  float noteheight=height/float(notegrid);
  float barsize=width/bars;
  float posx=barpos*barsize;
  w=barsize*w;
  float h=noteheight*(4+(int(random(24))));
  float posy=noteheight*int(random((notegrid/1.5)));
  noStroke();
  fill(0);
  rectMode(CORNER);
  rect(posx, 0, w, height);
}



void gater(float barpos, float bardur, float num, float pw, float mode, float pow) {

  float barsize=width/bars;
  float notewidth=barsize/bardiv;
  float posx=barpos*barsize;
  float w=((bardur*barsize)/num);
  strokeWeight(1);
  for (int i=0; i<num; i++) {
    for (float j=0; j<w*pw; j++) {
      float ph=j/(w*pw);
      float env=0;
      if (mode==0) {
        env=1;
      }
      if (mode==1) {
        env=pow(ph, 1/pow);
        //println(env);
      }
      if (mode==2) {
        env=1-pow(ph, pow);
      }
      if (mode==3) {
        env=(abs((ph*2)-1));
        env=pow(env, 1/pow);
      }
      stroke(0, 0, 0, env*255);
      line(posx+(i*w)+j, 0, posx+(i*w)+j, height);
    }
  }
}

void beatRepeat(float barposx, float divw, int num, float gate) {
  float barsize=width/bars;
  float notewidth=(barsize/bardiv);
  int w=int(divw*notewidth);
  int posx=int(barposx*barsize);
  noStroke();
  for (int i=0; i<num; i++) {
    copy(posx, 0, w, height, posx+(w*i), 0, w, height);
  }
  float gatew=w*(1-gate);
  for (int i=0; i<num; i++) {
    fill(0);
    rect((posx+w-gatew)+(w*i), 0, gatew, height);
  }
}

void beatRepeat2(float barposx, float bardur, float num, float gate, float semitones) {
  float noteheight=height/float(notegrid);
  float barsize=width/bars;
  bardur=bardur*barsize;
  float w=bardur/num;
  float posx=int(barposx*barsize);
  semitones=-int(semitones*noteheight);
  rectMode(CORNER);
  noStroke();
  fill(0);
  for (float i=0; i<int(num); i++) {
    int sem=int((semitones/num)*i);
    copy(int(posx), 0, int(w), height, int(posx+(w*i)), sem, int(w), height);
  }

  float gatew=(w*(1-gate));
  for (float i=0; i<int(num); i++) {
    rect((posx+w-gatew)+(w*i), 0, gatew, height);
  }
  for (float i=0; i<int(num); i++) {
    int sem=int((semitones/num)*i);
    if (sem>0) {

      rect(posx+(w*i), 0, w, sem);
    } else {

      rect(posx+(w*i), height+sem, w, -sem);
      //rect(posx+(w*i), 0, w, height);
    }
  }
}

void transpose(float barposx, int barw, int semitones) {
  float noteheight=height/float(notegrid);
  float barsize=width/bars;
  int posx=int(barposx*barsize);
  int w=int(barw*barsize);
  semitones=-int(semitones*noteheight);
  noStroke();
  copy(posx, 0, w, height, posx, semitones, w, height);
  fill(0);
  if (semitones>0) {
    rect(posx, 0, w, semitones);
  } else {
    rect(posx, height+semitones, w, -semitones);
  }
}

void freeze(float barposx, float barlen) {
  float barsize=width/bars;
  float w=1;
  int posx=int(barposx*barsize);
  int num=int(barsize*barlen);
  noStroke();
  for (int i=1; i<num; i++) {
    copy(posx, 0, 1, height, posx+i, 0, 1, height);
  }
}

void filterline(int x, int y, float h, float grad) {

  for (int i=0; i<h; i++) {
    float ph=grad-(i/(h/grad));
    ph=constrain(ph, 0, 1);
    stroke(0, (ph)*255);
    point(x, i-y);
  }
}

///////////////////////////////////////////////////////////////

void fx1_transpose() {
  int dau=int(random(2));

  for (int i=0; i<bars; i++) {
    int tr=0;
    int transcale0[]={0, 0, 3, 3, 6};
    int transcale1[]={0, 5, 7};
    int transcale2[]={0, 0, 4, 4, 8};
    int transcale3[]={0, 4};
    int transcale4[]={0, 2, 4, 6};
    int transcale5[]={0, 3};
    int transcale6[]={0, 1, 8};
    int transcale7[]={0, 4};
    int transcale8[]={0, 7};
    int transcale9[]={0, 7};
    int transcale10[]={0, 1};

    switch(selsc) {
    case 0:
      tr=transcale0[int(random(transcale0.length))];
      break;

    case 1:
      tr=transcale1[int(random(transcale1.length))];
      break;

    case 2:
      tr=transcale2[int(random(transcale2.length))];
      break;

    case 3:
      tr=transcale3[int(random(transcale3.length))];
      break;

    case 4:
      tr=transcale4[int(random(transcale4.length))];
      break;

    case 5:
      tr=transcale5[int(random(transcale5.length))];
      break;

    case 6:

      if (dau==0) {
        tr=transcale6[int(random(transcale6.length))];
      } else {
        tr=transcale10[int(random(transcale10.length))];
      }
      break;

    case 7:
      tr=transcale7[int(random(transcale7.length))];
      break;

    case 8:
      tr=transcale8[int(random(transcale8.length))];
      break;

    case 9:
      tr=transcale9[int(random(transcale9.length))];
      break;

    case 10:
      tr=transcale9[int(random(transcale9.length))];
      break;
    }

    transpose(i, 1, tr);//transpose(float barposx, int barw, float semitones)
  }
}

void fx2_gate() {
  for (float i=0; i<bars; i++) {
    float ranshift=0.5+(0.0625*(1+int(random(8))));
    if (random(100)<25) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }
}

void fx3_repeat() {
  float pws[]={0.666, 1};
  float pw=pws[int(random(pws.length))];
  pw=0.666;
  for (int i=0; i<bars; i++) {
    float ranshift=0.5*int(random(2));
    float divs[]={1.333, 2.6666, 4, 8};
    float temp=divs[int(random(divs.length))];
    if (random(100)<15) {
      beatRepeat2(i+ranshift, 1-ranshift, temp, pw, 0);
    }
  }
  pw=pws[int(random(pws.length))];
  for (int i=0; i<bars; i++) {
    float ranshift=0.5+(int(random(2))*0.25);
    float divs[]={1.3333, 2, 3, 4, 6};
    float temp=divs[int(random(divs.length))];
    if (random(100)<15) {
      beatRepeat2(i+ranshift, 1-ranshift, temp, pw, 0);
    }
  }
  pw=pws[int(random(pws.length))];
  for (int i=0; i<bars; i+=2) {
    float divs[]={2, 2.6666, 4};
    float temp=divs[int(random(divs.length))];
    if (random(100)<6) {
      beatRepeat2(i, 2, temp, pw, 0);
    }
  }
}


void fx4_freeze() {
  float inc=1;
  float count=0;
  for (float i=0; i<bars*2; i+=inc) {
    freeze(count, inc);//freeze(barpos,barlen);
    count+=inc;
    float raninc[]={0.25, 0.5, 1, 2, 4};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }
}

void fx5_mask(){
  hole4(0, width, 2, 0); //mask
}

void fx6_gateAbuse() {
  float inc=1;
  float count=0;
  for (float i=0; i<bars*2; i+=inc) {
    freeze(count, inc);//freeze(barpos,barlen);
    float divs[]={2, 3, 4, 6, 8, 12};
    float temp=divs[int(random(divs.length))];
    float modegate=1+int(random(3));
    float pow=random(4)+1;
    gater(count, inc, temp, 1, modegate, pow); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
    count+=inc;
    float raninc[]={0.25, 0.5, 1, 2, 4};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }
}

void fx7_combo1() {


  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<15) {
      freeze(i+ranshift, 1-ranshift);//freeze(float barposx, float barlen)
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<25) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }


  for (int i=0; i<bars; i+=2)
  {
    transpose(i, 2, 5*int(random(2)));//transpose(float barposx, int barw, float semitones)
  }

  for (float i=0; i<bars; i+=1) {
    float sign=((i%2)*2)-1;
    float pitch=int(random(2))*int(random(2))*int(random(2));
    float divs[]={2, 4, 6, 8, 12, 16};
    float temp=divs[int(random(divs.length))];
    if (random(100)<15) {
      beatRepeat2(i, 1, temp, 0.666, sign*5*pitch);
    }
  }
}

void fx8_rhythmFreeze() {
  for (int i=0; i<bars; i++) {
    float ranshift=0.5+(0.0625*(int(random(9))));
    if (random(100)<30) {
      freeze(i+ranshift, 1-ranshift);//freeze(float barposx, float barlen)
    }
  }
  for (int i=0; i<bars; i++) {
    float ranshift=(0.125*(int(random(5))));
    if (random(100)<25) {
      freeze(i+ranshift, 0.5-ranshift);//freeze(float barposx, float barlen)
    }
  }

  for (int i=0; i<bars; i++) {
    if (random(100)<2) {
      freeze(i, i);//freeze(float barposx, float barlen)
    }
  }
}

void fx9_rhythmGate() {
  float nums[]={1, 2, 4, 6, 8, 12, 16, 24};

  float num=4;
  float inc=1;
  for (float i=0; i<bars; i+=inc) {
    if (random(100)<25) {
      num=nums[int(random(nums.length))];
      for (float j=0; j<num; j++) {
        singlegate(i+(j/num)+(1/(num*2)), 1/(num*2));
      }
    }
  }
}

void fx10_combo2() {
  fx8_rhythmFreeze();
  fx9_rhythmGate();
  fx3_repeat();
  fx1_transpose();
}

void echo(float barposx, float divw, int num, float divtime, float wet, float blur, float sendprob) {
  float barsize=width/bars;
  float divsize=barsize/bardiv;
  barposx=barsize*barposx;
  divw=divw*divsize;
  divtime=divtime*divsize;
  PImage echo=get(int(barposx), 0, int(divw), height);
  if (random(100)<sendprob) {
    fill(0);
    noStroke();
    rectMode(CORNER);
    rect(barposx, 0, int(divtime)*num, height);
  }
  blendMode(ADD);
  wet=wet*255;
  for (float i=0; i<num; i++) {
    float ph=pow(i/num, 0.4);
    tint(255, wet-(ph*wet));
    echo.filter(BLUR, (i+1)*blur);
    image(echo, barposx+(divtime*(i+1)), 0);
  }
  blendMode(BLEND);
}

void fx11_echo() {
  for (float i=0; i<bars; i++) {
    float ranshift=0.25*int(random(4));

    float temps[]={1, 2, 3, 4, 6, 8};
    float temp=temps[int(random(temps.length))];

    int nums[]={4, 6, 8, 12};
    int num=nums[int(random(nums.length))];

    float widths[]={0.5, 1, 2};
    float w=widths[int(random(widths.length))];

    if (random(100)<25) {
      echo(i+ranshift, temp*w, num, temp, 0.5, 0, 25);
    }
  }
}

void fx12_echoFull() {


  float temps[]={1,1, 2, 3,3, 4, 6,6, 8};
  float temp=temps[int(random(temps.length))];

  int nums[]={4, 6, 8, 12};
  int num=nums[int(random(nums.length))];

//void echo(float barposx, float divw, int num, float divtime, float wet, float blur, float sendprob)
  echo(0, bars*bardiv, num, temp, 0.5, 0, 0);
}

void fx13_reverb() {


  float temps[]={1, 2, 3, 4};
  float temp=temps[int(random(temps.length))];

  int nums[]={4, 6, 8, 12};
  int num=nums[int(random(nums.length))];

  float widths[]={0.5, 1, 2};
  float w=widths[int(random(widths.length))];

  echo(0, bars*bardiv, num, temp, 0.5, 1, 0);
  //void echo(float barposx, float divw, int num, float divtime, float wet, float blur, float sendprob)
}

void fx14_filter() {
  fill(0);
  perlinfilter(0.4, 1, 5); //6 era 3
}

void fx15_BPfilter() {
  float barsize=width/bars;
  float incs[]={0.0625, 0.125, 0.25, 0.5};
  float inc=incs[int(random(incs.length))];
  float fig=1/inc;
  float inc2=barsize/fig;
  //strokeCap(PROJECT);
  strokeWeight(1);
  stroke(0, 255);
  for (int i=0; i<width; i+=inc2) {
    float sc=pow(random(100)/100, 4);
    sc=map(sc, 0., 1., 0.001, 0.01);
    //spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power, float pow2)
    spectralblockb(i, 0, inc2, height, sc, 0, 4, 4);
    spectralblockb(i, 0, inc2, height, sc, 0, 4, 4);
  }
  stroke(255);
}

void fx16_BPfilterHard() {
  float barsize=width/bars;
  float incs[]={0.0625, 0.125, 0.25, 0.5};
  float inc=incs[int(random(incs.length))];
  float fig=1/inc;
  float inc2=barsize/fig;
  strokeCap(ROUND);
  for (int i=0; i<width; i+=inc2) {
    rectMode(CENTER);
    float rn1=random(height);
    float rn2=random(height);
    fill(0);
    noStroke();
    rect(i+(inc2/2), rn1, inc2, rn2);
    rect(i+(inc2/2), rn1, inc2, rn2);
    rectMode(CORNER);
    for (float j=0; j<33; j++) {
      float ph=j/33.;
      ph=1-ph;
      strokeWeight(1);
      stroke(0, ph*255);
      line(i, (rn1-(rn2/2))-j, i+inc2, (rn1-(rn2/2))-j);
      line(i, (rn1+(rn2/2))+j, i+inc2, (rn1+(rn2/2))+j);
    }
  }
}

void fx17_reverb2() {


  float temps[]={0.5};
  float temp=temps[int(random(temps.length))];

  int nums[]={16};
  int num=nums[int(random(nums.length))];

  echo(0, bars*bardiv, num, temp, 0.5, 2, 0);
  //void echo(float barposx, float divw, int num, float divtime, float wet, float blur, float sendprob)
}

void fx18_barGate() {
  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      singlegate(i, 1);
    }
  }
}

void fx19_halfBarGate() {
  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      singlegate(i+0.5, 0.5);
    }
  }
}

void fx20_quarterBarGate() {
  for (float i=0; i<bars; i++) {
    if (random(100)<8) {
      singlegate(i+0.75, 0.25);
    }
  }
}

void fx21_BPfilterHardProb() {
  float barsize=width/bars;
  float incs[]={0.0625, 0.125, 0.25, 0.5};
  float inc=incs[int(random(incs.length))];
  float fig=1/inc;
  float inc2=barsize/fig;
  strokeCap(ROUND);
  for (int i=0; i<width; i+=inc2) {
    rectMode(CENTER);
    float rn1=random(height);
    float rn2=random(height);
    fill(0);
    noStroke();
    rect(i+(inc2/2), rn1, inc2, rn2);
    rect(i+(inc2/2), rn1, inc2, rn2);
    rectMode(CORNER);
    if(random(100)<5){
    for (float j=0; j<33; j++) {
        float ph=j/33.;
        ph=1-ph;
        strokeWeight(1);
        stroke(0, ph*255);
        line(i, (rn1-(rn2/2))-j, i+inc2, (rn1-(rn2/2))-j);
        line(i, (rn1+(rn2/2))+j, i+inc2, (rn1+(rn2/2))+j);
      }
    }
  }
}

void fx22_microGates(){
  fill(0);
  noStroke();
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  for(float i=0;i<bars;i+=0.25){
    float stepw=stepsize/(int(random(2))+1);
    if(random(100)<8){
      rect((i*barsize)-stepw,0,stepw,height);  
    }
  }
}

void fx23_highPass(){
  for(int i=0;i<height/3;i++){
    float ph=i/(height/3.);
    ph=1-ph;
    stroke(0,ph*255);
    line(0,height-i,width,height-i);
  }
}

void fx24_repeat3(){
  


    //noiseblocks
    for (float i=0; i<bars; i+=0.5) {
      float ranshift=(0.0625*(1+int(random(2))));
      if (random(100)<12) {
        freeze(i-ranshift, ranshift);
      }
    }
    
  for (int i=0; i<bars; i++) {
    float ranshift=0.5*int(random(2));
    float divs[]={1.333, 2.6666, 4,8, 16};
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

void fx25_vignette(){
  vignette(4);
}
