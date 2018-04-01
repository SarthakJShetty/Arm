# Four Degrees of Freedom Robotic Arm
## Gesture Controlled Four Degrees of Freedom Robotic Arm

### Introduction
This project comprises of a four degrees of freedom robotic arm, that is controlled by human gestures.

##### Note:
This project is in the process of being developed, the code is neither stable or final.

### Credits
This project was developed from an existing [Instructable](http://www.instructables.com/id/Kinect-Controlled-Arms/) as a base. The Instructable dealt with the development of a humanoid robot, comprising of 4 servo motors, 2 for each arm. The code was modified for a robotic arm. Some portions of the project retain the nascency, especially the Processing code.

### Working
- A Microsoft Kinect for Xbox 360 is used in this case to detect the gestures of both arms.
- Angles are calculated from skeletal data, processed by Processing and transmitted through the COM port to the Arduino.
- The Arduino produces the required output, in the form of rotation through the required angles.
- If a deviation of less than 5° is measured between the updated angle and the previous angle, the old angle is preserved. This step ensures reduction in jerky movement of the arm, which actually mimics the natural movements of the human arm.
- Note: This project is compatible specifically with Processing 2 and not Processing 3. If prompted to upgrade the Processing version, please refrain.

### Control
- The right arm shoulder movement controls the shoulder joint movement of the robotic arm.
- The right arm elbow movement controls the elbow joint movement of the robotic arm.
- The left arm shoulder movement controls the basal movement.
- The left arm elbow movement controls the gripper movement.

### How to build your own?

#### Components
- Microsoft Kinect for Xbox 360.
- Arduino Uno (Works with other Arduino Models as well).
- Three, 180° servo motors.
- Breadboard.
- Jumper Cables.
- Access to a 3D Printer

#### Steps:

##### Clone the repository
```
	git clone http://github.com/SarthakJShetty/Arm.git
```
##### Instructions

- Connect the Arduino and setup the system as shown (to be added).
- Open the Arduino Code (Arduino_Code.ino) and upload it to the board.
- Open the Processing Code (Processing_Code.pde) and click the "Play" button on the upper left corner.
- Wait for about 20 seconds while the Kinect warms up. You will be alerted by a new Processing Window on your screen.
- Stand in front of the sensor and make some gestures to get the sensor to recognize you.
- Once the color of your silhoutte has changed, wait for another 30 seconds for the skeletal data to be projected.
- Once the skeletal data has been overlaid on your silhoutte, go ahead and make the required gestures.

### Build Log:

#### 01/03/2017
- Added robotic base movement
- Should add angle limitters to various gestures.

#### 01/04/2017;
- Angle control should be added
- Currently using high torque 360° servo motors.
- Processing code modified to improve the angular readings.
- Failed to optimize Arduino code for limiting the rotation of joints.

#### 01/05/2017:
- Replaced high torque 360° servos with 180°, relatively low torque motors.
- Replaced Arduino to avoid shorting, which was brought about when angle changed rapidly.
- Added functionality to limit the movement of the joints.
- Changed Processing code to accomadate old and new angle values.
- New servo motors limit rotation of shoulder and elbow joints to ~135°.

#### 01/06/2017
- Angle limiters have been added.
- Optimal angle values have to be determined however.
- Base rotation is unpredictable, still using a 360° servo motor.
- Gear train system might have to be used along with a 180° motor to improve the rotation.

#### 01/07/2017
- Added a data logger which creates .txt file to store the data of a given user.
- Formatted the data logger, removed the Recording Number tab.
- New "dev" branch to be added.

#### 01/04/2018
- The code works on an actual robotic arm. Video will be up soon.
- The Gripper has been successfully integrated.
- Data logger now features Gripper Angle (Left elbow angle) as well.
- An example of the UserReadings have been provided as well.
- The readings are in csv format, for easy analysis and data manipulation.

##### Note:
The older version of the repository was deleted due to a lot of unresolved mergin issues. This repository will be updated henceforth.