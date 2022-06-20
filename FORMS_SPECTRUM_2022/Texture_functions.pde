void flowfield(int num, float noiseScale, float noiseStrength, float steps) {
  float slower=16/bars;
  Particle[] particles = new Particle[num];
  for (int i=0; i<num; i++) {
    PVector loc = new PVector(random(width*1.2), random(height), 2);
    float angle = random(TWO_PI);
    float angle2 = random(TWO_PI);
    PVector dir = new PVector(cos(angle), sin(angle2));
    float speed = 1;//random(.5, 2);
    particles[i]= new Particle(loc, dir, speed);
  }
  int startpos=int(random(40000000));
  noStroke();
  for (int j=0; j<steps; j++) {
    float ph=1-(j/steps);
    ph=(ph+0.75)%1;
    ph=(1+sin(TWO_PI*ph))/2;
    fill(255, 255*ph);
    stroke(255, 255*ph);
    for (int i=0; i<particles.length; i++) {
      particles[i].run(startpos, noiseScale/slower, noiseStrength);
    }
  }
}

class Particle {

  PVector loc, dir, vel;
  float speed;
  int d=1; // direction change
  color col;

  Particle(PVector _loc, PVector _dir, float _speed) {
    loc = _loc;
    dir = _dir;
    speed = _speed;
  }

  void run(int startpos, float noiseScale, float noiseStrength) {
    move(startpos, noiseScale, noiseStrength);
    checkEdges();
    update();
  }

  void move(int startpos, float noiseScale, float noiseStrength) {
    float angle=noise(loc.x/noiseScale, loc.y/noiseScale, startpos/noiseScale)*TWO_PI*noiseStrength;
    dir.x = cos(angle);
    dir.y = sin(angle);
    vel = dir.get();
    vel.mult(speed*d);
    loc.add(vel);
  }

  void checkEdges() {
    //float distance = dist(width/2, height/2, loc.x, loc.y);
    //if (distance>150) {
    if (loc.x<0 || loc.x>width || loc.y<0 || loc.y>height) {
      loc.x = random(width*1.2);
      loc.y = random(height);
    }
  }

  void update() {
    //ellipse(loc.x, loc.y, loc.z, loc.z);
    strokeWeight(2);
    point(loc.x, loc.y);
  }
}

void cloudvibes() {
  perlin(0.4, 1);

  for (int i=0; i<bars; i++) {
    cloudblock(i, 1+int(random(8)), random(400), int(random(16)), 4/(1+int(random(16))), 1);//cloudblock(float barpos, float barwidth, float h, float cycles, float pow, float angle)
  }
  hole(int(random(40))-20);
  if (random(100)<5) {
    int dens=int(random(100))+20;
    microtonal(dens, 15);
  }
}

void cloudblock(float barpos, float barwidth, float h, float cycles, float pow, float angle) {
  float barsize=width/bars;
  barpos=barpos*barsize;
  barwidth=barwidth*barsize;
  float ystart=random(height-h);
  stroke(255);
  strokeWeight(1);
  float phase=0.75;

  for (int i=0; i<barwidth; i++) {
    float ph=i/barwidth;
    float ph2=i/barwidth;
    ph2=(ph2+phase)%1;
    ph2=(sin(ph2*TWO_PI)+1)/2;
    ph2=pow(ph2, 0.5);

    ph=pow(ph, pow);
    ph=(ph+((1/cycles)*phase))%1;
    ph=(sin(ph*TWO_PI*cycles)+1)/2;
    stroke(255, ph2*ph*255);
    //line(i+barpos,ystart+(angle*i),i+barpos,ystart+(angle*i)+h);
    for (int j=0; j<h; j++) {
      float jitterx=random(0);
      float jittery=random(0);
      float phy=j/h;
      phy=(phy+phase)%1;
      phy=(sin(phy*TWO_PI)+1)/2;
      phy=pow(phy, 0.5);
      stroke(255, ph2*ph*phy*255);
      point(i+barpos+jitterx, ystart+j+jittery);
    }
  }
}

