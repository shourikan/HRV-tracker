PVector GetCenterOfMotion(PImage a){
  if(a!=null){
    PVector centerOfMotion = new PVector(0, 0);
    int motionPixels = 0;
    
    //println(a.pixels.length);
    a.loadPixels();
    
    for (int i = a.pixels.length/3; i < a.pixels.length; i ++ ) {
      color current = a.pixels[i];
          
      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      
      //White
      //if((r1>190 && r1<220) && (g1>190 && g1<220) && (b1>190 && b1<220)){
      //if((r1>180 && r1<200) && (g1>180 && g1<200) && (b1>165 && b1<185)){
      //if((r1>80 && r1<120) && (g1>80 && g1<120) && (b1>80 && b1<120)){
      //if((r1>90 && r1<120) && (g1>90 && g1<120) && (b1>70 && b1<100)){
      //if((r1>70 && r1<120) && (g1>70 && g1<120) && (b1>70 && b1<120)){
      //if((r1>65 && r1<90) && (g1>65 && g1<90) && (b1>50 && b1<75)){
        /*centerOfMotion.add((i+1)%a.width, (i+1)/a.width+1);
        motionPixels ++;
      }*/
      
      //Green
      //General&Light (LED on only restricted)
      if((r1>10 && r1<80) && (g1>70 && g1<180) && (b1>10 && b1<80) && (dist(r1, 0, b1, 0)< 20) && (dist(r1, 0, g1, 0)> 50)){
      //Dark (LED off included)
      //if((r1>10 && r1<25) && (g1>40 && g1<70) && (b1>10 && b1<25) && (dist(r1, 0, b1, 0)< 20) && (dist(r1, 0, g1, 0)> 25)){
        centerOfMotion.add((i+1)%a.width, (i+1)/a.width+1);
        motionPixels ++;
      }
    }
    return (motionPixels > 0) ? centerOfMotion.div(motionPixels) : new PVector(0, 0);
  }
  return new PVector(0, 0);
}