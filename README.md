# Smart-Car-HMI-Qt-Firmware

## Giới thiệu

Smart-Car-HMI-Qt-Firmware là dự án mô phỏng hệ thống bảng đồng hồ điện tử (Digital Instrument Cluster) trên ô tô, kết hợp giữa phần mềm giao diện người dùng (HMI) và firmware nhúng.

Dự án được phát triển theo mô hình phân tách giữa:

* Firmware điều khiển và xử lý dữ liệu
* Giao diện HMI hiển thị thông tin xe
* Ứng dụng Qt phục vụ mô phỏng và tương tác người dùng

## Chức năng chính

* Hiển thị tốc độ xe theo thời gian thực
* Hiển thị vòng tua động cơ (RPM)
* Hiển thị mức nhiên liệu
* Hiển thị nhiệt độ động cơ
* Hiển thị các đèn cảnh báo:

  * Check Engine
  * Seat Belt Warning
  * Tire Pressure Warning
  * Battery Warning
  * Oil Pressure Warning
* Mô phỏng bản đồ và các thông tin điều hướng
* Kết nối và trao đổi dữ liệu giữa firmware và giao diện HMI

## Công nghệ sử dụng

### Embedded

* C/C++
* PlatformIO
* ESP32
* UART Communication

### Desktop Application

* Qt Framework
* Qt Quick
* QML
* C++

### Development Tools

* Visual Studio Code
* Qt Creator
* Git
* GitHub

## Kiến trúc hệ thống


+--------------------+
|      Firmware      |
|      ESP32         |
+---------+----------+
          |
          | UART
          |
+---------v----------+
|     Qt HMI App     |
|   Data Processing  |
+---------+----------+
          |
          |
+---------v----------+
|  Digital Cluster   |
|      Qt/QML        |
+--------------------+
```

## Kết quả đạt được

* Xây dựng thành công giao diện bảng đồng hồ điện tử bằng Qt/QML.
* Mô phỏng các thông số vận hành cơ bản của xe.
* Tích hợp firmware và giao diện hiển thị.
* Áp dụng kiến thức về Embedded Systems, HMI Development và UART Communication.

