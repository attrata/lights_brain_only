import de.voidplus.redis.*;

Redis redis;

float BPM = 30;
int[][] pattern = {
  {1, 0, 0, 1, 0, 0, 0, 1},
  {0, 1, 1, 0, 0, 0, 0, 0},
  {0, 1, 0, 0, 0, 0, 1, 0},
  {1, 0, 0, 0, 0, 0, 0, 0},
  {1, 0, 1, 0, 1, 0, 0, 0},
  {0, 1, 1, 0, 0, 1, 0, 0},
  {1, 0, 1, 0, 0, 0, 0, 0},
  {1, 1, 0, 0, 0, 0, 0, 0}
};

OPC opc;

// Timing info
float rowsPerSecond = 2 * BPM / 60.0;
float rowDuration = 1.0 / rowsPerSecond;
float patternDuration = pattern.length / rowsPerSecond;

// LED array coordinates
int ledX = 400;
int ledY = 400;
int ledSpacing = 15;
int ledWidth = ledSpacing * 23;
int ledHeight = ledSpacing * 7;

// Images
PImage imgGreenDot;
PImage imgOrangeDot;
PImage imgPinkDot;
PImage imgPurpleDot;
PImage imgCheckers;
PImage imgGlass;
PImage[] dots;

// Timekeeping
long startTime, pauseTime;

void setup()
{
  size(300, 300);

  imgGreenDot = loadImage("greenDot.png");
  imgOrangeDot = loadImage("orangeDot.png");
  imgPinkDot = loadImage("pinkDot.png");
  imgPurpleDot = loadImage("purpleDot.png");
  imgCheckers = loadImage("checkers.png");
  imgGlass = loadImage("glass.jpeg");

  // Keep our multicolored dots in an array for easy access later
  dots = new PImage[] { imgOrangeDot, imgPurpleDot, imgPinkDot, imgGreenDot };

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Three 8x8 grids side by side
  //opc.ledGrid8x8(0, ledX, ledY, ledSpacing, 0, true);
  //opc.ledGrid8x8(64, ledX - ledSpacing * 8, ledY, ledSpacing, 0, true);
  //opc.ledGrid8x8(128, ledX + ledSpacing * 8, ledY, ledSpacing, 0, true);

  //  void ledRing(int index, int count, float x, float y, float radiusmalls, float angle)


  //int smallTriangle(float angle, int ledCount)

  // NXLZOIUUKOJFVTEV, Alice
  opc.ledCount = 0;
  opc.smallTriangle((3*PI)/3);
  opc.bigTriangle((4*PI)/3);
  opc.ledCount = 64; //next channel

  opc.bigTrapezoidL((3*PI)/3);
  opc.smallTrapezoidR((3*PI)/3);
  opc.ledCount = 64 * 2; //next channel

  opc.smallTrapezoidL((4*PI)/3);
  opc.bigTrapezoidR((4*PI)/3);
  opc.ledCount = 64 * 3; //next channel

  opc.bigOuter4L((3*PI)/3);
  opc.ledCount = 64 * 4; //next channel

  opc.bigOuter2R((3*PI)/3);
  opc.ledCount = 64 * 5; //next channel

  opc.bigOuter2L((4*PI)/3);
  opc.ledCount = 64 * 6; //next channel

  opc.bigOuter4R((4*PI)/3);


  //fadecandy AGQMRVHZJNWDEVKN, Brandy
  opc.ledCount = 512;
  opc.smallTriangle((1*PI)/3);
  opc.bigTriangle((2*PI)/3);
  opc.ledCount = 512 + 64; //next channel

  opc.bigTrapezoidL((1*PI)/3);
  opc.smallTrapezoidR((1*PI)/3);
  opc.ledCount = 512 + (64 * 2); //next channel

  opc.smallTrapezoidL((2*PI)/3);
  opc.bigTrapezoidR((2*PI)/3);
  opc.ledCount = 512 + (64 * 3); //next channel

  opc.bigOuter2L((1*PI)/3);
  opc.ledCount = 512 + (64 * 4); //next channel

  opc.bigOuter4R((1*PI)/3);
  opc.ledCount = 512 + (64 * 5); //next channel

  opc.bigOuter4L((2*PI)/3);
  opc.ledCount = 512 + (64 * 6); //next channel

  opc.bigOuter2R((2*PI)/3);

  //fadecandy GSIOJZCIYGHZZHGT, Charlotte
  opc.ledCount = 1024;
  opc.smallTriangle((5*PI)/3);
  opc.bigTriangle((6*PI)/3);
  opc.ledCount = 1024 + 64; //next channel

  opc.bigTrapezoidL((5*PI)/3);
  opc.smallTrapezoidR((5*PI)/3);
  opc.ledCount = 1024 + (64 * 2); //next channel

  opc.smallTrapezoidL((6*PI)/3);
  opc.bigTrapezoidR((6*PI)/3);
  opc.ledCount = 1024 + (64 * 3); //next channel

  opc.bigOuter4L((5*PI)/3);
  opc.ledCount = 1024 + (64 * 4); //next channel

  opc.bigOuter4R((5*PI)/3);
  opc.ledCount = 1024 + (64 * 5); //next channel

  opc.bigOuter2L((6*PI)/3);
  opc.ledCount = 1024 + (64 * 6); //next channel

  opc.bigOuter2R((6*PI)/3);
  
  //fadecandy ZDLLWETFPHAVCZQL, Denise
  opc.ledCount = 1536;
  opc.benchLInner((1*PI)/3);
  opc.benchRInner((1*PI)/3);
  opc.benchLOuter((1*PI)/3);
  opc.benchROuter((1*PI)/3);
  opc.cocoon(0);
  opc.cocoon((1*PI)/3);

  //incorrect fadecandy AKUSIKUKNRSRMBOD, 
  opc.ledCount = 2048;
  opc.benchLInner((3*PI)/3);
  opc.benchRInner((3*PI)/3);
  opc.benchLOuter((3*PI)/3);
  opc.benchROuter((3*PI)/3);
  opc.cocoon((2*PI)/3);
  opc.cocoon((3*PI)/3);
  
  //incorrect fadecandy ZXBVWCHBVLAJMXKF
  opc.ledCount = 2560;
  opc.benchLInner((5*PI)/3);
  opc.benchRInner((5*PI)/3);
  opc.benchLOuter((5*PI)/3);
  opc.benchROuter((5*PI)/3);
  opc.cocoon((4*PI)/3);
  opc.cocoon((5*PI)/3);
  
  redis = new Redis(this, "127.0.0.1", 6379);

  String pattern_string = "";
  for (int x=0; x < 8; x++){
    for (int y=0; y < 8; y++){
      pattern_string += pattern[x][y] + ",";
    }
  }
  
  redis = new Redis(this, "127.0.0.1", 6379);
  redis.setnx("pattern",pattern_string);
    
  readPattern();
  
  // Init timekeeping, start the pattern from the beginning
  startPattern();
}

