import processing.video.*;

// Variable for capture device
Movie movie;

//FrameRate
int fps = 25;
float dur;
float at;
float prevTime = 0;
boolean done = false;
boolean saved = false;
boolean first = true;

//Output
ArrayList<String> list = new ArrayList<String>();
String fileName = "out.txt";

// How different must a pixel be to be a "motion" pixel
float threshold = 0;

// Previous Frame
PImage prevFrame;
PVector centerOfMotionPrev = new PVector(0,0);


void setup() {
  size(1440, 1080);
  movie = new Movie(this, "1-belt.mp4");
  //movie.speed(6.0);
  movie.play();
  dur = movie.duration();
}

void movieEvent(Movie movie) {
  if(prevFrame==null){
    movie.read();
    // Create an empty image the same size as the video
    prevFrame = createImage(movie.width, movie.height, RGB);
  }
  prevFrame.copy(movie, 0, 0, movie.width, movie.height, 0, 0, movie.width, movie.height);
  prevFrame.updatePixels();
  movie.read();
}

void draw() {
  background(0);
  
  at = movie.time();
  if(at >= dur){
    done = true;
  }

  // You don't need to display it to analyze it!
  image(movie, 0, 0);
  
  centerOfMotionPrev = GetCenterOfMotion(prevFrame);
  PVector centerOfMotion = GetCenterOfMotion(movie);
  PVector direction = new PVector(centerOfMotion.x-centerOfMotionPrev.x, centerOfMotion.y-centerOfMotionPrev.y);
  float totalMotion = direction.mag();

  // averageMotion is total motion divided by the number of pixels analyzed.
  float avgMotion = (totalMotion * fps);
  //avgMotion = (avgMotion>1.5) ? avgMotion : 0;
  
  //Save to file
  if(done && !saved){
    list.add(Float.toString(movie.time())+","+Float.toString(movie.height - centerOfMotion.y));
    saveStrings(fileName, list.toArray(new String[list.size()]));
    saved = true;
  }else if(!first){
    if(movie.time() != prevTime)
      list.add(Float.toString(movie.time())+","+Float.toString(movie.height - centerOfMotion.y));
    prevTime = movie.time();
  }
  else{
    list.add("Time,Motion");
    first = false;
  }

  //Draw a circle based on average motion
  stroke(204, 102, 0);
  fill(204, 102, 0);
  //float r = 100;
  //ellipse(centerOfMotion.x, centerOfMotion.y, r, r);
  line(0, centerOfMotion.y, movie.width, centerOfMotion.y);
  
  textSize(100);
  fill(0, 102, 153);
  text(avgMotion, 10, 100);
  text("Done: "+String.valueOf(done), 20, 200);
  text(movie.time(), 10, 300);
  text(movie.duration(), 10, 400);
}