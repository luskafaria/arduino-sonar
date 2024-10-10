#include <Servo.h>

// Define pins for the Ultrasonic Sensor and Servo Motor
const int trigPin = 12;
const int echoPin = 13;
const int servoPin = 6;

// Variables for duration and distance
unsigned long duration;
int distance;

Servo myServo; // Create a servo object to control the servo motor

void setup() {
  // Set the trigPin as OUTPUT and the echoPin as INPUT
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT);
  // Serial.begin(9600);
  myServo.attach(servoPin); // Attach the servo on servoPin to the servo object
}

void loop() {
  // Rotate the Servo Motor from 15 to 165 degrees
  for (int angle = 15; angle <= 165; angle++) {  
    myServo.write(angle);
    delay(30);
    distance = calculateDistance(); // Calculate the distance at each degree

    // Send the current angle and distance to the Serial Port
    Serial.print(angle);
    Serial.print(","); 
    Serial.print(distance);
    Serial.print("."); 
  }

  // Rotate the Servo Motor from 165 to 15 degrees
  for (int angle = 165; angle >= 15; angle--) {  
    myServo.write(angle);
    delay(30);
    distance = calculateDistance();

    // Send the current angle and distance to the Serial Port
    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

// Function to calculate the distance measured by the Ultrasonic sensor
int calculateDistance() { 
  // Clear the trigPin
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);

  // Set the trigPin HIGH for 10 microseconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH); 

  // Calculate the distance (speed of sound is 34300 cm/s)
  distance = duration * 0.034 / 2; // Speed of sound wave divided by 2 (go and back)
  return distance;
}