void cloud2() {
  float barsize=width/bars;
  float notew=(barsize/bardiv)/4;
  float noteheight=height/float(notegrid);
  for (int i=0; i<300; i++) {
    float note=scale[int(random(scales[selsc].length))];
    note=height-((note+(int(random(int(notegrid/12)))*12))*noteheight);
    strokeWeight(1+int(random(3)));
    stroke(255, random(255));
    point(notew*int(random((width/notew))), note);
  }
}

void cloud() {
  float barsize=width/bars;
  float notew=(barsize/bardiv)/4;
  float noteheight=height/float(notegrid);
  for (int i=0; i<300; i++) {
    float note=scale[int(random(scales[selsc].length))];
    note=height-((note+(int(random(int(notegrid/12)))*12))*noteheight);
    strokeWeight(1+int(random(3)));
    stroke(255, random(255));
    point(notew*int(random((width/notew))), note);
  }
}

void perlinmask(float damp, float detail) {
  float increment = 0.002+(random(100)/18000);
  float xoff = 0; // Start xoff at 0
  float posx=random(width);
  float posy=random(height);
  noiseDetail(int(random(1, 3)), detail);
  float pw=random(0.5, 2);
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      float bright = pow(prng.perlin(posx+xoff, posy+yoff), 1) * 1000;
      float bright2=constrain(bright, 0, 255)*damp;
      strokeCap(ROUND);
      strokeWeight(1);
      stroke(0, bright2);
      point(x, y);
    }
  }
}

void perlin2(float detail, float opac) {
  int fillColor=g.fillColor;
  float r=red(fillColor);
  float g=green(fillColor);
  float b=blue(fillColor);
  float increment = 0.0002+(random(100)/18000);
  //loadPixels();
  float xoff = 0; // Start xoff at 0
  float posx=random(width);
  float posy=random(height);
  noiseDetail(int(random(1, 5)), detail);
  float pw=random(3, 7);
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      // Calculate noise and scale by 255
      float bright = pow(prng.perlin(posx+xoff, posy+yoff), 3) * 300;
      float bright2=constrain(bright, 0, 255);
      // Set each pixel onscreen to a grayscale value
      //pixels[x+y*width] = color(r*bright,g*bright,b*bright);
      strokeCap(ROUND);
      strokeWeight(1);
      stroke(r, g, b, bright2*opac);
      point(x, y);
      stroke(255, 255);
    }
  }
}

void perlin(float detail, float opac) {
  int fillColor=g.fillColor;
  float r=red(fillColor);
  float g=green(fillColor);
  float b=blue(fillColor);
  float increment = 0.0002+(random(100)/18000);
  //loadPixels();
  float xoff = 0; // Start xoff at 0
  float posx=random(width);
  float posy=random(height);
  noiseDetail(int(random(1, 5)), detail);
  float pw=random(3, 7);
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      // Calculate noise and scale by 255
      float bright = pow(prng.perlin(posx+xoff, posy+yoff), pw) * 1000;
      float bright2=constrain(bright, 0, 255);
      // Set each pixel onscreen to a grayscale value
      //pixels[x+y*width] = color(r*bright,g*bright,b*bright);
      strokeCap(ROUND);
      strokeWeight(1);
      stroke(r, g, b, bright2*opac);
      point(x, y);
    }
  }
}

void perlinfilter(float detail, float opac, float pw) {
  int fillColor=g.fillColor;
  float r=red(fillColor);
  float g=green(fillColor);
  float b=blue(fillColor);
  float increment = 0.0002+(random(100)/18000);
  //loadPixels();
  float xoff = 0; // Start xoff at 0
  float posx=random(width);
  float posy=random(height);
  noiseDetail(int(random(1, 5)), detail);
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      // Calculate noise and scale by 255
      float bright = pow(prng.perlin(posx+xoff, posy+yoff), pw) * 1000;
      float bright2=constrain(bright, 0, 255);
      float bright3=constrain(bright2*opac, 0, 255);
      // Set each pixel onscreen to a grayscale value
      //pixels[x+y*width] = color(r*bright,g*bright,b*bright);
      strokeCap(PROJECT);
      strokeWeight(1);
      stroke(0, 0, 0, bright3);
      point(x, y);
      stroke(255, 255);
    }
  }
}

