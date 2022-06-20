class PRNG {
  private long seed;
  private long a;
  private long c;
  private long m32;
  private int[] p;
  private PVector gradients[];
  private final float perlinBound = 1. / sqrt(2);


  // ***********************************************************************************************************************************************
  // ***********************************************************************************************************************************************
  // ***********************************************************************************************************************************************
  // ***********************************************************************************************************************************************

  /*
   * All code in this section was written by Jeremy Douglass
   * You can see the original thread here: https://discourse.processing.org/t/cross-language-random-numbers/3474
   */


  /*
   * Constructor
   * 
   * Defaults to current system time in milliseconds.
   */
  PRNG() {
    this(System.currentTimeMillis());
  }


  /** 
   * @param  seed  starting seed value 
   */
  PRNG(long seed) {
    this.a = 1664525;
    this.c = 1013904223;
    this.m32 = 0xFFFFFFFFL;
    this.randomSeed(seed);
    initPerlin();  // Added to support the perlin noise
  }


  /**
   * Updates seed based on past value, returns new value.
   * 
   * @return  unsigned 32bit value stored in a long
   */
  long nextLong() {
    this.seed = this.seed * a + c & m32;
    return this.seed;
  }


  /**
   * Returns next long wrapped to the max integer value.
   * Implemented so that calls to nextInt or nextLong stay in sync,
   * the next seed internally is always updated to the next long.
   * 
   * @return  positive 
   */
  int nextInt() {
    return (int)(this.nextLong()%Integer.MAX_VALUE);
  }


  /**
   * Set the current seed.
   * 
   * @param  newSeed  the new seed value
   */
  void randomSeed(long newSeed) {
    this.seed = newSeed%Integer.MAX_VALUE;
  }


  /**
   * @return  a random float between 0 and 1
   */
  float random() {
    return random(0, 1);
  }


  /**
   * @param   max  maximum value to return
   * @return  a random float between 0 and max
   */
  float random(float max) {
    return random(0, max);
  }  


  /**
   * @param   min  minimum value to return
   * @param   max  maximum value to return
   * @return       a random float in the specified range (min, max)
   */
  float random(float min, float max) {
    return map(this.nextInt(), 0, Integer.MAX_VALUE, min, max);
  }


  // ***********************************************************************************************************************************************
  // ***********************************************************************************************************************************************
  // ***********************************************************************************************************************************************
  // ***********************************************************************************************************************************************  






  /*
   * I built the perlin noise on top of the work above
   */


  /*
   * @return  a random int between 0 included and maxInt excluded
   */
  int nextInt(int maxInt) {
    return nextInt() % maxInt;
  }


  /*
   * Initialize the parameters of the perlin noise
   * 
   * 16 unit gradients evenly spaced are created
   * Those gradients will be place on a grid randomly
   *
   * A permutation array p is randomly created
   * This array allows to randomly place the gradients on the grid 
   */
  private void initPerlin() {
    // Create 16 gradients evenly spaced around the unit circle
    gradients = new PVector[16];
    float stepSize = TWO_PI / 16;
    for (int i = 0; i < 16; i++) {
      gradients[i] = PVector.fromAngle(i * stepSize);
    }

    // Create a pseudo-random permutation array that will be used to randomly place the gradients on the grid
    int[] partA = new int[256]; // Needs to be a multiple of to give the same chance to all the gradients;
    int[] partB = new int[256]; // Needs to be a multiple of to give the same chance to all the gradients;

    for (int i = 0; i < 256; i++) {
      partA[i] = i;
      partB[i] = i;
    }

    shuffleArray(partA);
    shuffleArray(partB);

    // p consists of 2 parts to avoid beeing out of bounds values in the perlin code
    p = new int[512];
    for (int i = 0; i < 256; i++) {
      p[i] = partA[i];
      p[i + 256] = partB[i];
      ;
    }
  }


  /*
   * @param   x  x coordinate of the perlin noise
   * @param   y  y coordinate of the perlin noise
   * @return       a random float between 0 and 1
   */
  float perlin(float x, float y) {
    // Get the top left grid corner coordinates
    int i = (int)x & 255; // = x % 256
    int j = (int)y & 255; // = y % 256

    // Get the gradients used in the 4 surrounding grid corners
    int gradTL = ((p[p[p[      i] +       j]]) & 15); // = % 16   -   Top left gradient    (in processing coordonate system)
    int gradTR = ((p[p[p[incr(i)] +       j]]) & 15); // = % 16   -   Top right gradient   (in processing coordonate system)
    int gradBL = ((p[p[p[      i] + incr(j)]]) & 15); // = % 16   -   bottom left gradient (in processing coordonate system)
    int gradBR = ((p[p[p[incr(i)] + incr(j)]]) & 15); // = % 16   -   Top left gradient    (in processing coordonate system)

    // get the delta from the top left grid corner
    float u = x - (int)x;
    float v = y - (int)y;

    // Compute the dot products between the gradients at the 4 surrounding grid corners and the 4 vectors starting at the corners and heading towards the point (x, y)
    float dotProdTL = dotProd(gradients[gradTL], u, v);
    float dotProdTR = dotProd(gradients[gradTR], u - 1, v);
    float dotProdBL = dotProd(gradients[gradBL], u, v - 1);
    float dotProdBR = dotProd(gradients[gradBR], u - 1, v - 1);

    // Interpolate the values on the x-axis
    float topAverage = lerpValues(dotProdTL, dotProdTR, u); 
    float bottomAverage = lerpValues(dotProdBL, dotProdBR, u);

    // Interpolate and the y-axis and return the result
    return map(lerpValues(topAverage, bottomAverage, v), -perlinBound, perlinBound, 0, 1);
  }


  /*
   * @param   x           x coordinate of the perlin noise
   * @param   y           y coordinate of the perlin noise
   * @param   nbOFreq     The number of frequencies to add on top of another
   * @param   freqFactor  The amount by which to change the next frequency
   * @param   ampFactor   The amount by which to change the next amplitude
   *
   * @return              a random float between 0 and 1
   */
  float mixPerlin(float x, float y, int nbOFreq, float freqFactor, float ampFactor) {
    float result = 0;
    float freq = 1;
    float amp = 1;
    final float maxValue = (1 - pow(ampFactor, nbOFreq)) / ( 1 - ampFactor);

    for (int i = 0; i < nbOFreq; i++) {
      result += perlin(x * freq, y * freq) * amp;
      amp *= ampFactor;
      freq *= freqFactor;
    }

    return result/maxValue;
  }


  /*
   * @param   x    x coordinate of the perlin grid point
   * @param   y    y coordinate of the perlin grid point
   *
   * @return       The gradient used at that perlin grid point
   */
  PVector getGrad(int x, int y) {
    int i = x & 255; // = x % 256
    int j = y & 255; // = y % 256

    int gradTL = ((p[p[p[i]+j]]) & 15);
    return gradients[gradTL];
  }


  /*
   * @param   a    The start point
   * @param   b    The end point
   * @param   t    The value to which interpolate 
   *
   * @return       The interpolation at t between a and b. The function used is not linear in order to get continuous second derivative 
   */
  private float lerpValues(float a, float b, float t) {
    return a + fade(t) * (b - a);
  }


  /*
   * @param   t    The value at which evaluate the function
   *
   * @return       The value of the function 6 t^5 - 10 t^4 + 15 t^3 
   */
  private float fade(float t) {
    return t * t * t * ( t * ( t * 6 - 15 ) + 10 );
  }


  /*
   * @param   v    The first vector
   * @param   x    The x componant of the second vector
   * @param   y    The y componant of the second vector
   *
   * @return       the dot product of the 2 vectors
   */
  private float dotProd(PVector v, float x, float y) {
    return v.x * x + v.y * y;
  }


  /*
   * Increase a value by 1 and make sure it does not go above 255
   * if so return 0 instead
   */
  private int incr(int a) {
    return a > 254 ? 0 : a + 1;
  }


  /*
   * Function written by PhiLho here: https://stackoverflow.com/questions/1519736/random-shuffling-of-an-array
   * Shuffle the passed array randomly
   */
  private void shuffleArray(int[] ar)
  {
    for (int i = ar.length - 1; i > 0; i--)
    {
      int index = nextInt(i + 1);
      // Simple swap
      int a = ar[index];
      ar[index] = ar[i];
      ar[i] = a;
    }
  }
}
