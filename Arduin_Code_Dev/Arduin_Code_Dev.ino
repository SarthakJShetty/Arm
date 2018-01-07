/*This is the Arduino code for the prototype gesture controlled robotic arm
  This nascent form of this code was obtained from an Instructable.
  The Processing counterpart still upholds most of its nascency, unless specifically commented otherwise.*/

/*Build Log:-
  1. Yet to add angle limitters to each of the DOFs
  2. */

#include <Servo.h>

/*The right shoulder and right elbow are analogous to their robotic arm counterparts */
Servo shoulder;
Servo elbow;

/*Base here refers to the rotating base atop which the arm is mounted*/
Servo base;

/*Measures the number of signals recieved from the Kinect . In this case each batch should contain three packets*/
/*Corresponds to shoulder, elbow, base respectively*/
int stepcounter = 0;
int AngleWrite_Prev[] = {0, 0, 0};
int AngleWrite_Cur[] = {0, 0, 0};

void setup() {
  /*Attaching the servo to the GPIO pins*/
  shoulder.attach(9);
  elbow.attach(10);
  base.attach(11);
  int AngleRead;
  /*Serial command begins communication between processing and Arduino*/
  Serial.begin(9600);
}
void loop(){
 if(Serial.available()){
  //Serial.println("Serial Read Value: "+Serial.read());
  AngleWrite_Cur[stepcounter]=Serial.read();
  stepcounter++;
 if(stepcounter>2){
  stepcounter=0;
 }

 //Checking if the angles entered are +/- 10 degrees of previously recorded angle.
 //If the angle is within +/- of 10 degrees of the previous angle, then previous angle is maintained.
 //If the angle is not within +/- 10 degrees of the previous angle, then the current angle is used and AngleRead_Prev is updated to the new angle.

//For ShoulderJoint
 if((AngleWrite_Prev[0]>=AngleWrite_Cur[0])&&(0<=(AngleWrite_Prev[0]-AngleWrite_Cur[0])<=5)){
     Serial.println("Entered shouler, option 1");
     Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);

shoulder.write(AngleWrite_Prev[0]);
 }
else if((AngleWrite_Prev[0]<AngleWrite_Cur[0])&&(0<=(AngleWrite_Cur[0]-AngleWrite_Prev[0])<=5)){
    Serial.println("Entered shoulder, option 2");
    Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
 
 shoulder.write(AngleWrite_Prev[0]);
 }
 else if(((AngleWrite_Prev[0]<=AngleWrite_Cur[0])||(AngleWrite_Prev[0]>=AngleWrite_Cur[0]))&&(((AngleWrite_Cur[0]-AngleWrite_Prev[0])>=5)||(AngleWrite_Prev[0]-AngleWrite_Cur[0])>=5)){
   Serial.println("Entered shoulder, option 3");
   Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
shoulder.write(AngleWrite_Cur[0]);

  AngleWrite_Prev[0]=AngleWrite_Cur[0];
  }

//For Elbow Joint
  if((AngleWrite_Prev[1]>=AngleWrite_Cur[1])&&(0<=(AngleWrite_Prev[1]-AngleWrite_Cur[1])<=5)){
     Serial.println("Entered elbow, option 1");
     Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
    
elbow.write(AngleWrite_Prev[1]);
 }
else if((AngleWrite_Prev[1]<AngleWrite_Cur[1])&&(0<=(AngleWrite_Cur[1]-AngleWrite_Prev[1])<=5)){
   Serial.println("Entered elbow, option 2");
   Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
  
elbow.write(AngleWrite_Prev[1]);
 }
 else if(((AngleWrite_Prev[0]<=AngleWrite_Cur[1])||(AngleWrite_Prev[1]>=AngleWrite_Cur[1]))&&(((AngleWrite_Cur[1]-AngleWrite_Prev[1])>=5)||(AngleWrite_Prev[1]-AngleWrite_Cur[1])>=5)){
   Serial.println("Entered elbow, option 3");
   Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
  
shoulder.write(AngleWrite_Cur[1]);
  AngleWrite_Prev[1]=AngleWrite_Cur[1];
  }

//For the Base
  if((AngleWrite_Prev[2]>=AngleWrite_Cur[2])&&(0<=(AngleWrite_Prev[2]-AngleWrite_Cur[2])<=5)){
    Serial.println("Entered base, option 1");
     Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
base.write(AngleWrite_Prev[2]);
 }
else if((AngleWrite_Prev[2]<AngleWrite_Cur[2])&&(0<=(AngleWrite_Cur[2]-AngleWrite_Prev[2])<=5)){
  
  Serial.println("Entered base, option 2");
   Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
  base.write(AngleWrite_Prev[2]);
 }
 else if(((AngleWrite_Prev[2]<=AngleWrite_Cur[2])||(AngleWrite_Prev[2]>=AngleWrite_Cur[2]))&&(((AngleWrite_Cur[2]-AngleWrite_Prev[2])>=5)||(AngleWrite_Prev[2]-AngleWrite_Cur[2])>=5)){
   Serial.println("Entered base, option 3");
 Serial.println(AngleWrite_Prev[0]);
 Serial.println(AngleWrite_Prev[1]);
 Serial.println(AngleWrite_Prev[2]);
 Serial.println(AngleWrite_Cur[0]);
 Serial.println(AngleWrite_Cur[1]);
 Serial.println(AngleWrite_Cur[2]);
shoulder.write(AngleWrite_Cur[2]);
  AngleWrite_Prev[2]=AngleWrite_Cur[2];
  }
 }
}