void hole4(float x, float w, int strokew, int removeprob) {


  //1: omplim array amb totes les notes de l'escala seleccionada
  float noteheight=height/float(notegrid);
  float step=0;
  float next=0;
  int totalscalenotes=((notegrid/12)*scales[selsc].length)+10;
  ;
  IntList scalenotes=new IntList();
  for (int i=0; i<totalscalenotes; i++) {
    int pos=int((i%(scales[selsc].length)));
    step=scale[pos];
    next=(i/scales[selsc].length)*12;
    step=height-(((step+next)*noteheight));
    scalenotes.append(int(step));
  }

  //2: comparem pixel a pixel
  for (int i=0; i<height; i++) {
    if (containsAnyOfRange(scalenotes, i-(strokew/2), i+(strokew/2))) {
      if (random(100)<removeprob) {
        stroke(0);
        strokeWeight(strokew);
        line(x, i, x+w, i);
      }
    } else {
      stroke(0);
      strokeWeight(1);
      line(x, i, x+w, i);
    }
  }
}

void hole(int angle) {
  pushMatrix();
  translate(0, height);
  rotate(radians(angle));
  stroke(0);
  int step=0;
  int next=0;
  float noteheight=height/float(notegrid);
  int totalnotes=int((notegrid/12.0)*scales[selsc].length);
  IntList scalenotes=new IntList();

  for (int i=0; i<totalnotes*3; i++) {
    int pos=((i%(scales[selsc].length)));
    step=scale[pos];
    next=(i/scales[selsc].length)*12;
    step=step+next;
    scalenotes.append(step);
  }
  //println(scalenotes);
  for (int j=0; j<notegrid*3; j++) {
    if (scalenotes.hasValue(j) == true) {
      //println("Yes, we have a " + j);
    } else {
      //println("Sorry, no " + j);
      strokeWeight(noteheight+noteheight/2);
      line(-width, height-(j*noteheight), width*2, height-(j*noteheight));
      /*
    blendMode(REPLACE);
       noStroke();
       fill(0);
       rect(-width,height-(j*noteheight)-(noteheight/2)-(noteheight/4),width*8,noteheight+noteheight/2);
       */
    }
  }
  popMatrix();
}

void noise1d(float barstart, float bardur, float noisescale) {
  int toggle =int(random(ncol));
  float barsize=width/bars;
  bardur=bardur*barsize;
  barstart=barstart*barsize;
  for (float i=0; i<height; i+=height/notegrid) {
    int pos=int((i%(scales[selsc].length)));
    float noteheight=height/float(notegrid);
    float step=i;
    for (int j=0; j<bardur; j++) {
      float noiseVal = 1.5*prng.perlin(((i*100)+j*noisescale), noisescale);
      noiseVal=pow(noiseVal, 4);
      stroke(customColour[toggle], noiseVal*255);
      line(barstart+j, step-(noteheight/2), barstart+j, step+(noteheight/2));
    }
  }
}


//////////////////////////////////////////////////////////////////////////////////////////

void t1_metal() {//bells

  strokeWeight(1);
  float barsize=width/bars;
  for (int i=0; i<bars; i++) {
    float nums[]={1, 2, 2.66666, 4, 5.33333, 8};
    float n=nums[int(random(nums.length))];
    for (int k=0; k<n; k++) {
      int toggle =int(random(ncol));
      stroke(customColour[toggle]);
      int len=int((barsize*8)/(1+(random(8))));
      int partials=8+int(random(50));
      int rng=50+int(random(height/2));
      int y=int(random(height-rng));
      float power=1+random(8);
      for (int j=0; j<partials; j++) {
        int x=int((barsize*i)+((barsize/n)*k));
        if ((x+len)<width) {
          linesin(x, int(random(rng))+y, len, power);
        }
      }
    }
  }
}

