int sensorpin = 0;

void setup()
{
  Serial.begin(9600);               // starts the serial monitor
}
 
void loop()
{
  Serial.println(analogRead(sensorpin));
}
