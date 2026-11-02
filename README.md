<div align="center">

  <!-- Bare-Metal Robotics Bootloader Animated Hero Banner -->
  <a href="https://github.com/azmainofficial/azmainofficial/tree/main/src">
    <img src="assets/boot.svg" alt="AZMAIN-ROBOTICS RTOS Bootloader" width="100%" />
  </a>

  <p align="center">
    <i>This hero banner is rendered from a 2-stage x86 MBR robotics kernel (<code><a href="src/stage1_mbr.asm">src/stage1_mbr.asm</a></code> & <code><a href="src/stage2_payload.asm">src/stage2_payload.asm</a></code>) booted in QEMU via GitHub Actions.</i>
  </p>

  <p align="center">
    <a href="https://azmainofficial.github.io/azmainofficial/">
      <img src="https://img.shields.io/badge/Boot_in_Browser-WebAssembly_v86-238636?style=for-the-badge&logo=webassembly&logoColor=white" alt="Boot in Browser" />
    </a>
  </p>

  <p align="center">
    <a href="https://github.com/azmainofficial"><img src="https://komarev.com/ghpvc/?username=azmainofficial&label=Telemetry+Views&color=58a6ff&style=flat-square" alt="profile views" /></a>
    <a href="https://github.com/azmainofficial?tab=followers"><img src="https://img.shields.io/github/followers/azmainofficial?label=Network&style=flat-square&color=238636" alt="github followers" /></a>
    <img src="https://img.shields.io/badge/Discipline-Robotics%20Engineering-8957e5?style=flat-square" alt="Discipline" />
    <img src="https://img.shields.io/badge/Focus-ROS%202%20%7C%20CAD%20%7C%20Deep%20Learning-0969da?style=flat-square" alt="Focus" />
    <img src="https://img.shields.io/badge/Location-Dhaka%2C%20Bangladesh%20(UTC%2B6)-d29922?style=flat-square" alt="Location" />
  </p>

  <p align="center">
    <a href="mailto:azmiansheikh.nub@gmail.com"><img src="https://img.shields.io/badge/Email-D14836?style=flat-square&logo=gmail&logoColor=white" alt="email" /></a>
    <a href="https://linkedin.com/in/azmain-sheikh"><img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white" alt="linkedin" /></a>
  </p>

</div>

---

### Quick Terminal Card

Inspect my robotics engineering identity card directly from your terminal:

```bash
curl -sL https://raw.githubusercontent.com/azmainofficial/azmainofficial/main/bio.sh | bash
```

---

### /proc/robotics_core & Diagnostics

```gdb
(gdb) target remote /dev/robotics_core
Remote debugging using /dev/robotics_core
(gdb) print *robotics_engineer
$1 = {
    name         = "Azmain Sheikh",
    discipline   = "Robotics Engineering & Autonomous Systems",
    frameworks   = {"ROS", "ROS 2 Humble", "Micro-ROS", "RViz", "Gazebo"},
    perception   = {"Computer Vision", "OpenCV", "Deep Learning", "PyTorch"},
    fabrication  = {"Parametric CAD Modeling", "3D Printing (FDM/SLA)", "Rapid Prototyping"},
    embedded_iot = {"C/C++", "STM32", "ESP32", "FreeRTOS", "CAN Bus", "I2C", "SPI", "MQTT"},
    research     = "Neural Network Kinematic Control & Vision-Guided Manipulation"
}
```

---

### Hardware Interfaces & Active ROS 2 Nodes

```bash
azmain@robotics-node:~$ ros2 node list && ls -l /dev/robotics/*
Active Nodes:
  /perception/camera_depth_estimation     [PyTorch / OpenCV - 30 FPS Active]
  /control/trajectory_planner             [Inverse Kinematics - Converged]
  /hardware/can_actuator_bridge           [CAN Bus 1Mbps - All Nodes Online]
  /sensors/imu_fusion_filter              [Extended Kalman Filter - Calibrated]

Connected Hardware Bus:
  /dev/can0          -> Dual Brushless Motor Controllers & Magnetic Encoders
  /dev/ttyUSB0       -> Micro-ROS Hardware Bridge (STM32 / ESP32 Microcontroller)
  /dev/video0        -> Stereo Depth / Global Shutter Computer Vision Sensor
  /dev/i2c-1         -> 9-DOF IMU, Barometer, ToF Distance & Environmental IoT Sensors
  /dev/spi0          -> High-Speed Actuator DAC & Real-Time Position Feedback
```

---

### Robotics & Embedded Engineering Stack

<div align="center">
  <img src="https://skillicons.dev/icons?i=ros,cpp,c,py,pytorch,tensorflow,opencv,linux,arduino,raspberrypi,mysql,git&perline=12" alt="robotics stack" />
</div>

<br/>

| Domain | Technologies & Competencies |
| :--- | :--- |
| **Robotics & Middleware** | ROS, ROS 2 (Humble/Iron), Micro-ROS, URDF/XACRO, Kinematics, SLAM, Nav2, MoveIt |
| **Hardware & Fabrication**| Parametric CAD Modeling, 3D Printing (FDM/Resin SLA), Prototyping, Actuator Sizing |
| **Vision & Neural Networks** | Computer Vision, OpenCV, PyTorch, TensorFlow, Deep Learning for Robotics Perception |
| **Embedded Systems & IoT**| C, C++, STM32, ESP32, FreeRTOS, Bare-Metal Drivers, CAN Bus, I2C, SPI, UART, MQTT |

---

### System Telemetry & Statistics

<div align="center">
  <img height="170" src="https://github-readme-stats-eight-theta.vercel.app/api?username=azmainofficial&show_icons=true&theme=tokyonight&hide_border=true&border_radius=8" alt="github stats"/>
  <img height="170" src="https://streak-stats.demolab.com/?user=azmainofficial&theme=tokyonight&hide_border=true&border_radius=8" alt="streak stats"/>
  <br/><br/>
  <img src="https://github-readme-stats-eight-theta.vercel.app/api/top-langs?username=azmainofficial&layout=compact&theme=tokyonight&hide_border=true&border_radius=8" alt="top languages"/>
</div>

---

### Audio Subsystem

<div align="center">
  <img src="assets/spotify-player.svg" alt="audio subsystem" width="400"/>
</div>

---

### Memory Allocation Matrix

<div align="center">
  <img src="output/github-contribution-grid-snake-dark.svg" alt="contribution snake" width="100%"/>
</div>

---

<div align="center">
  <sub>Engineered with x86 Assembly, ROS 2, and embedded systems. Source code available in <code><a href="src/stage1_mbr.asm">src/stage1_mbr.asm</a></code>.</sub>
</div>