void t2_hnoise() {//1dnoise chromatic pad

  float divs=2+random(notegrid-1);
  int inc=int(height/divs);
  float slower=(16/bars);

  selectstrokecolor();
  for (int y=0; y<height; y+=inc) {
    float power=3+int(random(10));
    //inc=1+int(random(200));
    if (random(100)<15) {
      selectstrokecolor();
    }
    if (random(100)<60) {
      spectralblockx(0, y, width, inc, 0.01/slower, 0, 0, power);
    }
    //brownianblock(0, y, width, inc, 0.01, 0, random(2000), 2,int(random(2)));
  }

  float speeds[]={0.0625, 0.125, 0.25, 0.5, 1, 2, 3};
  float sp=speeds[int(random(speeds.length))];
  /*
  int wave=int(random(2));
   int filtmode=int(random(2));
   int cyclesstart=int(random(2,16));
   int cyclesend=int(random(2,16));
   lfo2(wave,filtmode,0,width,cyclesstart,cyclesend, random(height), random(height), random(height), random(height));
   */
  //lfo(0, bars, bars*sp, 0.75, random(height), random(height), random(height), random(height), 1); //lfo(int wave, float bardur, float cycles, float phase, float cut0, float amp0, float cut1, float amp1, float grad)
  vignette(2);
}

void t3_clouds() {//perlin clouds
  selectcolor();
  perlin2(0.4, 1);
  if (random(100)<50) {
    selectcolor();
    perlin2(0.4, 1);
  }
  vignette(4);
}

void t4_fractal() {//paranoia
  selectstrokecolor();
  float displace=1/(random(8));
  int w=width;
  int strokew=1+int(random(4));
  int strokeColor=g.strokeColor;
  float noiseran=1+random(10);
  float noiseScale = 0.001/noiseran;
  float ran=random(200000);
  float power=3+int(random(12));
  float step=0;
  float next=0;
  float cycles=random(15);
  int sign=int(random(2));
  for (float y=0; y<notegrid; y++) {
    int pos=int((y%(scales[selsc].length)));
    float noteheight=height/float(notegrid);
    step=scale[pos];
    next=int((y/scales[selsc].length))*12;
    step=height-(((step+next)*noteheight));
    //if(random(100)<50){ //nomes pintem algunes notes
    for (int x=0; x<w; x++) {
      float env=float(x)/w;
      float env2=float(x)/w;
      env2=abs(sign-(1+cos(TWO_PI*env2*cycles))/2);
      env=1-(abs((env*2)-1));
      env=constrain(2*env, 0., 1.);
      env=pow(env, 2);
      float noiseVal = prng.perlin(((y*displace)*env2*w*noiseScale), ran*noiseScale);
      noiseVal=pow(noiseVal*1.5, power);
      stroke(red(strokeColor), green(strokeColor), blue(strokeColor), noiseVal*255*env);
      strokeWeight(strokew);
      point(x, step);
    }
    //}
  }
}

void t5_spectralPage() { //spectral page
  selectstrokecolor();
  spectralblock(0, 0, width, height, random(0.01, 0.05), 0, random(4, 6));
  vignette(2);
}

void t6_vacquie() {//vacquie perlin 2D
  strokeWeight(1);
  stroke(255, 255);
  strokeCap(ROUND);
  float slower=(16/bars);
  perlin2(random(0.1, 0.6), 2);
  float nssc=random(0.001, 0.006)/slower;
  float mxfq=random(16, 48);
  amlfo(0, 0, width, height, nssc, mxfq);
  vignette(4);
}

