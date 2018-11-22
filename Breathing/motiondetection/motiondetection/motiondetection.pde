import processing.video.*;

// Variable for capture device
Movie movie;

//FrameRate
int fps = 25;
float dur;
float at;
boolean done = false;
boolean saved = false;
boolean first = true;

//Output
ArrayList<String> list = new ArrayList<String>();
String fileName = "out.txt";

// Previous Frame
PImage prevFrame;

// How different must a pixel be to be a "motion" pixel
float threshold = 40;


void setup() {
  size(1440, 1080);
  movie = new Movie(this, "test1.mov");
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

  movie.loadPixels();
  prevFrame.loadPixels();

  // Begin loop to walk through every pixel
  // Start with a total of 0
  float totalMotion = 0;

  // Sum the brightness of each pixel
  for (int i = 0; i < movie.pixels.length; i ++ ) {
    // Step 2, what is the current color
    color current = movie.pixels[i];

    // Step 3, what is the previous color
    color previous = prevFrame.pixels[i];

    // Step 4, compare colors (previous vs. current)
    float r1 = red(current); 
    float g1 = green(current);
    float b1 = blue(current);
    float r2 = red(previous); 
    float g2 = green(previous);
    float b2 = blue(previous);

    // Motion for an individual pixel is the difference between the previous color and current color.
    float diff = dist(r1, g1, b1, r2, g2, b2);
    
    if (diff > threshold) { 
        // totalMotion is the sum of all color differences. 
        totalMotion += diff;
      }
    
  }

  // averageMotion is total motion divided by the number of pixels analyzed.
  float avgMotion = totalMotion / movie.pixels.length * fps;
  
  //Save to file
  if(done && !saved){
    list.add(Float.toString(movie.time())+","+Float.toString(avgMotion));
    saveStrings(fileName, list.toArray(new String[list.size()]));
    saved = true;
  }else if(!first)
    list.add(Float.toString(movie.time())+","+Float.toString(avgMotion));
  else{
    list.add("Time,Motion");
    first = false;
  }

  // Draw a circle based on average motion
  stroke(204, 102, 0);
  fill(204, 102, 0);
  float r = avgMotion * 5;
  ellipse(width/2, height/2, r, r);
  
  textSize(100);
  fill(0, 102, 153);
  text(avgMotion, 10, 100);
  text("Done: "+String.valueOf(done), 20, 200);
  text(movie.time(), 10, 300);
  text(movie.duration(), 10, 400);
}