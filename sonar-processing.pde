import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort; 
// Variables
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
    size(1080, 660); // ***ADJUST THIS TO YOUR SCREEN RESOLUTION***
    smooth();
    myPort = new Serial(this, "/dev/tty.usbserial-120", 9600); // initialize serial communication
    myPort.bufferUntil('.'); // read data from the serial port until the character '.' is received, which contains angle and distance.
    orcFont = createFont("Helvetica", 20);
}

void draw() {
    fill(98, 245, 31);
    textFont(orcFont);
    
    // Simulating motion blur and slow fade of the moving sonar line
    noStroke();
    fill(0, 4); 
    rect(0, 0, width, height - height * 0.065);
    
    fill(98, 245, 31); // green color
    
    // Drawing sonar and detected objects
    drawSonar(); 
    drawLine();
    drawObject();
    drawText();
}

void serialEvent(Serial myPort) { // Start reading data from the serial port
    data = myPort.readStringUntil('.');
    data = data.substring(0, data.length() - 1);
    
    index1 = data.indexOf(","); // Find the comma character and store its position in index1
    angle = data.substring(0, index1); // Read angle data sent from Arduino
    distance = data.substring(index1 + 1, data.length()); // Read distance data sent from Arduino
    
    // Convert the string variables to integers
    iAngle = int(angle);
    iDistance = int(distance);
}

void drawSonar() {
    pushMatrix();
    translate(width / 2, height - height * 0.074); // Move origin to new coordinates
    noFill();
    strokeWeight(2);
    stroke(98, 245, 31); // green lines
    
    // Draw sonar arcs
    arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
    arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
    arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
    arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);
    
    // Draw angular lines
    line(-width / 2, 0, width / 2, 0);
    line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
    line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
    line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
    line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
    line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
    
    popMatrix();
}

void drawObject() {
    pushMatrix();
    translate(width / 2, height - height * 0.074); // Move origin to new coordinates
    strokeWeight(9);
    stroke(255, 10, 10); // red color for detected objects
    
    pixsDistance = iDistance * ((height - height * 0.1666) * 0.025); // Convert sensor distance (cm) to pixels
    
    if (iDistance < 40) {
        // Draw the detected object based on angle and distance
        line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)), (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
    }
    popMatrix();
}

void drawLine() {
    pushMatrix();
    strokeWeight(9);
    stroke(30, 250, 60); // green line
    translate(width / 2, height - height * 0.074); // Move origin to new coordinates
    
    // Draw the sonar line based on angle
    line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle))); 
    
    popMatrix();
}

void drawText() { // Draw text on screen
    pushMatrix();
    if (iDistance > 40) {
        noObject = "Out of Range";
    } else {
        noObject = "Object Detected";
    }
    
    fill(0, 0, 0);
    noStroke();
    rect(0, height - height * 0.0648, width, height);
    
    fill(98, 245, 31); // green color for text
    textSize(15);
    
    text("10cm", width - width * 0.3854, height - height * 0.0833);
    text("20cm", width - width * 0.281, height - height * 0.0833);
    text("30cm", width - width * 0.177, height - height * 0.0833);
    text("40cm", width - width * 0.0729, height - height * 0.0833);
    
    textSize(20);
    text("Object: " + noObject, width - width * 0.875, height - height * 0.0277);
    text("Angle: " + iAngle + " °", width - width * 0.48, height - height * 0.0277);
    text("Distance: ", width - width * 0.26, height - height * 0.0277);
    
    if (iDistance < 40) {
        text("        " + iDistance + " cm", width - width * 0.225, height - height * 0.0277);
    }
    
    textSize(25);
    fill(98, 245, 60);
    
    // Drawing angular text on the sonar
    translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
    rotate(-radians(-60));
    text("30°", 0, 0);
    resetMatrix();
    
    translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
    rotate(-radians(-30));
    text("60°", 0, 0);
    resetMatrix();
    
    translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
    rotate(radians(0));
    text("90°", 0, 0);
    resetMatrix();
    
    translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
    rotate(radians(-30));
    text("120°", 0, 0);
    resetMatrix();
    
    translate((width - width * 0.5104) + width / 2 * cos(radians(150)), (height - height * 0.0574) - width / 2 * sin(radians(150)));
    rotate(radians(-60));
    text("150°", 0, 0);
    
    popMatrix();
}