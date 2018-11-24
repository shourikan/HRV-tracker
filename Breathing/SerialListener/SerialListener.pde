import processing.serial.*;

Serial myPort;
String val;

void setup()
{
  Init();
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil(10);
}

void draw()
{
}
void serialEvent (Serial myPort)
{
  
  if ( myPort.available() > 0) 
  {
    val = myPort.readString();
    if(val!=null){
      val = val.substring(0, val.length()-2);
      if(!val.equals("done")){
        Add(val);
        println("adding "+val+"|");
      }else{
        Save();
        println("Done");
      }
    }
  } 
}
