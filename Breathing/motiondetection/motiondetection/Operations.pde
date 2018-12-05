PVector GetCenterOfMotion(PImage a){
  if(a!=null){
    PVector centerOfMotion = new PVector(0, 0);
    int motionPixels = 0;
    
    //println(a.pixels.length);
    a.loadPixels();
    
    for (int i = 0; i < a.pixels.length; i ++ ) {
      color current = a.pixels[i];
          
      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      
      if((r1>190 && r1<220) && (g1>190 && g1<220) && (b1>190 && b1<220)){
        centerOfMotion.add((i+1)%a.width, (i+1)/a.width+1);
        motionPixels ++;
      }
    }
    return (motionPixels > 0) ? centerOfMotion.div(motionPixels) : new PVector(0, 0);
  }
  return new PVector(0, 0);
}