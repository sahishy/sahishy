String[][] strs = {
  {
    "Hey there!",
    "My name is Sahish Durgam."
  },
  {
    "I want to pursue computer science.",
    "I'm currently a student at the Academies of Loudoun."
  },
  {
    "I've been teaching myself how to code for a while!",
    "I am fluent in JavaScript, C++, Java, Python, and HTML & CSS."
  },
  {
    "I've created apps, websites, and games using what I've learned.",
    "Check out my pinned projects!"
  }
};
PFont font;

int slide = 0;
int index = 0;

boolean deleting = false;
boolean finished = false;
boolean exporting = false;

int timer = 0;

int mainSize = 60;
int secondSize = 38;

int holdTime = 60; // 2 seconds at 30 FPS


void setup() {

  size(1920, 1080);
  frameRate(30);

  font = createFont("Helvetica Neue", 48);
  textFont(font);

  textAlign(CENTER, CENTER);

  fill(0);
}


void draw() {

  background(255);


  if (!finished) {

    drawText();

    animate();

  } else {

    textSize(mainSize);
    fill(0);
    text(
      "Thanks for watching.",
      width/2,
      height/2 - 40
    );

    textSize(secondSize);
    fill(80);
    text(
      "linkedin.com/in/sahishdurgam",
      width/2,
      height/2 + 40
    );

  }


  if (exporting) {

    saveFrame("frames/frame-#####.png");

  }

}



void drawText() {

  String line1 = strs[slide][0];
  String line2 = strs[slide][1];


  int a = min(index, line1.length());
  int b = min(index, line2.length());


  fill(0);

  textSize(mainSize);

  text(
    line1.substring(0,a),
    width/2,
    height/2 - 50
  );


  textSize(secondSize);

  fill(60);

  text(
    line2.substring(0,b),
    width/2,
    height/2 + 50
  );


  // blinking cursor

  if (frameCount % 30 < 15) {

    float cursorX;

    if(index <= line1.length()) {

      textSize(mainSize);
      cursorX = width/2 +
        textWidth(line1.substring(0,a))/2 + 8;

    } else {

      textSize(secondSize);
      cursorX = width/2 +
        textWidth(line2.substring(0,b))/2 + 8;

    }


    stroke(0);
    strokeWeight(3);

    line(
      cursorX,
      height/2 - 75,
      cursorX,
      height/2 + 75
    );

    noStroke();

  }

}



void animate() {


  String line1 = strs[slide][0];
  String line2 = strs[slide][1];


  int longest = max(
    line1.length(),
    line2.length()
  );


  timer++;


  if(!deleting) {


    if(index < longest) {

      if(timer % 2 == 0) {

        index++;

      }


    } else {


      if(timer > holdTime) {

        deleting = true;
        timer = 0;

      }

    }



  } else {


    if(index > 0) {


      if(timer % 2 == 0) {

        index--;

      }


    } else {


      slide++;

      deleting = false;

      timer = 0;


      if(slide >= strs.length) {

        finished = true;

      }


    }


  }


}



void keyPressed() {


  if(key == 'r' || key == 'R') {

    restart();

    exporting = true;

    println("Export started");

  }


  if(key == ' ') {

    restart();

  }


  if(key == 'q' || key == 'Q') {

    exit();

  }


}



void restart() {

  slide = 0;
  index = 0;
  timer = 0;

  deleting = false;
  finished = false;

}