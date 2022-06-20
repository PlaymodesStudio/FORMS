
void arpeggiovibes() {
  perlin(0.4, 0.5);
  hole(0);
  float ran=random(0.01);
  /*
for(int i=0;i<32;i++){
   if(random(100)<50){
   base(0,bars,i);
   }
   noteam(0,bars,i,random(ran));
   }
   */
  harmonics(0, 4, 0, 32);

  float frspeed[]={0.0625, 0.125, 0.25, 0.5, 1, 2, 3, 4, 8};
  float fr=frspeed[int(random(frspeed.length))];
  lfo(0, bars, bars*fr, 0.75, 200, height, 200, height, 2); //lfo(int wave, float bardur, float cycles, float phase, float cut0, float amp0, float cut1, float amp1, float grad)





  for (int i=0; i<bars-2; i+=2) {

    additive2(-12, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
    additive(-12, i, 512, 8, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  for (float i=0; i<bars; i++) {
    int rand=int(random(2))+1;
    if (random(100)<15) {
      gater(i, 1, 16*rand, 0.5, 0, 2); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
    }
  }

  fill(0, 64);
  noStroke();
  rect(0, 0, width, height);

  for (float i=0; i<bars; i++) {
    float part=1+int(random(4, 8));
    float nums[]={1, 1.33333};
    float num=nums[int(random(nums.length))];
    additive(-12, i, 64, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
    //thump2(i,0.5,num,100);
  }


  float inc=1;
  float count=0;
  float randindex2[]={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  for (int i=0; i<bars; i++) {
    randindex2[i]=int(random(2));
  }
  for (float i=0; i<bars-2; i+=inc) {
    int oct=12*(int(random(4)));
    int p=scale[int(random(scales[selsc].length))]+oct;
    int index=int(i);
    if (randindex2[index]==1) {
      harmonics2(p, i, 4, 1, 1, 1, 16);//harmonics2(float p, float barpos, float bardur, int mode, int partmode, int envmode,int maxparts)
    }
    count+=inc;
    float raninc[]={0.25, 0.5, 1};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }

  for (int i=0; i<bars; i++) {
    float nums[]={4, 8, 12, 16, 24};
    float num=nums[int(random(nums.length))];
    int tr=transposeList[int(i)];
    arpeggio(i, 1, num, 1+random(1), 3, 3+int(random(4)), 6,tr); //void arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, float modulo)
  }
  for (int i=0; i<bars; i++) {
    float nums[]={4, 8, 12, 16, 24};
    float num=nums[int(random(nums.length))];
    int tr=transposeList[int(i)];
    arpeggio(i, 1, num, 1+random(1), 2, 3+int(random(4)), 6,tr);
  }

  float div[]={8, 10.666666, 12, 16};
  float tempo=div[int(random(div.length))];
  float randindex[]={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  for (int i=0; i<bars; i++) {
    randindex[i]=int(random(2));
  }
  for (float i=0; i<bars; i+=1/tempo) { //additive melody
    float part=int(random(4, 24));
    int posscale=int(random(scales[selsc].length));
    int octave=12*(int(random(2)));
    int index=int(i);
    if (randindex[index]==1) {
      if (random(100)<50) {
        additive(-12+octave, i, (bars/tempo), part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
      }
    }
  }

  for (int i=0; i<bars; i++) {
    float nums[]={2.66666, 3, 4, 5.333333, 6, 8, 12, 16, 24};
    float n=nums[int(random(nums.length))];
    if (random(100)<25) {
      //sticks2(i,1,n);//sticks2(float barstart, float bardur,float num)
    }
  }

  thump(2, 100, 0);
  snare(1, 50, 1);

  for (int i=0; i<bars; i++) {
    int trans[]={0, 5, 7};
    int tr=trans[int(random(trans.length))];
    transpose(i, 1, tr);//transpose(float barposx, int barw, float semitones)
  }
}
void wendyvibes() {
  perlin(0.4, 0.5);
  hole4(0, width, 4, 0);
  for (int i=0; i<bars-2; i+=2) {
    int p=scale[int(random(scales[selsc].length))]+-12;
    additive2(p, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }
  for (float i=0; i<bars; i++) {
    int oct=12*(int(random(3))+2);
    int p=scale[int(random(scales[selsc].length))]+oct;
    additive2(p, i, 32, 8, 1, 2, 6, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }
  //cloud();
  //harmonics(0,4,0,32);
  //harmonics(0,4,0,32);
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0,tr);//chord2(int mode, float barstart, float bardur)
  }
  int num=int(random(3));
  for (int i=0; i<num; i++) {
    int dur=int(random(4))+2;
    int st=int(random(bars-dur));
    marble(st, dur);//marble(int barstart, int bardur)
  }


  float inc=1;
  float count=0;
  for (float i=0; i<bars*2; i+=inc) {
    int oct=12*(int(random(4)));
    int p=scale[int(random(scales[selsc].length))]+oct;
    harmonics2(p, i, 4, 1, 1, 1, 16);//harmonics2(float p, float barpos, float bardur, int mode, int partmode, int envmode,int maxparts)
    count+=inc;
    float raninc[]={0.125, 0.25, 0.5, 1};
    float ri=raninc[int(random(raninc.length))];
    inc=ri;
  }
}

void dubstepvibes() {
  selsc=15;
  selectscale(selsc);
  perlin(0.4, 1);
  hole(0);
  melody(0, 0, int(random(4)), int(bars), 0, 2, 2, int(random(8, bardiv)), 2, 2, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)


  for (int i=0; i<2; i++) {
    harmonics(0, 4, 0, 16);
  }
  for (float i=0; i<bars; i++) {
    freeze(i, 1);//freeze(barpos,barlen);
    gater(i, 1, 1, 1, 1, 2); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
  }
  selsc=13;
  selectscale(selsc);
  //melody(0,0,int(bars),0,4,2,int(random(8,bardiv)),2,2,4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  //melody(0,1,int(bars),0,6,2,int(random(8,bardiv)),2,2,4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  for (int i=0; i<bars; i+=2) {
    int p=0;
    additive2(p, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }
  for (int i=0; i<1; i++) {
    int h=int(random(8))+1;
    int steps[]={7, 8, 9, 11, 12, 16};
    int fills[]={2, 3, 4, 5};
    int step=steps[int(random(steps.length))];
    int fill=fills[int(random(fills.length))];
    eurhythm(0, bars, 1, 60+int(random(20)), h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
  }

  for (int i=0; i<bars; i++) {
    float nums[]={2.66666, 3, 4, 5.333333, 6, 8, 12, 16, 24};
    float n=nums[int(random(nums.length))];
    if (random(100)<50) {
      sticks2(i, 0.5, n/2);//sticks2(float barstart, float bardur,float num)
    }
  }


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

  //vibrato(20,1,3);

  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0,tr);//chord2(int mode, float barstart, float bardur)
  }

  for (float i=0; i<bars; i++) {
    if (random(100)<25) {
      singlegate(i+0.5, 0.5);
    }
  }
  pointchords(0.25+(1/8.), bars, 2, 2, 2, 8); ////pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  pointchords(0.25, bars, 2, 3, 2, 8);
  harmonics(0, 4, 0, 32);
  harmonics(0, 4, 0, 32);



  for (float i=0; i<bars; i++) {
    float part=1+int(random(2, 16));
    float nums[]={1, 1.33333f, 2, 2.66666, 3, 4};
    float num=nums[int(random(nums.length))];
    snare2(i+0.5, 0.5, num, 80);
    additive(0, i, 16, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
    float num2=nums[int(random(nums.length))];
    thump2(i, 0.5, num2, 80);
  }

  for (int i=0; i<bars; i++) {
    int trans[]={0, 1};
    int tr=trans[int(random(trans.length))];
    transpose(i, 1, tr);//transpose(float barposx, int barw, float semitones)
  }
}

void brianvibes() {
  atmosvibes2();
  cloud();
  resetcolors();
  for (float i=0; i<bars; i+=2) {
    freeze(i, 2);//freeze(barpos,barlen);
    float part=1+int(random(2, 16));
    float octave=12*int(random(2));
    gater(i, 2, 1, 1, 1, 2); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
    additive(-12, i, 64, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }
  resetcolors();
  melody(0, 0, int(random(4)), int(bars), 0, 4, 2, int(random(8, bardiv)), 2, 2, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  resetcolors();
  melody(0, 1, int(random(4)), int(bars), 0, 6, 2, int(random(8, bardiv)), 2, 2, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  resetcolors();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0,tr);//chord2(int mode, float barstart, float bardur)
  }


  for (int i=0; i<bars; i+=2) {
    float ranshift=0.125*(1+int(random(7)));
    noiseblock(i+ranshift, 2-ranshift, 0);
  }

  for (float i=0; i<bars; i+=2) {
    if (random(100)<60) {
      zap(i, (int(random(8))+2));//zap(float posx, float bardur)
    }
  }
}

void microtonal(int density, int maxstroke) {
  int toggle =int(random(ncol));
  for (int i=0; i<density; i++) {
    float mod=(random(4));
    float str=1+random(maxstroke);
    int x0=int(random(width));
    int x1=int(random(width));
    int y=int(random(height));
    strokeWeight(1);
    int len=((x1-x0));

    for (float j=0; j<len; j++) {
      float ph=j/len;
      float env=j/len;
      env=1-(abs((env*2)-1));
      env=constrain(2*env, 0., 1.);
      ph=((cos(ph*TWO_PI*mod))+1)/2;
      stroke(customColour[toggle], env*(ph*255));
      line(x0+j, y-(str/2), x0+j, y+(str/2));
    }
  }
}



void xenakisvibes2() {
  for (int i=0; i<5; i++) {
    float sigm=int(random(2))*0.5;
    stroke(255);
    xenakis(0, int(random(5, 12)), 1, bars, 0.25, i+1, int(random(2))+1, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  }
}

void atmosvibes2() {
  resetcolors();
  float ran=random(0.01);
  perlin2(0.4, 1);
  hole4(0, width, 4, 0);
  resetcolors();
  for (int i=0; i<notegrid; i++) {
    if (random(100)<15) {
      base(0, bars, i);
      noteam(0, bars, i, random(ran));
    }
  }
}

void rhythmvibes() {
  for (int i=0; i<bars; i++) {
    float nums[]={2.66666, 3, 4, 5.333333, 6, 8, 12, 16, 24};
    float n=nums[int(random(nums.length))];
    sticks2(i, 1, n);//sticks2(float barstart, float bardur,float num)
  }
  for (int i=0; i<4; i++) {
    int h=int(random(8))+1;
    int steps[]={7, 8, 9, 11, 12, 16};
    int fills[]={2, 3, 4, 5};
    float divs[]={1, 2};
    int step=steps[int(random(steps.length))];
    int fill=fills[int(random(fills.length))];
    float div=divs[int(random(divs.length))];
    eurhythm(0, bars, div, 12+(i*(notegrid/4)), h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
  }


  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<50) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  thump(1, 100, 0);
  snare(1, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    noiseblock(i+ranshift, 1-ranshift, 0);
  }

  pointchords(0.25, bars, 2, 3, 2, 8);
}

void atmosvibes() {
  float ran=random(0.01);
  for (int i=0; i<notegrid; i++) {
    if (random(100)<50) {
      base(0, bars, i);
    }
    noteam(0, bars, i, random(ran));
  }

  harmonics(0, 4, 0, 32);
}

void euclideanvibes() {
  perlin(0.4, 1);
  hole(0);


  //xenakis(1,10,1,bars,2,2,2,0,0);


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
    eurhythm(0, bars, div, prevh, h, step, fill, 0); //eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift)
    prevh=prevh+h;
  }

  for (float i=0; i<2; i++) { //additive melody
    melody(2, 0, int(random(4)), int(bars), 0, 6, 0, int(random(4, bardiv)), 2, 4, 4); //melody(int paintmode, int mode, int bardur, int barstart,  int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap)
  }
  //lfo(0,bars,64,0.75,0,800,height,0,2); //lfo(int wave, float bardur, float cycles, float phase, float cut0, float amp0, float cut1, float amp1, float grad)

  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0,tr);//chord2(int mode, float barstart, float bardur)
  }

  for (float i=0; i<bars; i+=1) { //additive monadic bass
    float part=1+int(random(2, 16));
    float octave=12*int(random(2));
    additive(-12, i, 32, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  melody(0, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<30) {
      freeze(i+ranshift, 1-ranshift);//freeze(float barposx, float barlen)
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<50) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  thump(1, 100, 0);
  snare(1, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    noiseblock(i+ranshift, 1-ranshift, 0);
  }

  for (int i=0; i<1; i++) {
    float sigm=int(random(2))*0.5;
    xenakis(1, 10, 1, bars, 2, 2+i, 2, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
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
    if (random(100)<30) {
      beatRepeat2(i, 1, temp, 0.666, sign*5*pitch);
    }
  }
}


void xenakisvibes() {
  freezevibes(0.0625);
  for (int i=0; i<1; i++) {
    float sigm=int(random(2))*0.5;
    xenakis(1, 10, 1, bars, 2, 2+i, 2, 0, sigm);//xenakis(int mode, int numlines, float bardur, float barnum, float octaverange, float octavestart, int maxstep, int minstep, float sigmoid)
  }
}


void gatevibes() {
  /*float frspeed[]={0.0625, 0.125,0.25,0.5,1,2,3,4,8};
   float fr=frspeed[int(random(frspeed.length))];
   freezevibes(fr);
   */
  darkvibes();
  for (int i=0; i<bars; i+=2) {
    int tr=transposeList[int(i)];
    chord2(2, i, 2, 0,tr);//chord2(int mode, float barstart, float bardur)
  }
  melody(0, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);
  melody(0, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);
  harmonics(0, 4, 0, 32);
  harmonics(0, 4, 0, 32);
  float barsize=width/bars;
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
  /*

   
   for(int i=0;i<bars;i+=2){
   
   gater(i,2,temp*2,1,modegate,pow); //gater(float barpos, float bardur, float num, float pw, float mode, float pow)
   }
   */
}
void freezevibes2() {
  int mode=int(random(3));

  perlin(0.4, 1);
  hole(0);
  harmonics(0, 2, 0, 32);
  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<75) {
      noiseblock(i+ranshift, 1-ranshift, 0);
    }
  }

  melody(mode, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);

  for (int i=0; i<bars; i+=1) {
    float divs[]={1, 1.33333, 1.5, 2, 3, 4, 6};
    float tempo=divs[int(random(divs.length))];
    float offset=((tempo/2)/bardiv)*int(random(2));
    pointchords(i+offset, 1, (int(random(2))+1)/(int(random(2))+1), 2, 4, tempo);//pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  }

  pointchords(0.25, bars, 2, 3, 2, 8);
  snare(1, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }



  for (float i=0; i<bars; i+=1) { //additive monadic bass
    float part=int(random(2, 16));
    float octave=12*int(random(2));
    additive(-12, i, 16, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  chord(mode);

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

void freezevibes(float freezespeed) {
  int mode=int(random(3));

  perlin(0.4, 1);
  hole(0);
  harmonics(0, 2, 0, 32);
  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<75) {
      noiseblock(i+ranshift, 1-ranshift, 0);
    }
  }

  melody(mode, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);

  for (int i=0; i<bars; i+=1) {
    float divs[]={1, 1.33333, 1.5, 2, 3, 4, 6};
    float tempo=divs[int(random(divs.length))];
    float offset=((tempo/2)/bardiv)*int(random(2));
    pointchords(i+offset, 1, (int(random(2))+1)/(int(random(2))+1), 2, 4, tempo);//pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  }

  pointchords(0.25, bars, 2, 3, 2, 8);
  snare(1, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }

  for (float i=0; i<bars; i+=1) { //additive monadic bass
    float part=int(random(2, 16));
    float octave=12*int(random(2));
    additive(-12, i, 16, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  chord(mode);

  float inc=1/freezespeed;
  for (float i=0; i<bars; i+=inc) {
    freeze(i, inc);
  }
  /*
float barsize=width/bars;
   float inc=1;
   float count=0;
   for(float i=0;i<bars*2;i+=inc){
   freeze(count,inc);//freeze(barpos,barlen);
   count+=inc;
   float raninc[]={1,2,3,4,8};
   float ri=raninc[int(random(raninc.length))];
   inc=ri;
   }
   */
}

void repeatvibes() {
  dubvibes();
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

void trancevibes() {




  gatevibes();

  for (int i=0; i<bars; i++) {
    float nums[]={2.66666, 3, 4, 5.333333, 6, 8, 12};
    float n=nums[int(random(nums.length))];
    if (random(100)<50) {
      sticks2(i, 1, n);//sticks2(float barstart, float bardur,float num)
    }
  }



  float div[]={8, 10.666666, 12, 16};
  float tempo=div[int(random(div.length))];
  for (float i=0; i<bars; i+=1/tempo) { //additive melody
    float part=int(random(4, 18));
    int posscale=int(random(scales[selsc].length));
    int octave=12*(int(random(2)));
    if (random(100)<50) {
      additive(-12+octave, i, (bars/tempo), part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
    }
  }

  for (float i=0; i<bars; i+=0.5) {
    float ranshift=(0.125*(1+int(random(7))))*2;
    if (random(100)<15) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }

  for (float i=0; i<bars; i+=2) { //additive monadic bass
    float part=1+int(random(3, 8));
    float octave=12*int(random(2));
    additive(-12, i, 64, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<30) {
      noiseblock(i+ranshift, 1-ranshift, 0);
    }
  }

  thump(4, 100, 0);
  snare(2, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<50) {
      zap(i+0.25, 0.25);//zap(float posx, float bardur)
    }
  }
  for (float i=0; i<bars; i++) {
    if (random(100)<30) {
      //zap(i,(int(random(16))+1));//zap(float posx, float bardur)
    }
  }
  for (int i=0; i<width; i+=(((width/bars)/bardiv))*4) {
    int off=int(((width/bars)/bardiv)*2);
    float vel=random(1);
    float dur=5;
    int len=50;
    if (random(100)<20) {
      dur=12;
    }
    if (random(100)<100) {
      hat(i+off, len, 0.15+(vel*0.5), dur);//hat(int posx, int h, int vel, float dur){
    }
  }
  for (int i=0; i<bars; i+=2)
  {
    int trans[]={3, 5, 7};
    int tr=trans[int(random(trans.length))];
    transpose(i, 2, tr*int(random(2)));//transpose(float barposx, int barw, float semitones)
  }

  for (float i=0; i<bars; i+=1) {
    float sign=((i%2)*2)-1;
    float pitch=int(random(2));
    float divs[]={2, 4};
    float temp=divs[int(random(divs.length))];
    if (random(100)<10) {
      beatRepeat2(i, 1, temp, 0.666, 0);
    }
  }
}

void darkvibes() {
  perlin(0.4, 1);
  hole4(0, width, 2, 0);
  for (int i=0; i<4; i++) {
    chord(2);
  }
  harmonics(0, 3, 0, 32);
  harmonics(0, 2, 0, 32);
  melody(2, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);
  melody(2, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);
  for (float i=0; i<bars; i+=2) { //additive monadic bass
    float part=1+int(random(2, 16));
    float octave=12*int(random(2));
    additive(-12, i, 64, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }
  snare(0.5, 100, 2);
  thump(0.5, 100, 0);
  for (float i=0; i<bars; i++) {
    if (random(100)<30) {
      zap(i, 1*(int(random(7))+1));//zap(float posx, float bardur)
    }
  }
  for (int i=0; i<bars; i+=2) {
    float divs[]={4, 6, 8, 12, 16};
    float tempo=divs[int(random(divs.length))];
    float offset=((tempo/2)/bardiv)*int(random(2));
    pointchords(i+offset, 2, (int(random(2))+1)/(int(random(2))+1), 2, 4, tempo);//pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  }

  int num=int(random(3))+1;
  for (int i=0; i<num; i++) {
    int dur=int(random(4))+2;
    int st=int(random(bars-dur));
    marble(st, dur);//marble(int barstart, int bardur)
  }
}

void dubvibes() {

  int mode=int(random(3));

  perlin(0.4, 1);
  hole(0);
  harmonics(0, 2, 0, 32);


  melody(mode, 0, int(random(4)), int(bars), 2, 4, 1, int(random(4, bardiv)), 3, 4, 4);

  for (int i=0; i<bars; i+=1) {
    float divs[]={1, 1.33333, 1.5, 2, 3, 4, 6};
    float tempo=divs[int(random(divs.length))];
    float offset=((tempo/2)/bardiv)*int(random(2));
    //pointchords(i+offset,1,(int(random(2))+1)/(int(random(2))+1),2,4,tempo);//pointchords(float barpos, float bardur, float octaves, int octavestart, int octaverange, float divtempo)
  }



  for (float i=0; i<bars; i+=1) { //additive monadic bass
    float part=int(random(2, 16));
    float octave=12*int(random(2));
    additive(-12, i, 16, part, 0); //additive(float p, float barpos, float notedur, float partials, int partmode)
  }

  chord(mode);


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

  if (random(100)<25) {
    portaseq(0, 4, 3, 2, 24, 0.85, 1); //portaseq(float barstart, float w, int octavestart, int octaverange, int num, float t, float vib)
  }
  for (int i=0; i<bars-2; i+=2) {
    int p=-12;
    additive2(p, i, 64, 8, 0, 2, 5, 4);//additive2(float p, float barpos, float notedur, float partials, int partmode, int envmode, int detune)
  }

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    if (random(100)<25) {
      singlegate(i+ranshift, 1-ranshift);
    }
  }
  pointchords(0.25, bars, 2, 3, 2, 8);

  for (int i=0; i<bars; i++) {
    float ranshift=0.125*(1+int(random(7)));
    noiseblock(i+ranshift, 1-ranshift, 0);
  }

  thump(1, 100, 0);
  snare(1, 100, 1);
  for (float i=0; i<bars; i+=0.5) {
    if (random(100)<40) {
      zap(i, 0.5*(int(random(3))+1));//zap(float posx, float bardur)
    }
  }

  //sticks(8,1+int(random(2)));



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


  for (int i=0; i<bars; i+=2)
  {
    transpose(i, 2, 5*int(random(2)));//transpose(float barposx, int barw, float semitones)
  }

  for (int i=0; i<bars; i++) {
    int sino=int(random(8));
    if (sino==1) {
      freeze(i+0.5, 0.5);//freeze(float barposx, float barlen)
    }
  }
}

void melody(int paintmode, int mode, int envmode, int bardur, int barstart, int octaves, int octavestart, float maxdur, float maxpow, float walkstep, float overlap) {
  int strokeColor=g.strokeColor;
  float barsize=width/bars;
  float noteheight=height/float(notegrid);
  float smallestnote=(barsize/bardiv)/2;
  float notewidth=smallestnote*(1+(int(random(maxdur))));
  float rndmwalk=0;
  float pow=random(maxpow)+2;
  strokeWeight(1);
  int toggle =int(random(ncol));      //numero de colors


  for (float i=0; i<bardur*barsize; i+=notewidth) {
    float randomnote=0;
    float randomoctave=noteheight*(int(random(octaves))*12);
    int dirwalk=(int(random(2))*2)-1;
    rndmwalk=rndmwalk+(int(random(walkstep)+1)*dirwalk);
    notewidth=smallestnote*(1+(int(random(maxdur))));

    if (mode==0) {
      int posscale=int(random(scales[selsc].length));
      randomnote=noteheight*scale[posscale];
      randomnote=randomnote+randomoctave+(octavestart*12*noteheight);
    }

    if (mode==1) {
      randomnote=(scale[abs(int(rndmwalk%scales[selsc].length))]+(int(rndmwalk/12)*12));
      //print(int(randomnote));
      randomnote=randomnote*noteheight;
      randomnote=randomnote+(octavestart*12*noteheight);
    }


    float noteY=height-randomnote;
    float noteX=i+(barstart*barsize);
    float ph=0;
    for (int j=0; j<notewidth*overlap; j++) {
      int tr=transposeList[int((noteX+j)/barsize)];
      tr=int(tr*noteheight);
      if (envmode==0) {
        ph=j/(notewidth*2);
      }
      if (envmode==1) {
        ph=abs(1-(j/(notewidth*overlap)));
      }
      if (envmode==2) { //triangle
        ph=1-(abs((abs(1-(j/(notewidth*overlap)))*2)-1));
      }

      if (envmode==3) {
        ph=1;
      }
      ph=pow(ph, pow);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255);

      if (paintmode==0) {
        line(noteX+j, noteY-(noteheight/4)-tr, noteX+j, noteY-(noteheight/4)+(noteheight/2)-tr);
      }

      if (paintmode==1) {
        for (int t=0; t<int(ph*25); t++) {
          point(noteX+j, noteY+random(noteheight/2)-(noteheight/4)-tr);
        }
      }

      if (paintmode==2) {
        point(noteX+j, noteY);
      }
    }
  }
}

void vibrato(int num, float octsart, float octrange) {
  float noteheight=height/float(notegrid);
  float barsize=width/bars;

  noFill();
  selectstrokecolor();
  for (int i=0; i<num; i++)
  {
    float notestart =scale[int(random(scales[selsc].length))]+(octsart*12);
    float octave=12*(int(random(octrange))+1);
    float notepos=height-(((notestart+octave)*noteheight));

    float y=notepos;
    float w=20+random(width/3);
    float x=random(width-w);
    int tr=transposeList[int((x)/barsize)];
    tr=int(tr*noteheight);
    float h=random(noteheight/2);
    float len=random(0, 2);
    float ph=0;
    float skewVal=random(-1, 1);
    float pow=random(1, 6);
    float maxfreq=random(0.1, 1);

    pushMatrix();
    translate(x, y-tr);
    sindraw(0, 0, w, h, len, ph, skewVal, pow, maxfreq);
    popMatrix();
  }
}

void sindraw(float startx, float starty, float w, float h, float len, float ph, float skewValue, float pow, float maxfreq) {
  float strw=random(2,6);
  strokeWeight(strw);
  beginShape();
  float start=startx;
  float end=startx+w;
  for (float i = start; i <=end; i+=1) {
    float j = starty + (sin(ph) * h);
    vertex(i, j);
    float phasor=(i-start)/(end-start);
    phasor=skew(skewValue, phasor);
    float tri=1-(2*abs(phasor-0.5));
    tri=tri*maxfreq;
    tri=pow(tri, pow);
    ph += len*(tri);
  }
  endShape();
}

void drone() {
  float barsize=width/bars;
  float w=(barsize*((int(random(4)))+1))/((int(random(4)))+1);
  float posx=(((barsize/bardiv)*8)*int(random(width/((barsize/bardiv)*8))));
  float noteheight=height/float(notegrid);
  float notestart =scale[int(random(scales[selsc].length))];
  float notepos=height-((notestart*noteheight));
  selectstrokecolor();
  strokeCap(ROUND);
  strokeWeight(5);
  float range=int(random(7))+1;
  for (float i=notestart; i<notegrid/range; i+=12) {
    line(posx, height-(i*noteheight), posx+w, height-(i*noteheight));
  }
}

void bass(int mode) {
  float barsize=width/bars;
  float w=(barsize*((int(random(4)))+1))/((int(random(2)))+1);
  float posx=(((barsize/bardiv)*8)*int(random(width/((barsize/bardiv)*8))));
  float noteheight=height/float(notegrid);
  float notestart =scale[int(random(scales[selsc].length))];
  float notepos=height-((notestart*noteheight));
  float h=(height/notegrid)/2;
  strokeCap(ROUND);
  strokeWeight(5);
  int toggle =int(random(ncol));      //numero de colors
  selectstrokecolor();

  //line(posx,notepos,posx+w,notepos);
  float mod=int(random(8));
  for (float j=0; j<w; j++) {
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
      line(posx+j, notepos-(h/2), posx+j, notepos+h-(h/2));
    }

    if (mode==1) {

      ph=pow(ph, 3);
      ph=env*(0.2+(ph*0.8));
      for (int t=0; t<int(ph*20); t++) {
        point(posx+j, notepos+random(h)-(h/2));
      }
    }

    if (mode==2) {

      ph=pow(ph, 2);
      ph=env*(0.2+(ph*0.8));
      stroke(customColour[toggle], env*(ph*255));
      for (int t=0; t<int(ph*20); t++) {
        point(posx+j, notepos);
      }
    }
  }
}

void contours(float barstart, float w, int octavestart, int octaverange, int num, float t, float vib) {

  int toggle =int(random(ncol));
  stroke(customColour[toggle]);
  float barsize=width/bars;
  barstart=barstart*barsize;
  float noteheight=height/float(notegrid);
  float notewidth=(barsize/bardiv)*w;

  PVector[] coordinates;
  coordinates=new PVector[num+2];
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
    float ystart=(12*noteheight)*octavestart;
    y=height-(ystart+((note+(int(random(octaverange))*12))*noteheight));
    coordinates[i]=new PVector(x, y);
    x=x+((notewidth*(1+int(random(3)))*(1+int(random(2))))/(1+int(random(2))));
    coordinates[i+1]=new PVector(x, y);
  }
  for (int j=0; j<num; j++) {

    portamento(barstart+coordinates[j].x, coordinates[j].y, barstart+coordinates[j+1].x, coordinates[j+1].y, t, vib, 0, 0);
    //portamento(coordinates[j].x,coordinates[j].y+noteheight*3,coordinates[j+1].x,coordinates[j+1].y+noteheight*3,t);
  }
}

void eurhythm2(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift) {
  float barsize=width/bars;
  float stepsize=barsize/bardiv;
  strokeCap(PROJECT);

  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle], 200);
  float strw=stepsize/4;
  strokeWeight(strw);

  float notewidth=(barsize/bardiv)*div;
  float noteheight=height/float(notegrid);
  int num=int((bardur*barsize)/notewidth);
  float starty=height-(startnote*noteheight);
  h=h*noteheight;

  for (int i=0; i<num; i++) {
    int eu=euclidean(i, steps, fills, shift);
    if (eu==1) {
      line(i*notewidth+(strw/2), starty, i*notewidth+(strw/2), starty-h);
    }
  }
}

void eurhythm(float barstart, float bardur, float div, float startnote, float h, int steps, int fills, int shift) {
  float barsize=width/bars;
  float stepsize=barsize/bardiv;

  int toggle =int(random(ncol));      //numero de colors
  stroke(customColour[toggle], 200);
  //stroke(255);
  strokeWeight(2);
  float notewidth=(barsize/bardiv)*div;
  float noteheight=height/float(notegrid);
  int num=int((bardur*barsize)/notewidth);
  float starty=height-(startnote*noteheight);
  h=h*noteheight;

  for (int i=0; i<num; i++) {
    int eu=euclidean(i, steps, fills, shift);
    if (eu==1) {
      //line(i*notewidth, starty, i*notewidth, starty-h);
      spectralblockb(i*notewidth, starty, stepsize*2, h, random(0.005, 0.1), 1, 3, random(2, 7));
      //line(i*notewidth, starty, i*notewidth, starty-h);
      //spectralblockb(float x, float y, float w, float h, float noisesc, int envmode, float power)
    }
  }
}

void arpeggio(float barstart, float bardur, float numnotes, float stepsize, float octavestart, int modulo, int detune, int transpose) {
  int strokeColor=g.strokeColor;

  float barsize=width/bars;
  float noteheight=(height/float(notegrid));
  octavestart=(octavestart*12)*noteheight;
  bardur=bardur*barsize;
  barstart=barstart*barsize;
  float notewidth=bardur/numnotes;
  int count=0;

  for (int i=0; i<numnotes; i++) {
    int index=i%modulo;
    float pos=index*stepsize;
    int note=int((pos%(scales[selsc].length)));
    float octave=int((pos/scales[selsc].length))*12;
    float step=scale[note];
    step=height-(octavestart+transpose+((step+octave)*noteheight));
    strokeCap(ROUND);
    strokeWeight(noteheight/2);
    float posx=i*notewidth;
    //line(barstart+posx,step,barstart+posx+notewidth, step);
    for (int j=0; j<notewidth; j++) {
      float ph=j/notewidth;
      ph=1-ph;
      ph=pow(ph, 2);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), ph*255);
      strokeWeight(1);
      point(barstart+posx+j, step-(detune/2));
      point(barstart+posx+j, step);
      point(barstart+posx+j, step+(detune/2));
    }
  }
}
