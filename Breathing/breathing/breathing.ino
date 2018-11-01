//collects data from an analog sensor

int sensorpin = 0;                 // analog pin used to connect the sharp sensor
int val = 0;                 // variable to store the values from sensor(initially zero)
int maxSize = 100;
int stackSize = 0;
int stack = 0;

void setup()
{
  Serial.begin(9600);               // starts the serial monitor
}
 
void loop()
{
  val = analogRead(sensorpin);       // reads the value of the sharp sensor
  if(val > 0){
    if(stackSize < maxSize){
      stack += val;
      stackSize ++;
    }else{
      Serial.println(stack/maxSize);
      stack = 0;
      stackSize = 0;
      stack += val;
    }
  }
}
