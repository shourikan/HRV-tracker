// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-14: Overall motion

import processing.video.*;

// Variable for capture device
Movie movie;
// Previous Frame
PImage prevFrame;

// How different must a pixel be to be a "motion" pixel
float threshold = 60;


void setup() {
  size(1440, 1080);
  movie = new Movie(this, "test1.mov"); 
  movie.loop();
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
  float avgMotion = totalMotion / movie.pixels.length; 

  // Draw a circle based on average motion
  stroke(204, 102, 0);
  fill(204, 102, 0);
  float r = avgMotion * 100;
  ellipse(width/2, height/2, r, r);
}