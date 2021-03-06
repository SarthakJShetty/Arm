# Four Degrees of Freedom Robotic Arm

## Gesture Controlled Four Degrees of Freedom Robotic Arm

### Introduction
This project comprises of a four degrees of freedom robotic arm, that is controlled by human gestures.

##### Note:
- This project is in the process of being developed, the code is neither stable or final.
- Project report can be viewed [here](https://github.com/SarthakJShetty/Arm/tree/master/Project_Report), for documentation purposes.

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

#### Components:

- Microsoft Kinect for Xbox 360.
- Arduino Uno (Works with other Arduino Models as well).
- Three, 180° servo motors.
- Breadboard.
- Jumper Cables.
- Access to a 3D Printer

#### Steps:

##### Clone the repository

```git clone http://github.com/SarthakJShetty/Arm.git```

##### Wiring Diagram:

![Fritzing Diagram](https://raw.githubusercontent.com/SarthakJShetty/Arm/master/Circuit_Diagram/Circuit_Layout.jpg)

##### Instructions

- Connect the Arduino and setup the system as shown in the <a title="Fritzing Diagram" href="https://github.com/SarthakJShetty/Arm/tree/master/Circuit_Diagram/Circuit_Layout.jpg" target="_blank">Fritzing Diagram</a>.
- Open the <a title="Arduino Code" href="https://github.com/SarthakJShetty/Arm/blob/master/Arduino_Code/Arduino_Code.ino" target="_blank">Arduino Code</a> and upload it to the board.
- Open the <a title="Processing Code" href="https://github.com/SarthakJShetty/Arm/blob/master/Processing_Code/Processing_Code.pde" target="_blank">Processing Code</a> (Processing_Code.pde) and click the "Play" button on the upper left corner.
- Wait for about 20 seconds while the Kinect warms up. You will be alerted by a new Processing Window on your screen.
- Stand in front of the sensor and make some gestures to get the sensor to recognize you.
- Once the color of your silhoutte has changed, wait for another 30 seconds for the skeletal data to be projected.
- Once the skeletal data has been overlaid on your silhoutte, go ahead and make the required gestures.

### Build-Log:

Check out the detailed <a title="build-log" href="https://github.com/SarthakJShetty/Arm/tree/master/build-log.md">build-log</a> for more details about the build.

##### Note:
The older version of the repository was deleted due to a lot of unresolved merging issues. This repository will be updated henceforth.