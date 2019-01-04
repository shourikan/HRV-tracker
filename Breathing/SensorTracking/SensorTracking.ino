const int buttonPin = 2;
const int fsrPin = 0;
const int irPin = 1;
const int ledPin = 7;

int buttonState = 0;
int maxSize = 8;
int stackSize = 0;
float stackFsr = 0;
float stackIr = 0;
float prevFsr = 0;
float threshold = 0;

boolean on = false;
boolean done = false;
boolean switched = false;
boolean saved = false;
boolean first =        true;

void setup() {
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  delay(5);

  //Sensors
  buttonState = digitalRead(buttonPin);
  float fsr = analogRead(fsrPin);
  float ir = analogRead(irPin);

  //Button
  if (buttonState == HIGH && !switched) {
    if(on)
      done = true;
    else
      done = false;
    on = !on;
    switched = true;
  } else if(buttonState == LOW){
    switched = false;
  }

  //LED
  if(on)
    digitalWrite(ledPin, HIGH);
  else
    digitalWrite(ledPin, LOW);

  //Test sensor
  //Serial.println(fsr);
  
  //Send to Saving Script
  if(done && !saved){
    Serial.println("done");
    saved = true;
  }else if(!first && on){
    //Stacking
    if(stackSize < maxSize){
      stackSize ++;
    }else{
      Serial.print(fsr);
      Serial.print(",");
      Serial.println(ir);
      stackSize = 0;
    }
    
  }
  else if(on){
    Serial.println("FSR,IR");
    first = false;
  }
  
}
