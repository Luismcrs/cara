import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
boolean hayCaras = false;


float alto;

float[] pX = new float[66];
float[] pY = new float[66];
PVector[] v= new PVector[66];

PVector pos;

void setup() {
  size(600, 600);
  oscP5 = new OscP5(this, 8338);
  myRemoteLocation = new NetAddress("127.0.0.1", 8338);
  for (int i =0; i<66; i++) {
    v[i]= new PVector();
  }
}

void draw() {
  background(0);

  if (hayCaras) {
    fill(227, 169, 169);
    //noStroke();
    //ellipse(pos.x, pos.y, 400, 400);
  }
  for (int i =0; i<36; i++) {
    fill(255, i*5, 0);
    //stroke(255,50);
    //ellipse(width-v[i].x,v[i].y,3,3);
    //line(width-v[i].x,v[i].y,0,0);
    //line(width-v[i].x,v[i].y,width/2,0);
    //line(width-v[i].x,v[i].y,width,0);
    //line(width-v[i].x,v[i].y,0,height);
    //line(width-v[i].x,v[i].y,0,height/2);
    //line(width-v[i].x,v[i].y,width,height);
    //line(width-v[i].x,v[i].y,width,height/2);
    //line(width-v[i].x,v[i].y,width/2,height);
    ellipse(width-v[i].x, v[i].y, i, i);
  }
  for (int i =36; i<48; i++) {
    fill(0, 0, 255);
    ellipse(width-v[i].x, v[i].y, i/2, i/2);
  }
   for (int i =48; i<66; i++) {
    fill(255, 0, i);
    ellipse(width-v[i].x, v[i].y, i/2, i/2);
  }
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  if ( theOscMessage.checkAddrPattern("/pose/position") == true) {
    float firstValue = theOscMessage.get(0).floatValue();
    float secondValue = theOscMessage.get(1).floatValue();
    pos = new PVector(width-firstValue, secondValue);
  } 

  if (theOscMessage.checkAddrPattern("/found") == true) {
    hayCaras=false;
  } else {
    hayCaras=true;
  }

  if ( theOscMessage.checkAddrPattern("/raw") == true) {
    for (int i=0; i < 66; i++) {
      v[i].set(theOscMessage.get(i*2).floatValue(), theOscMessage.get(i*2+1).floatValue());
    }
  }
    if ( theOscMessage.checkAddrPattern("/gesture/mouth/height") == true) {
     alto = theOscMessage.get(0).floatValue();
     println(alto);
  }



  println(" typetag: "+theOscMessage.typetag());
  return;
}
