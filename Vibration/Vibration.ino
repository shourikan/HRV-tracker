
int pin = 3;
void setup() {
  pinMode(pin, OUTPUT);
  Serial.begin(9600);  
}

void loop() {
  Serial.print("1 ");
  //Inhale
  analogWrite(pin, 150);
  delay(3000);
  //Pause
  Serial.print("2 ");
  analogWrite(pin, 0);
  delay(3000);
  //Exhale
  Serial.print("3 ");
  analogWrite(pin, 80);
  delay(3000);
  /*for(int i = 0; i<6; i++){
    analogWrite(pin, 0);
    delay(250);
    analogWrite(pin, 150);
    delay(250);
  }*/
  //Pause
  Serial.println("4");
  analogWrite(pin, 0);
  delay(3000);
}
