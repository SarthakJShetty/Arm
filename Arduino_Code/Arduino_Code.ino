/*This is the Arduino code for the prototype gesture controlled robotic arm
  This nascent form of this code was obtained from an Instructable.
  The Processing counterpart still upholds most of its nascency, unless specifically commented otherwise.*/

/*Build Log:-
  1. Yet to add angle limitters to each of the DOFs
  2. */

#include <Servo.h>

/*The right shoulder and right elbow are analogous to their robotic arm counterparts */
Servo rightshoulder;
Servo rightelbow;

/*Base here refers to the rotating base atop which the arm is mounted*/
Servo base;

/*Measures the number of signals recieved from the Kinect . In this case each batch should contain three packets*/
/*Corresponds to shoulder, elbow, base respectively*/
int stepcounter = 0;
int AngleWrite[] = {0, 0, 0};

void setup() {
  /*Attaching the servo to the GPIO pins*/
  rightshoulder.attach(9);
  rightelbow.attach(10);
  base.attach(11);
  /*Serial command begins communication between processing and Arduino*/
  Serial.begin(9600);
}

void loop()
{
  if (Serial.available())
  {

    /*Counter assigns corresponding readings to the corresponding motors*/
    AngleWrite[stepcounter] = Serial.read();
    stepcounter++;
    /*If more than three values are read, change count to 0 and move on to the next batch of readings*/
    if (stepcounter > 2)
    {
      stepcounter = 0;
    }

    /*Write the corresponding values from Processing, to the servo motors*/
    rightshoulder.write(AngleWrite[0]);
    rightelbow.write(AngleWrite[1]);
    base.write(AngleWrite[2]);
    delay(15);
    /*delay(500);
      rightshoulder.write(90);
      rightelbow.write(90);*/
  }
}