void t7_nebulae() {// spectral slow drones
  float barsize=width/bars;
  float nums[]={0.0625, 0.125, 0.25, 0.5, 1};
  selectstrokecolor();
  int envmode=3;
  for (float i=0; i<bars-3; i++) {
    float n=nums[int(random(nums.length))];
    if (random(100)<100) {
      for (float j=0; j<n; j++) {
        int h=height;
        int y=0;
        float pow=1+int(random(6));
        float sc=0.05/random(10);
        float w=(barsize/n);
        if (random(100)<25) {
          selectstrokecolor();
        }
        if (random(100)<100) {
          spectralblock((i*barsize)+((barsize/n)*j), y, w, h, sc, envmode, pow);
        } else {
          spectralblockb((i*barsize)+((barsize/n)*j), y, w, h, sc, envmode, pow, 6);
        }
      }
    }
  }
  vignette(4);
  float nssc=random(0.001, 0.006);
  float mxfq=random(16, 48);
  //amlfo(nssc,mxfq);
  //h2_iridescence();
}

void t8_hnoise2() { //horizontal noise blocks 2
  float slower=(16/bars);
  int inc=1;
  for (int i=0; i<height; i+=inc) {
    inc=int(random(height/90, height/8));
    selectstrokecolor();
    if (random(100)<50) {
      spectralblockx(0, i, width, inc, (0.001*random(1, 40))/slower, 0, 2, 3);//xywh sc envmode pow
    }
  }
  vignette(4);
}

void t9_aperiodicNoiseBlocks() { //aperiodic noise blocks
  float slower=(16/bars);
  int inc=1;
  int inc2=1;
  if (random(100)<50) {
    for (int j=0; j<width; j+=inc2) {
      inc2=int((width/bars/4))*(1+(int(random(4))))*(1+(int(random(4))));
      for (int i=0; i<height; i+=inc) {
        inc=int(random(height/90, height/8));
        selectstrokecolor();
        if (random(100)<15) {
          spectralblockx(j, i, inc2, inc, (0.001*random(1, 40))/slower, 0, 3, 3);//xywh sc envmode pow
          stroke(255);
        }
      }
    }
  } else {
    int modenv=int(random(2))*3;
    int num=int(random(15, 60));
    for (int j=0; j<height; j+=inc2) {
      inc2=int(random(height/90, height/8));
      for (int i=0; i<width; i+=inc) {
        inc=int((width/bars/4))*(1+(int(random(4))))*(1+(int(random(4))));
        selectstrokecolor();
        if (random(100)<num) {
          spectralblockx(i, j, inc, inc2, 0.001*random(1, 40), modenv, 3, 3);//xywh sc envmode pow
          stroke(255);
        }
      }
    }
  }
  vignette(4);
}

void t10_r2d2() {//r2d2

  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      if (random(1000)<1) {
        strokeWeight(random(1, 4));
        stroke(255, int(random(255)));
        point(random(width), random(height));
      }
    }
  }
  if (random(100)<100) {
    hole4(0, width, 4, 0);
  }
  strokeWeight(1);
}

