# Air Quality Monitoring System 🌬️

This project is an **Air Quality Monitoring System** combining hardware and software to monitor air pollution in real-time. It uses an **ESP32** microcontroller with multiple gas sensors (MQ6, MQ135), a particulate matter (PM) sensor, buzzer, and LED indicators — along with a **mobile app built with Flutter** for live monitoring and alerts.

---

## 📋 Project Overview

- **Hardware**: ESP32-based sensor setup for detecting gases and particulate matter in the environment.
- **Mobile App**: Flutter app (Dart) to visualize sensor data remotely, receive alerts, and track air quality over time.

---

## 🔧 Hardware Components

- **ESP32** development board
- **MQ6 Gas Sensor** (detects LPG, propane, methane)
- **MQ135 Gas Sensor** (measures air quality and harmful gases)
- **PM Sensor** (Particulate Matter sensor for dust and pollution)
- **Buzzer** for audible alerts
- **LEDs** for visual status indicators
- **Power supply and connecting wires**

---

## 📱 Software Components

- **ESP32 Firmware**: Written in Arduino IDE or PlatformIO, it collects sensor data and triggers alerts.
- **Flutter Mobile App**: Developed using Dart, provides:
  - Real-time visualization of air quality data
  - Push notifications for alert conditions
  - Historical data tracking and analytics

---

## ⚙️ Features

- Continuous, real-time air quality monitoring
- Multi-gas and particulate matter detection
- Audible and visual alerts (buzzer and LEDs)
- Mobile app for remote monitoring and notifications
- Easy to customize and extend

---

## 📈 How It Works

1. ESP32 reads sensor data and evaluates air quality.
2. When pollutant levels exceed safe limits, buzzer and LEDs alert users locally.
3. Sensor data is sent wirelessly (e.g., via Wi-Fi or Bluetooth) to the Flutter app.
4. The app displays live data, logs historical trends, and sends push alerts.

---

## 🔌 Setup Instructions

### Hardware

1. Connect sensors, buzzer, and LEDs to the ESP32 based on the wiring schematic.
2. Upload the firmware code to the ESP32.
3. Power on the system and verify sensor readings on the serial monitor.

### Mobile App

1. Clone the Flutter app repository.
2. Run `flutter pub get` to install dependencies.
3. Launch the app on your Android/iOS device or emulator.
4. Ensure your device is connected to the same network as the ESP32 (if using Wi-Fi communication).

---

## 📂 Repository Contents

- `hardware/` — ESP32 firmware source code and wiring diagrams
- `flutter-app/` — Flutter mobile app source code
- `README.md` — This file

---

## 👨‍💻 Author

**Martin Mugisha**  
[GitHub: martin-mugisha](https://github.com/martin-mugisha)

---

## 📄 License

This project is licensed under the MIT License.

---

## 🤝 Acknowledgments

- ESP32 and Arduino communities
- Flutter and Dart open-source contributors
- Sensor manufacturers for detailed datasheets and tutorials

---

If you want, I can also help draft the Flutter app’s README or provide example code snippets!
