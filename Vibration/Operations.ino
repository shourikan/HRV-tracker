void Vibrate(){
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
  //Pause
  Serial.println("4");
  analogWrite(pin, 0);
  delay(3000);  
}
