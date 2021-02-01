//main values
float ScaleValue = 1;  // scale value
int MeasurementUnits = 1;  // measurement is in mm or meters or km (mm = 1, m = 1000, km = 1000000)



// callibration
float CalibrationScreen = 95; // Calibration level 1 
float CalibrationReal = 90;   // Calibration level 1 
float CalibrationScreen2 = 1; // Calibration level 2 
float CalibrationReal2 = 1; // Calibration level 2 

int state = 0; 
String result=""; 
boolean keyboard = false;

import android.view.inputmethod.InputMethodManager;
import android.content.Context;

int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;

int rectX1, rectY1;      // Position of square button
int circleX1, circleY1;  // Position of circle button
int rectSize1 = 90;     // Diameter of rect
int circleSize1 = 93;   // Diameter of circle
color rectColor1, circleColor1, baseColor1;
color rectHighlight1, circleHighlight1;
color currentColor1;
boolean rectOver1 = false;
boolean circleOver1 = false;


void setup() {
  fullScreen();
  noStroke();
  fill(0); 
  
  rectColor = color(0);
  rectHighlight = color(51);
  circleColor = color(255);
  circleHighlight = color(204);
  baseColor = color(102);
  currentColor = baseColor;
  circleX = width/2+circleSize/2+10;
  circleY = height/2-circleSize/2-10;
  rectX = width/2-rectSize-10;
  rectY = int(height/2-rectSize-10);
  ellipseMode(CENTER);
  
  rectColor1 = color(255);
  rectHighlight1 = color(204);
  
  circleColor1 = color(0);
  circleHighlight1 = color(51);
  baseColor1 = color(102);
  currentColor1 = baseColor;
  circleX1 = width/2+circleSize/2+10;
  circleY1 = height/2+circleSize/2+10;
  rectX1 = width/2-rectSize-10;
  rectY1 = height/2+10;
  ellipseMode(CENTER);
  
  
}

