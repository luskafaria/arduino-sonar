# 🛰️ Arduino Sonar Project

Create your very own Arduino-based sonar system using an ultrasonic sensor, a servo motor, and Processing to visualize it on your screen! This project simulates a sonar scanning for objects, displaying their distances and angles in real-time.

![Sonar Visualization](https://github.com/luskafaria/arduino-sonar/blob/main/image.png?raw=true)
---

## 🚀 Table of Contents

- [✨ Overview](#-overview)
- [🧰 Components Required](#-components-required)
- [🔌 Circuit Diagram](#-circuit-diagram)
- [⚙️ Setup Instructions](#️-setup-instructions)
  - [🔨 Arduino Setup](#-arduino-setup)
  - [💻 Processing Setup](#-processing-setup)
- [🌀 How It Works](#-how-it-works)
  - [📟 Arduino Code Explanation](#-arduino-code-explanation)
  - [🖥️ Processing Code Explanation](#-processing-code-explanation)
- [📝 Usage](#-usage)
- [❓ Troubleshooting](#-troubleshooting)
- [📜 Credits](#-credits)

---

## ✨ Overview

Welcome to the **Arduino Sonar Project**! 🚀 

This project involves a simple sonar system using:
- **Arduino Uno**, 
- **Ultrasonic Sensor (HC-SR04)**, and
- **Servo Motor**.

The ultrasonic sensor is mounted on a servo motor to scan an area, detecting objects and their distance. This data is visualized on a sonar screen using **Processing**, allowing you to see what the sonar "sees."

---

## 🧰 Components Required

- **🖲️ Arduino Uno (or compatible board)**
- **📡 Ultrasonic Sensor (HC-SR04)**
- **⚙️ Servo Motor (e.g., SG90)**
- **🔌 Breadboard and Jumper Wires**
- **🔋 USB Cable for Arduino**
- **💻 Computer with Arduino IDE and Processing IDE installed**

---

## 🔌 Circuit Diagram

![Circuit Diagram](https://your-image-link-here.com/circuit_diagram.png)

### 📐 Connections:

- **Ultrasonic Sensor HC-SR04**
  - ⚡ **VCC** → 5V
  - 🥶 **GND** → GND
  - 📍 **Trig** → Arduino Pin **12**
  - 📍 **Echo** → Arduino Pin **13**
- **Servo Motor**
  - 📍 **Signal** → Arduino Pin **6**
  - ⚡ **VCC** → 5V
  - 🥶 **GND** → GND

> **💡 Tip:** Ensure that the servo motor and ultrasonic sensor share a common ground with the Arduino.

---

## ⚙️ Setup Instructions

### 🔨 Arduino Setup

1. **Install the Arduino IDE** 🖥️:
   - Download it from the [official website](https://www.arduino.cc/en/software).

2. **Connect the Arduino** to your computer using the USB cable.

3. **Open the Arduino Sketch** (`sonar.ino`) provided in this repository.

4. **Install the Servo Library**:
   - Usually included with the Arduino IDE by default.

5. **Upload the Sketch**:
   - Select the correct **Board** (`Arduino Uno`) and **Port** from the `Tools` menu.
   - Click the **Upload** button. 🚀

### 💻 Processing Setup

1. **Install the Processing IDE** from the [official website](https://processing.org/download/).

2. **Install the Serial Library** 📦:
   - It is included with Processing by default.

3. **Open the Processing Sketch** (`sonar.pde`) provided in this repository.

4. **Adjust Serial Port Settings**:
   - Find the line in the code where the serial port is initialized:
     ```java
     myPort = new Serial(this, "/dev/tty.usbserial-120", 9600);
     ```
   - Update `"/dev/tty.usbserial-120"` to the correct port for your Arduino:
     - On **Windows**, it might be something like `"COM3"`.
     - On **macOS/Linux**, it could be like `"/dev/tty.usbmodem1411"`.

5. **Adjust Screen Resolution** if necessary:
   - The default size is set to `size(1080, 660);`.
   - Adjust these values to match your screen resolution.

---

## 🌀 How It Works

### 📟 Arduino Code Explanation (`sonar.ino`)

- **Libraries and Pin Definitions**:
  - The `Servo.h` library is used to control the servo motor.
  - Defines pins for the **ultrasonic sensor** (`trigPin`, `echoPin`) and the **servo motor** (`servoPin`).

- **Setup Function**:
  - Initializes **serial communication** at 9600 baud.
  - Attaches the **servo motor**.
  - Sets the **ultrasonic sensor pins** as input and output.

- **Main Loop**:
  - Rotates the servo motor from **15° to 165°**, simulating a sonar sweep.
  - Measures the **distance** to any object and sends the **angle and distance data** over serial in the format `angle,distance.`.

- **calculateDistance Function**:
  - Sends a trigger pulse to the **ultrasonic sensor**.
  - Measures the **duration** of the echo pulse.
  - Calculates the **distance** based on the speed of sound.

### 🖥️ Processing Code Explanation (`sonar.pde`)

- **Libraries and Variables**:
  - Imports the `processing.serial.*` library for **serial communication**.
  - Defines variables for storing **angle**, **distance**, and other data.

- **Setup Function**:
  - Sets up the **window size** and initializes the **serial port**.
  - Loads the **font** for displaying text.

- **Draw Function**:
  - Continuously updates the **sonar visualization**.
  - Calls functions to **draw the sonar grid**, **scanning line**, **detected objects**, and **text information**.

- **Serial Event Function**:
  - Reads incoming **serial data** from the Arduino.
  - Parses the **angle** and **distance** values.

- **Drawing Functions**:
  - **`drawSonar()`**: Draws the sonar grid and angular lines.
  - **`drawLine()`**: Draws the scanning line based on the current angle.
  - **`drawObject()`**: Visualizes detected objects on the sonar.
  - **`drawText()`**: Displays information like angle, distance, and object detection status.

---

## 📝 Usage

1. **Assemble the Hardware** ⚙️ according to the provided circuit diagram.

2. **Upload the Arduino Sketch** 🖲️ to your Arduino board.

3. **Run the Processing Sketch**:
   - Open `sonar.pde` in the Processing IDE.
   - Click the **Run** button ▶️.

4. **Observe the Sonar Visualization** 👀:
   - A window will display the sonar screen.
   - As the servo sweeps, the sonar will display detected objects within range.

---

## ❓ Troubleshooting

- **Serial Port Issues** 🔌:
  - Ensure the serial port in both Arduino and Processing code matches the one your Arduino is connected to.
  - Close the **Arduino Serial Monitor** before running the Processing sketch to avoid port conflicts.

- **No Visualization or Data**:
  - Verify all **wiring connections**.
  - Make sure the **Arduino is sending data** by opening the Serial Monitor.

- **Servo Motor Not Moving** ⚠️:
  - Ensure the servo is properly connected and powered.
  - Some servos require more current than the Arduino can provide. If necessary, use an **external power source** with a common ground.

- **Incorrect Distance Measurements**:
  - Ensure there are no obstacles too close to the sensor.
  - Remember the **HC-SR04** sensor has a range of about **2 cm to 400 cm**.

---

## 📜 Credits

- **Original Project by**: Dejan Nedelkovski, [HowToMechatronics](https://www.howtomechatronics.com/projects/arduino-sonar-project/)
- **Code Translation and Optimization by**: PontoMakers
- **Readme Created by**: [Your Name]

---

🤖 **Feel free to contribute** to this project, submit issues, or fork it to build your version. Enjoy building your Arduino sonar system!

🔧 **Happy Making!** 🔧

---

This version of your README is formatted to be more visually appealing, using emojis to break up the sections and adding some extra flair to make it fun to read. Let me know if there’s anything else you’d like to adjust! 😊