void draw()
{
  readPattern();
  background(0);

  long m = millis();
  if (pauseTime != 0) {
    // Advance startTime forward while paused, so we don't make any progress
    long delta = m - pauseTime;
    startTime += delta;
    pauseTime += delta;
  }

  float now = (m - startTime) * 1e-3;
  drawEffects(now);
}

void clearPattern()
{
  for (int row = 0; row < pattern.length; row++) {
    for (int col = 0; col < pattern[0].length; col++) {
      pattern[row][col] = 0;
    }
  }
}

void startPattern()
{
  startTime = millis();
  pauseTime = 0;
}

void pausePattern()
{
  if (pauseTime == 0) {
    // Pause by stopping the clock and remembering when to unpause at
    pauseTime = millis();
  } else {
    pauseTime = 0;
  }
}   

void drawEffects(float now)
{
  // To keep this simple and flexible, we'll calculate every possible effect that
  // could be in progress: every grid square, and the previous/next loop of the pattern.
  // Each effect is rendered according to the time difference between the present and
  // when that grid square would fire.

  // When did the current loop of the pattern begin?
  float patternStartTime = now - (now % patternDuration);

  for (int whichPattern = -1; whichPattern <= 1; whichPattern++) {
    for (int row = 0; row < pattern.length; row++) {
      for (int col = 0; col < pattern[0].length; col++) {
        if (pattern[row][col] != 0) {
          float patternTime = patternStartTime + patternDuration * whichPattern;
          float firingTime = patternTime + rowDuration * row;
          drawSingleEffect(col, firingTime, now);
        }
      }
    }
  }
}

void drawSingleEffect(int column, float firingTime, float now)
{
  /*
   * Map sequencer columns to effects. Edit this to add your own effects!
   *
   * Parameters:
   *   column -- Number of the column in the sequencer that we're drawing an effect for.
   *   firingTime -- Time at which the effect in question should fire. May be in the
   *                 past or the future. This number also uniquely identifies a particular
   *                 instance of an effect.
   *   now -- The current time, in seconds.
   */

  float timeDelta = now - firingTime;
 
  switch (column) {

    // First four tracks: Colored dots rising from below
    case 0:
    case 1:
    case 2:
    case 3:
//      drawDotEffect(column, timeDelta, dots[column]);
//    drawDotRadial(column, timeDelta, dots[column], 0);  
//    drawDotRadial(column, timeDelta, dots[column], column * PI/3 + (timeDelta / 5));  
    drawDotRadial(column, timeDelta, dots[column], column * PI/3);  
      break;
   
    // Stripes moving from left to right. Each stripe particle is unique based on firingTime.
    case 4: drawStripeEffect(firingTime, timeDelta); break;

    // Image spinner overlays
    case 5: drawSpinnerEffect(timeDelta, imgCheckers); break;
    case 6: drawSpinnerEffect(timeDelta, imgGlass); break;

    // Full-frame flash effect
    case 7: drawFlashEffect(timeDelta); break;
  }
}