void t11_freeze() {//freeze texture

  resetcolors();
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

  resetcolors();
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


  resetcolors();
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

void t12_rhythmicDots() {//dots
  //dots
  fill(255);
  float inc=1;
  for (float i=0; i<bars; i+=inc) {
    inc=(int(random(3))+1)/(int(random(2))+1);
    float nums[]={4, 8, 12, 16, 24, 32};
    float n=nums[int(random(nums.length))];
    float h=100+random(200);
    float y=random(height-h-100);
    if (random(100)<85) {
      dots(i, inc, n*inc, int(random(4, 24)), y, h); //dots(float barstart, float bardur, float num, float numy, float posy, float h)
    }
  }

  inc=1;
  selectcolor();
  for (float i=0; i<bars; i+=inc) {
    inc=(1)/(int(random(2))+1);
    float nums[]={4, 8, 12, 16, 24, 32};
    float n=nums[int(random(nums.length))];
    float h=50+random(100);
    float y=random(height-h-100);
    if (random(100)<35) {
      dots(i, inc, n*inc, int(random(4, 24)), y, h);
    }
  }
}

void t13_repeat() { //repeatvibes
  t9_aperiodicNoiseBlocks();
  float inc=1;
  float count=0;
  for (float i=0; i<bars; i+=inc) {
    float sign=((i%2)*2)-1;
    float mult=int(random(2))+1;
    float divs[]={1, 2, 3, 4, 6, 8, 12, 16, 24};
    float temp=divs[int(random(divs.length))];
    float len[]={1, 2};
    float l=len[int(random(len.length))];
    beatRepeat2(count, inc, temp*l, 0.666, 0); //beatRepeat2(float barposx, float bardur, float num, float gate, float semitones)
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

void t14_microtonalDrone() { //microtonal drone
  int dens=int(random(100))+20;
  resetcolors();
  microtonal(dens, 15);
  resetcolors();
  harmonics(0, 4, 0, 32);
  harmonics(0, 4, 0, 32);
}

void t15_flowField() { //flowfield
  float sc=int(random(1000));
  flowfield(int(random(800))+20, sc, random(3), 20+int(random(1000)));
  vignette(4);
}

void t16_vacquieBlocks() {//vacquie blocks
  float slower=16/bars;
  //background(128);
  float barsize=width/bars;
  float nums[]={2, 4, 6, 8};
  float inc=4;
  stroke(255);
  for (float i=0; i<bars; i+=inc) {
    inc=nums[int(random(nums.length))];
    float nssc=random(0.001, 0.006)/slower;
    float mxfq=random(16, 48)/slower;
    int h=int(random(600))+100;
    int y=int(random(height-h-150));
    selectstrokecolor();
    //noStroke();
    //rect(i*barsize,y,barsize*4,h);
    spectralblockc(i*barsize, y, barsize*inc, h, random(0.01, 0.05)/slower, 3, 6, 2); //spectralblock(float x, float y, float w, float h, float noisesc, int envmode, float power)
    amlfo(i*barsize, y, barsize*inc, h, nssc, mxfq); //amlfo(float x, float y, float w, float h, float noisescale, float maxfreq)
  }
  vignette(4);
}

void t17_noiseTears() {
  strokeWeight(1);
  float barsize=width/bars;
  for (float i=0; i<bars; i++) {
    selectstrokecolor();
    float pw=random(1, 6);
    float h=random(height/6, height/2);
    float y=random(height/8, height-(height/8)-h);
    tear(i*barsize, y, (barsize*(int(random(bars))+1))-(i*barsize), h, pw);
  }
}

void t18_microtonalDroneHarm() { //microtonal drone
  int dens=int(random(100))+20;
  resetcolors();
  microtonalHarm(dens, 15);
  resetcolors();
  //harmonics(0, 4, 0, 32);
  //harmonics(0, 4, 0, 32);
}

void t19_FMAMSinBlocks(){
  resetcolors();
  float barsize=width/bars;
  int inc=int(random(3))+1;
  for(int i=0;i<bars;i+=inc){
    inc=int(random(3))+1;
    int x=i*int(barsize);
    int y=height-(int(random(height/2, height-(height/8))));
    int w=int(barsize)*inc;
    float maxfm=random(4,20)*inc;
    float maxam=random(0,3)*inc;
    if((random(100)<33)){
      if((x+w)<width){
        fmamsin(x,y,w,height/16,random(height/3)+(height/16),maxfm,maxam);
      }
    }    
  }
  resetcolors();
}

void t20_columnGrids(){
  float barsize=width/bars;  
  for (int i=0; i<bars; i++) {
    float shift=(barsize/8)*(int(random(2))+1);
    float nums[]={4,8,8,16,16,16};
    float n=nums[int(random(nums.length))];
    for (float j=0; j<n; j++) {
      selectstrokecolor();
      int numlines=int(random(8,64));
      float strw=random(1,3);
      strokeWeight(strw);
      float x=(i*barsize)+((barsize/n)*j)+shift;
      float h=(height/8)+random(height-(height/8));
      float y=random(height-h);
      float w=(barsize/n);

      //gradblock(x,y,w,h,pow);
      if(random(100)<25){
        for(int k=0;k<numlines;k++){
          float dist=h/numlines;
          line(x+(strw/2),y+(dist*k),x+w-(strw/2),y+(dist*k));
        }
      }
    }
  }
}
