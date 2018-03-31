import SimpleOpenNI.*;
PrintWriter output;
import processing.serial.*;
Serial port;

//Old will comprise of the older angles
//Shiny will comprise of the newer angles, and the values that will be sent to the Arduino
      int old[]={0,0,0,0};
      int shiny[]={0,0,0,0};

SimpleOpenNI  context;

float        zoomF =2f;

color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };
PVector com = new PVector();                                   
PVector com2d = new PVector();                                   


void setup()
{
  output=createWriter("SarthakReadings.txt");
  size(640*4, 2*480);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  
  // finding arduino
  println(Serial.list());
  String portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);

  // mirror is by default enabled
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable ir generation
  context.enableRGB();
  
  // enable skeleton generation for all joints
  context.enableUser();
}

void draw()
{
  // update the cam
  context.update();
  scale(zoomF);

  background(200, 0, 0);

  // draw depthImageMap
  image(context.depthImage(), 0, 0);
  
  // draw user
  image(context.userImage(),0,0);

  // draw irImageMap
  image(context.rgbImage(), context.depthWidth() + 10, 0);
  
  // draw the skeleton if it's available
  int[] userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
    {
      stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      drawSkeleton(userList[i]);
      //RIGHT HAND SET UP:
      
      //rigth hand set up 
      PVector rightHand = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
      //rigth elbow set up 
      PVector rightElbow = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_RIGHT_ELBOW, rightElbow);
      //rigth shoulder set up 
      PVector rightShoulder = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_RIGHT_SHOULDER, rightShoulder);
      //rigth hip set up 
      PVector rightHip = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_RIGHT_HIP, rightHip);
      //
      
      // LEFT HAND SET UP:
      
      //left hand set up 
      PVector leftHand = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
      //rigth elbow set up 
      PVector leftElbow = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_LEFT_ELBOW, leftElbow);
      //rigth shoulder set up 
      PVector leftShoulder = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_LEFT_SHOULDER, leftShoulder);
      //rigth hip set up 
      PVector leftHip = new PVector();
      context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_LEFT_HIP, leftHip);
      
      // creating joints
      //right
      PVector rightHand2D = new PVector(rightHand.x , rightHand.y);
      PVector rightElbow2D = new PVector(rightElbow.x , rightElbow.y);
      PVector rightShoulder2D = new PVector(rightShoulder.x , rightShoulder.y);
      PVector rightHip2D = new PVector(rightHip.x , rightHip.y);
      PVector rightTorso2D = PVector.sub(rightShoulder2D , rightHip2D);
      PVector rightHandUpper2D = PVector.sub(rightElbow2D , rightShoulder2D);
      //left
      PVector leftHand2D = new PVector(leftHand.x , leftHand.y);
      PVector leftElbow2D = new PVector(leftElbow.x , leftElbow.y);
      PVector leftShoulder2D = new PVector(leftShoulder.x , leftShoulder.y);
      PVector leftHip2D = new PVector(leftHip.x , leftHip.y);
      PVector leftTorso2D = PVector.sub(leftShoulder2D , leftHip2D);
      PVector leftHandUpper2D = PVector.sub(leftElbow2D , leftShoulder2D);
      

      // finding the angles
      //right
      float rightShoulderAngle = 270 + angleOf(rightElbow2D, rightShoulder2D, rightTorso2D);
      float rightElbowAngle = 180 - angleOf(rightHand2D, rightElbow2D, rightHandUpper2D);
      //Left 
      float leftShoulderAngle =180 - angleOf(leftElbow2D, leftShoulder2D, leftTorso2D);
      float leftElbowAngle = angleOf(leftHand2D, leftElbow2D, leftHandUpper2D);
      
      //displays angles measured
      text("\n"+"Right Shoulder Angle: "+int(rightShoulderAngle),30,30);
      text("\n \n"+"Right Elbow Angle: "+int(rightElbowAngle),30,30);
      text("\n \n \n"+"Base Rotation Value: "+int(leftShoulderAngle),30,30);
      text("\n \n \n \n"+"Future Gripper Angle: "+int(leftElbowAngle),30,30);
      
      //Declaring old variable that will display the old angular values
      //Declaring shiny variable that will contain the new, just updated value

      shiny[0]=int(rightShoulderAngle);
      shiny[1]=int(rightElbowAngle);
      shiny[2]=int(leftShoulderAngle);
      shiny[3]=int(leftElbowAngle);
     
     //Printing the old values of the angle
     text("\n \n \n \n \n"+"Old Shoulder Angle"+int(old[0]),30,30);
     text("\n \n \n \n \n \n"+"Old Elbow Angle"+int(old[1]),30,30);
     text("\n \n \n \n \n \n \n"+"Old Base Angle"+int(old[2]),30,30);
     text("\n \n \n \n \n \n \n \n"+"Gripper Angle"+int(old[3],30,30);
     
     
     //Declaring a variable to output the required data
      byte out[]=new byte[3];
      
      
      //Will check the need to update and send the value to the Arduino
      //If condition is not satisfied, old value will be written to out and will be sent to the Arduino
      
      //Shoulder angle checker
      if((shiny[0]>=old[0])&&(((shiny[0]-old[0])<=5)&&((shiny[0]-old[0])>=0))){
        
      //Sending the old data out
      out[0]=byte(old[0]);
      }
      else if(shiny[0]<old[0]&&(((old[0]-shiny[0])<=5)&&(old[0]-shiny[0]>=0))){
      out[0]=byte(old[0]);
      }
      else if(((shiny[0]<=old[0])||(shiny[0]>=old[0]))&&((shiny[0]-old[0])>5||((old[0]-shiny[0])>5))){
        
      //Replacing the old data with shiny data
      old[0]=shiny[0];
      //Sending out the shiny data
      out[0]=byte(shiny[0]);
      }
      
      //Elbow angle checker
      if((shiny[1]>=old[1])&&(((shiny[1]-old[1])<=10)&&((shiny[1]-old[1])>=0))){
      //Sending the old data out
      out[1]=byte(old[1]);
      }
      else if(shiny[1]<old[1]&&(((old[1]-shiny[1])<=10)&&(old[1]-shiny[1]>=0))){
      out[1]=byte(old[1]);
      }
      else if(((shiny[1]<=old[1])||(shiny[1]>=old[1]))&&((shiny[1]-old[1])>10||((old[1]-shiny[1])>10))){
        
      //Replacing old with shiny
      out[1]=byte(shiny[1]);
      old[1]=shiny[1];
      }
      
      //Base angle checker
      if((shiny[2]>=old[2])&&(((shiny[2]-old[2])<=10)&&((shiny[2]-old[2])>=0))){
      out[2]=byte(old[2]);
      }
      else if(shiny[2]<old[2]&&(((old[2]-shiny[2])<=10)&&(old[2]-shiny[2]>=0))){
      out[2]=byte(old[2]);
      }
      else if(((shiny[2]<=old[2])||(shiny[2]>=old[2]))&&((shiny[2]-old[2])>10||((old[2]-shiny[2])>10))){
      out[2]=byte(shiny[2]);
      old[2]=shiny[2];
      }
      //Base angle checker
      if((shiny[3]>=old[3])&&(((shiny[3]-old[3])<=10)&&((shiny[3]-old[3])>=0))){
      out[3]=byte(old[3]);
      }
      else if(shiny[3]<old[3]&&(((old[3]-shiny[3])<=10)&&(old[3]-shiny[3]>=0))){
      out[3]=byte(old[3]);
      }
      else if(((shiny[3]<=old[3])||(shiny[3]>=old[3]))&&((shiny[3]-old[3])>10||((old[3]-shiny[3])>10))){
      out[3]=byte(shiny[3]);
      old[3]=shiny[3];
      }      
      /*Volatile Section:
      Code has not been fully developed.*/
      //This portion of the code is dedicated to the collection and analysis of data
      //A special Processing function called create.Writer() has been used
      //A .txt is created which stores the data. For the time being a sample size of 1000 data samples has been considered.
      //This data can be used to train a Deep Neural Networks.
      //The applications are endless.
      
      //Counter variable, "n", initialized to 0.
      int n=2;
      for(n=2;((n<=1000)&&((n%2)==0));n++){
        
        //Once the sample size has reached 999, the user can be indicated to stop training
        if(n==998){
        text("\n \n \n \n \n \n \n \n \n"+"Sampling at: "+int(n),30,30,30);
         text("\n \n \n \n \n \n \n \n \n \n"+"Suffiecient samples collected, training can be stopped now",30,30,30);   
    }
    
    
      //Here is the output writer, which will store the values read onto a file.
      //Shiny values can be used, as they are more stable as opposed to Old values.
      //For more accurate training, but smaller sample size diversity, Old can be used.
      //For less precise training, but larger sample size diversity, Shiny can be used.
      //Use accordingly.
      
      
      //Removed the Recording Number tab
      output.println("Right Shoulder Angle:"+"\t"+shiny[0]+"\t"+" Right Elbow Angle:"+"\t"+shiny[1]+"\t"+"Base Rotation Angle:"+"\t"+shiny[2]);
      output.flush();
    }
      
      
      //Here lies the unused byte, for the use of a gripper
      //out[3] = byte(leftElbowAngle);
      
      //sending data
      port.write(out); 
      }      
      
    // draw the center of mass
    if(context.getCoM(userList[i],com))
    {
      context.convertRealWorldToProjective(com,com2d);
      stroke(100,255,0);
      strokeWeight(1);
      beginShape(LINES);
        vertex(com2d.x,com2d.y - 5);
        vertex(com2d.x,com2d.y + 5);

        vertex(com2d.x - 5,com2d.y);
        vertex(com2d.x + 5,com2d.y);
      endShape();
      
      fill(0,255,100);
      text(Integer.toString(userList[i]),com2d.x,com2d.y);
    }
  }
}

float angleOf(PVector one, PVector two, PVector axis)
{
  PVector limb=PVector.sub(two,one);
  return degrees(PVector.angleBetween(limb,axis));
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
  
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
}


void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