void drawDotRadial(int column, float time, PImage im, float angle)
{
  // Draw an image dot that hits the bottom of the array at the beat,
  // then quickly shrinks and fades.

  float motionSpeed = rowsPerSecond * 90.0;
  float fadeSpeed = motionSpeed * 1.0;
  float shrinkSpeed = motionSpeed * 1.2;
  float size = 70 - max(0, time * shrinkSpeed);
  float centerX = 0; 
  float topY = (time * motionSpeed) - (size/2) + 400;
  int brightness = int(255 - max(0, fadeSpeed * time));

  // Adjust the 'top' position so the dot seems to appear on-time
  //topY -= size * 0.4;

//  int rotateX(int X, int Y, float angle)
  float X = opc.rotateX(int(centerX),int(topY),angle);
  float Y = opc.rotateY(int(centerX),int(topY),angle);

  X += opc.scale / 2 - (size/2);
  Y += opc.scale / 2 - (size/2);
 
  if (brightness > 0) {
    blendMode(ADD);
    tint(2 * brightness/3);
    image(im, X, Y, size, size);
  }
}

void drawDotEffect(int column, float time, PImage im)
{
  // Draw an image dot that hits the bottom of the array at the beat,
  // then quickly shrinks and fades.

  float motionSpeed = rowsPerSecond * 90.0;
  float fadeSpeed = motionSpeed * 1.0;
  float shrinkSpeed = motionSpeed * 1.2;
  float size = 200 - max(0, time * shrinkSpeed);
  float centerX = ledX + (column - 1.5) * 75.0;
  float topY = (ledY - time * motionSpeed);
  int brightness = int(255 - max(0, fadeSpeed * time));

  // Adjust the 'top' position so the dot seems to appear on-time
  topY -= size * 0.4;
 
  if (brightness > 0) {
    blendMode(ADD);
    tint(brightness);
    image(im, centerX - size/2, topY, size, size);
  }
}

void drawSpinnerEffect(float time, PImage im)
{
  float t = time / (rowDuration * 1.5);
  if (t < -1 || t > 1) return;

  float angle = time * 5.0;
  float size = opc.scale;
  int alpha = int(128 * (1.0 + cos(t * PI)));

  int x = int(opc.scale / 2);
  int y = int(opc.scale / 2);

  if (alpha > 0) {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    blendMode(ADD);
    tint(alpha);
    image(im, -size/2, -size/2, size, size);
    popMatrix();
  }
}

void drawFlashEffect(float time)
{
  float t = time / (rowDuration * 2.0);
  if (t < 0 || t > 1) return;

  // Not super-bright, and with a pleasing falloff
  blendMode(ADD);
  fill(64 * pow(1.0 - t, 1.5));
  rect(0, 0, width, height);
}

void drawStripeRotate(float identity, float time)
{
  // Pick a pseudorandom dot and Y position
  randomSeed(int(identity * 1e3));
  PImage im = dots[int(random(dots.length))];
  float y = ledY - ledHeight/2 + random(ledHeight);

  // Animation
  float motionSpeed = rowsPerSecond * 400.0;
  float x = ledX - ledWidth/2 + time * motionSpeed;
  float sizeX = 300;
  float sizeY = 30;
  
  blendMode(ADD);
  tint(255);
  image(im, x - sizeX/2, y - sizeY/2, sizeX, sizeY);   
}

void drawStripeEffect(float identity, float time)
{
  // Pick a pseudorandom dot and Y position
  randomSeed(int(identity * 1e3));
  PImage im = dots[int(random(dots.length))];
  float y = ledY - ledHeight/2 + random(ledHeight);

  // Animation
  float motionSpeed = rowsPerSecond * 400.0;
  float x = ledX - ledWidth/2 + time * motionSpeed;
  float sizeX = 300;
  float sizeY = 30;
  
  blendMode(ADD);
  tint(255);
  image(im, x - sizeX/2, y - sizeY/2, sizeX, sizeY);   
}

void readPattern(){
  String pattern_string = redis.get("pattern");
  int[] nums = int(split(pattern_string, ','));

  for (int x=0; x < 8; x++){
    for (int y=0; y < 8; y++){
      if (x+(y*8) > nums.length - 1){
        pattern[x][y] = 0;
      }else {
        pattern[x][y] = nums[x+(y*8)];
      }
    }
  }
}