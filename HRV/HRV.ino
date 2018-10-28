int heartRatePin = 2;
boolean currentState = LOW; //low is false
boolean lastState = LOW;

void setup() {
  // put your setup code here, to run once:
  pinMode(heartRatePin, INPUT);
  pinMode(13, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  currentState = digitalRead(heartRatePin);
  if(currentState == HIGH && lastState == LOW){
    Serial.print(since); //since the last pulse
    digitalWrite(13,1);
    delay(50);
    digitalWrite(13, 0);  
  } else if(currentState == LOW && lastState == HIGH){
    delay(300); //0.3s minimum (60/0.3 = 200 BPM assumed max heart rate)
  }
  lastState = currentState;
}
