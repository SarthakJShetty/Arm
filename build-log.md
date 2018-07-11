### Build Log:

#### 01/03/2018
- Added robotic base movement
- Should add angle limitters to various gestures.

#### 01/04/2018
- Angle control should be added
- Currently using high torque 360° servo motors.
- Processing code modified to improve the angular readings.
- Failed to optimize Arduino code for limiting the rotation of joints.

#### 01/05/2018
- Replaced high torque 360° servos with 180°, relatively low torque motors.
- Replaced Arduino to avoid shorting, which was brought about when angle changed rapidly.
- Added functionality to limit the movement of the joints.
- Changed Processing code to accomadate old and new angle values.
- New servo motors limit rotation of shoulder and elbow joints to 135°.


#### 01/06/2018
- Angle limiters have been added.
- Optimal angle values have to be determined however.
- Base rotation is unpredictable, still using a 360° servo motor.
- Gear train system might have to be used along with a 180° motor to improve the rotation.

#### 01/07/2018
- Added a data logger which creates .txt file to store the data of a given user.
- Formatted the data logger, removed the Recording Number tab.
- New "dev" branch to be added.

#### 04/01/2018
- The code works on an actual robotic arm. Video will be up soon.
- The Gripper has been successfully integrated.
- Data logger now features Gripper Angle (Left elbow angle) as well.
- An example of the UserReadings have been provided as well.
- The readings are in csv format, for easy analysis and data manipulation.

#### 06/04/2018
- Adding circuit diagram (finally) here.
- Processing_Code can now display gripper angles, and gripper values will be sent to the Arduino as well.

#### 06/06/2018
-Project report has been added here, to improve documentation.