void draw() {
  // refresh each step
  background(204);
  
  text(result,width/2,height/2);
  
  switch (state) {
  case 0:
    break;
 
  case 1:
  ScaleValue = int(result);
    closeKeyboard();
    keyboard = false;
    String result="";
    background(204);
    //state++;
    break;
  }
  
  update(mouseX, mouseY);
  stroke(255);

  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
  
  if (rectOver1) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  
  stroke(0);
  rect(rectX1, rectY1, rectSize1, rectSize1);
    
  if (circleOver) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  if (circleOver1) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  
  stroke(255);
  ellipse(circleX1, circleY1, circleSize1, circleSize1);

fill(0);
  
  float WindowWidth = width;
  float WindowHeight = height;

  float TickDistance = 15; // tick size / length
  TickDistance = TickDistance * CalibrationScreen / CalibrationReal;  // calibration level 1 
  TickDistance = TickDistance * CalibrationScreen2 / CalibrationReal2;  // calibration level 2 
  
  float SmallTickSize = 20 ;
  float SmallTickWeight = 1 ;
  float NumberOfSmallTicks = WindowHeight/TickDistance + 1;
  
  float MediumTickSize = SmallTickSize * 1.5 ;
  float MediymTickWeight = SmallTickWeight *1.5 ;
  float NumberOfMediumTicks = NumberOfSmallTicks/5;
  
  float LargeTickSize = SmallTickSize * 2;
  float LargeTickWeight = SmallTickWeight *2 ;
  float NumberOfLargeTicks = NumberOfSmallTicks/10;  
  
  float VerySmallTickSize = SmallTickSize * 0.5 ;
  float VerySmallTickWeight = 0.5 ;
  float NumberOfVerySmallTicks = (WindowHeight/TickDistance + 1)*2;
   

  
  // make the calibration scale 
  strokeWeight(SmallTickWeight);
  stroke(180);
  for (int i=0; i<NumberOfSmallTicks; i++){
    line(0,i * TickDistance,SmallTickSize, i * TickDistance);
  }
  strokeWeight(MediymTickWeight);
  stroke(100);
  for (int i=0; i<NumberOfMediumTicks; i++){
    line(0,i * TickDistance*5,MediumTickSize, i * TickDistance*5);
  }
  strokeWeight(LargeTickWeight);
  stroke(100);
  for (int i=0; i<NumberOfLargeTicks; i++){
    line(0,i * TickDistance*10,LargeTickSize, i * TickDistance*10);
  }
  

  // random values given know will have no effect 
  float Magnitude = 3.5; 
  float MagnitudeFactor = 1;
  float StandardScale = 5.2;
  
  // increase length for the scaled scale
  float IncreaseRealScaleLength = SmallTickSize;
  
  // get scale value 
  if (ScaleValue >= 100000){
    Magnitude = 100000;
    StandardScale = ScaleValue /100000;
  }
  if (10000 <= ScaleValue && ScaleValue < 100000){
    Magnitude = 10000;
    StandardScale = ScaleValue /10000;
  }
  if (1000 <= ScaleValue && ScaleValue < 10000){
    Magnitude = 1000;
    StandardScale = ScaleValue /1000;
  }
  if (100 <= ScaleValue && ScaleValue < 1000){
    Magnitude = 100;
    StandardScale = ScaleValue /100;
  }
  if (10 <= ScaleValue && ScaleValue < 100){
    Magnitude = 10;
    StandardScale = ScaleValue /10;
  }
  if (1 <= ScaleValue && ScaleValue < 10){
    Magnitude = 1;
    StandardScale = ScaleValue;
  }
  
  // text heading of scale
  //get from pixel density 
  float OneMMSize = 15*30*161/160/40;
  textSize(OneMMSize+10);
  
  if (MeasurementUnits == 1){
    pushMatrix();
    translate( WindowWidth-LargeTickSize*2.5, TickDistance/2);
    rotate(PI/2.0);
    text("Millimeter", 0,0); 
    popMatrix();
    MagnitudeFactor = Magnitude / MeasurementUnits;
  } 
  if (MeasurementUnits == 1000){
    pushMatrix();
    translate( WindowWidth-LargeTickSize*2.5, TickDistance/2);
    rotate(PI/2.0);
    text("Meter", 0,0); 
    popMatrix();
    MagnitudeFactor = Magnitude / MeasurementUnits;
  } 
    if (MeasurementUnits == 1000000){
    pushMatrix();
    translate( WindowWidth-LargeTickSize*2.5, TickDistance/2);
    rotate(PI/2.0);
    text("KiloMeter", 0,0); 
    popMatrix();
    MagnitudeFactor = Magnitude / MeasurementUnits;
  } 
    pushMatrix();
    translate( WindowWidth-LargeTickSize*3, TickDistance/2);
    rotate(PI/2.0);
    text("1:", 0,0);   
    if (ScaleValue == int(ScaleValue)){
      text(int(ScaleValue), OneMMSize+10,0);   
      } 
      else {
        text(ScaleValue, OneMMSize+10,0);   
      }
    popMatrix();
  
  
  // text
  textSize(OneMMSize+10/5);  

  
  //stage 1
  if (0 < StandardScale && StandardScale <= 1){
    TickDistance = TickDistance / StandardScale;
    NumberOfSmallTicks = NumberOfSmallTicks * StandardScale;
    NumberOfMediumTicks = NumberOfMediumTicks * StandardScale;
    NumberOfLargeTicks = NumberOfLargeTicks * StandardScale;
    // make the actual scale 
    strokeWeight(SmallTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfSmallTicks; i++){
      line(int(WindowWidth-SmallTickSize-IncreaseRealScaleLength),int(i * TickDistance), int(WindowWidth), int(i * TickDistance));
    }
    strokeWeight(MediymTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfMediumTicks; i++){
      line(int(WindowWidth-MediumTickSize-IncreaseRealScaleLength),int(i * TickDistance*5), int(WindowWidth), int(i * TickDistance*5));
    }
    strokeWeight(LargeTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfLargeTicks; i++){
      line(int(WindowWidth-LargeTickSize-IncreaseRealScaleLength),int(i * TickDistance*10), int(WindowWidth), int(i * TickDistance*10));
        
      pushMatrix();
      translate( WindowWidth-LargeTickSize-IncreaseRealScaleLength, (i * TickDistance*10)+ (OneMMSize+10)/5);
      rotate(PI/2.0);
      
      if (MagnitudeFactor == int(MagnitudeFactor)){
      text(int(i*MagnitudeFactor*10), 0,0);   
      } 
      else {
        text(i*MagnitudeFactor*10, 0,0);   
      }
      popMatrix();

    }
  }
  
  // stage 2 
  if (1 < StandardScale && StandardScale <= 2.5){
    TickDistance = TickDistance / StandardScale*2;
    NumberOfSmallTicks = NumberOfSmallTicks * StandardScale;
    NumberOfMediumTicks = NumberOfMediumTicks * StandardScale ;
    NumberOfLargeTicks = NumberOfLargeTicks * StandardScale*10/25;
    // make the actual scale 
    strokeWeight(SmallTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfSmallTicks; i++){
      line( int(WindowWidth-SmallTickSize-IncreaseRealScaleLength) , int(i * TickDistance) , int(WindowWidth) , int(i * TickDistance)) ;
    }
    strokeWeight(MediymTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfMediumTicks; i++){
      line( int(WindowWidth-MediumTickSize-IncreaseRealScaleLength),int(i * TickDistance*5),int(WindowWidth), int(i * TickDistance*5));
    }
    strokeWeight(LargeTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfLargeTicks; i++){
      line( int(WindowWidth-LargeTickSize-IncreaseRealScaleLength) ,int(i * TickDistance*25), int(WindowWidth), int(i * TickDistance*25));
      
      pushMatrix();
      translate( WindowWidth-LargeTickSize-IncreaseRealScaleLength, (i * TickDistance*25)+ (OneMMSize+10)/5);
      rotate(PI/2.0);
      
      if (MagnitudeFactor == int(MagnitudeFactor)){
      text(int(i*MagnitudeFactor*5*10), 0,0);   
      } 
      else {
        text(i*MagnitudeFactor*5*10, 0,0);   
      }
      popMatrix();      
      
      
      
    } 
  }
  
  
  // stage 3 
  if (2.5 < StandardScale && StandardScale <= 7.5){
    TickDistance = TickDistance / StandardScale*10;
    NumberOfSmallTicks = NumberOfSmallTicks * StandardScale;
    NumberOfMediumTicks = NumberOfMediumTicks * StandardScale ;
    NumberOfLargeTicks = NumberOfLargeTicks * StandardScale*10;
    NumberOfVerySmallTicks = NumberOfSmallTicks * 2;
    // make the actual scale 
    strokeWeight(SmallTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfSmallTicks; i++){
      line( int(WindowWidth-SmallTickSize-IncreaseRealScaleLength) , int(i * TickDistance),int(WindowWidth) , int(i * TickDistance));
    }
    strokeWeight(MediymTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfMediumTicks; i++){
      line( int(WindowWidth-MediumTickSize-IncreaseRealScaleLength) , int(i * TickDistance*5),int(WindowWidth) , int(i * TickDistance*5));
    }
    strokeWeight(LargeTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfLargeTicks; i++){
      line( int(WindowWidth-LargeTickSize-IncreaseRealScaleLength) , int(i * TickDistance*10),int(WindowWidth) , int(i * TickDistance*10));
    }
    strokeWeight(VerySmallTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfVerySmallTicks; i++){
      line(int(WindowWidth-SmallTickSize-(IncreaseRealScaleLength/2)) ,int(i * TickDistance/2),int(WindowWidth), int(i * TickDistance/2));
      
      pushMatrix();
      translate( WindowWidth-LargeTickSize-IncreaseRealScaleLength, (i * TickDistance*10)+ (OneMMSize+10)/5);
      rotate(PI/2.0);
      
      if (MagnitudeFactor == int(MagnitudeFactor)){
      text(int(i*MagnitudeFactor*10*10), 0,0);   
      } 
      else {
        text(i*MagnitudeFactor*10*10, 0,0);   
      }
      popMatrix();
      
      
    } 
  }
  
  //stage 4
  if (7.5 < StandardScale && StandardScale <= 10){
    TickDistance = TickDistance / StandardScale*10;
    NumberOfSmallTicks = NumberOfSmallTicks * StandardScale;
    NumberOfMediumTicks = NumberOfMediumTicks * StandardScale;
    NumberOfLargeTicks = NumberOfLargeTicks * StandardScale;
    // make the actual scale 
    strokeWeight(SmallTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfSmallTicks; i++){
      line(int(WindowWidth-SmallTickSize-IncreaseRealScaleLength), int(i * TickDistance), int(WindowWidth), int(i * TickDistance));
    }
    strokeWeight(MediymTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfMediumTicks; i++){
      line(int(WindowWidth-MediumTickSize-IncreaseRealScaleLength), int(i * TickDistance*5), int(WindowWidth), int(i * TickDistance*5));
    }
    strokeWeight(LargeTickWeight);
    stroke(1);
    for (int i=0; i<NumberOfLargeTicks; i++){
      line(int(WindowWidth-LargeTickSize-IncreaseRealScaleLength), int(i * TickDistance*10), int(WindowWidth), int(i * TickDistance*10));
      
      pushMatrix();
      translate( WindowWidth-LargeTickSize-IncreaseRealScaleLength, (i * TickDistance*10)+ (OneMMSize+10)/5);
      rotate(PI/2.0);
      
      if (MagnitudeFactor == int(MagnitudeFactor)){
      text(int(i*MagnitudeFactor*10*10), 0,0);   
      } 
      else {
        text(i*MagnitudeFactor*10*10, 0,0);   
      }
      popMatrix();
      
      
    }
  }
  

  
}




void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
    rectOver1 = false;
    circleOver1 = false;
  } 
  else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    circleOver = false;
    rectOver = true;
    rectOver1 = false;
    circleOver1 = false;
  } 
    else if ( overRect(rectX1, rectY1, rectSize1, rectSize1) ) {
    circleOver = false;
    rectOver = false;
    rectOver1 = true;
    circleOver1 = false;
  }
    else if ( overCircle(circleX1, circleY1, circleSize1) ) {
    circleOver = false;
    rectOver = false;
    rectOver1 = false;
    circleOver1 = true;
  }
  else {
    circleOver = false;
    rectOver = false;
    rectOver1 = false;
    circleOver1 = false;
  }
}

void mousePressed() {
  if (rectOver) {
  
    if (!keyboard) {
    openKeyboard();
    keyboard = true;
  } else {
    closeKeyboard();
    keyboard = false;
  }
    
    
  }
  if (circleOver) {
    MeasurementUnits = 1;
  }
  if (rectOver1) {
  MeasurementUnits = 1000000;
  }
  if (circleOver1) {
  MeasurementUnits = 1000;
  }
  
}

void keyPressed() {
 
if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) {
 
    state++;
  } else
  result = result + key;
}


boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
