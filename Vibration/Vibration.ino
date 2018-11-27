
int pin = 3;
void setup() {
  pinMode(pin, OUTPUT);
}

void loop() {
  //Inhale
  analogWrite(pin, 150);
  delay(3000);
  //Pause
  analogWrite(pin, 85);
  delay(3000);
  //Exhale
  for(int i = 0; i<6; i++){
    analogWrite(pin, 0);
    delay(250);
    analogWrite(pin, 150);
    delay(250);
  }
  //Pause
  analogWrite(pin, 85);
  delay(3000);
}
