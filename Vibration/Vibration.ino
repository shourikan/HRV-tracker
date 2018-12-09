const int ledPin = 7;
const int buttonPin = 2;
int pin = 3;
int buttonState = 0;
boolean on = false;
boolean switched = false;

void setup() {
  pinMode(pin, OUTPUT);
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);  
}

void loop() {
  delay(10);
  buttonState = digitalRead(buttonPin);

  //Button
  if (buttonState == HIGH && !switched) {
    on = !on;
    switched = true;
  } else if(buttonState == LOW){
    switched = false;
  }

  //LED
  if(on){
    digitalWrite(ledPin, HIGH);
    Vibrate();
  }
  else
    digitalWrite(ledPin, LOW);
}
