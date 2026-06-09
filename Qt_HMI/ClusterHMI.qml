import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: clusterhmi
    width: 1712
    height: 633

    // Property để quản lý trạng thái khởi động
    property bool startupCompleted: false
    property real currentSpeed: 0
    property real currentRpm: 0
    property real currentFuel: 100 // Bắt đầu từ 100% (đầy bình)

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/cluster_hmi_img/bg.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: engine_temperature
        source: "qrc:/cluster_hmi_img/engine_temperature.png"
        anchors.left: background.left
        anchors.leftMargin: 30
        anchors.bottom: background.bottom
        anchors.bottomMargin: 60
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: tachometer
        source: "qrc:/cluster_hmi_img/tachometer.png"
        anchors.left: background.left
        anchors.leftMargin: 160
        anchors.bottom: background.bottom
        anchors.bottomMargin: 70
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: fuelmeter
        source: "qrc:/cluster_hmi_img/fuelmeter.png"
        anchors.right: background.right
        anchors.rightMargin: 30
        anchors.bottom: background.bottom
        anchors.bottomMargin: 60
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: speedometer
        source: "qrc:/cluster_hmi_img/speedometer.png"
        anchors.right: background.right
        anchors.rightMargin: 160
        anchors.bottom: background.bottom
        anchors.bottomMargin: 70
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: map
        source: "qrc:/cluster_hmi_img/map.png"
        anchors.horizontalCenter: background.horizontalCenter
        anchors.bottom: background.bottom
        anchors.bottomMargin: 200
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: arrow_left
        opacity: 0
        source: "qrc:/cluster_hmi_img/icon/arrow_left.png"
        anchors.left: background.left
        anchors.leftMargin: 500
        anchors.top: background.top
        anchors.topMargin: 45
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: arrow_right
        opacity: 0
        source: "qrc:/cluster_hmi_img/icon/arrow_right.png"
        anchors.right: background.right
        anchors.rightMargin: 500
        anchors.top: background.top
        anchors.topMargin: 45
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: oil_pressure_warning
        source: "qrc:/cluster_hmi_img/icon/oil_pressure_warning.png"
        anchors.left: background.left
        anchors.leftMargin: 550
        anchors.bottom: background.bottom
        anchors.bottomMargin: 35
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: battery_charge_warning
        source: "qrc:/cluster_hmi_img/icon/battery_charge_warning.png"
        anchors.left: background.left
        anchors.leftMargin: 660
        anchors.bottom: background.bottom
        anchors.bottomMargin: 35
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: tire_pressure_warning
        source: "qrc:/cluster_hmi_img/icon/tire_pressure_warning.png"
        anchors.left: background.left
        anchors.leftMargin: 770
        anchors.bottom: background.bottom
        anchors.bottomMargin: 30
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: headlight_low_beam
        source: "qrc:/cluster_hmi_img/icon/headlight_low_beam.png"
        anchors.right: background.right
        anchors.rightMargin: 550
        anchors.bottom: background.bottom
        anchors.bottomMargin: 35
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: general_warning
        source: "qrc:/cluster_hmi_img/icon/general_warning.png"
        anchors.right: background.right
        anchors.rightMargin: 660
        anchors.bottom: background.bottom
        anchors.bottomMargin: 35
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: check_engine
        source: "qrc:/cluster_hmi_img/icon/check_engine.png"
        anchors.right: background.right
        anchors.rightMargin: 750
        anchors.bottom: background.bottom
        anchors.bottomMargin: 32
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: seatbelt_warning
        source: "qrc:/cluster_hmi_img/icon/seatbelt_warning.png"
        anchors.horizontalCenter: background.horizontalCenter
        anchors.bottom: background.bottom
        anchors.bottomMargin: 140
        fillMode: Image.PreserveAspectFit
    }

    RowLayout {
        anchors.horizontalCenter: background.horizontalCenter
        anchors.top: background.top
        anchors.topMargin: 20
        spacing: 10

        Image {
            id: wireless_signal
            source: "qrc:/cluster_hmi_img/icon/wireless_signal.png"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            id: myfrequencytext
            text: "954 kHz"
            font.pixelSize: 24
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignBottom
        }
    }

    RowLayout {
        anchors.left: background.left
        anchors.leftMargin: 600
        anchors.top: background.top
        anchors.topMargin: 100
        spacing: 10

        Image {
            id: fuel_station
            source: "qrc:/cluster_hmi_img/icon/fuel_station.png"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            id: myfuelstationtext
            text: "570 mi"
            font.pixelSize: 24
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignBottom
        }
    }

    RowLayout {
        anchors.right: background.right
        anchors.rightMargin: 600
        anchors.top: background.top
        anchors.topMargin: 100
        spacing: 10

        Image {
            id: network_connection

            source: wifiManager.isConnected
                    ? "qrc:/ivi_car/wifi-svgrepo-com 2.svg"
                    : "qrc:/cluster_hmi_img/icon/network_connection.png"

            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            id: mynetworkconnectiontext
            text: wifiManager.isConnected ? wifiManager.ssid : "NAV"
            font.pixelSize: 24
            color: "white"
            font.bold: true
            Layout.alignment: Qt.AlignBottom
        }

    }

    Text {
        id: myclock
        text: Qt.formatDateTime(new Date(), "h:mm AP")
        font.pixelSize: 24
        color: "white"
        font.bold: true
        anchors.left: background.left
        anchors.leftMargin: 630
        anchors.bottom: background.bottom
        anchors.bottomMargin: 150
    }

    Timer {
        id: timeUpdater
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            myclock.text = Qt.formatDateTime(new Date(), "h:mm AP");
        }
    }

    Text {
        id: mytemperature
        text: "0.0 °C"
        font.pixelSize: 24
        color: "white"
        font.bold: true
        anchors.right: background.right
        anchors.rightMargin: 630
        anchors.bottom: background.bottom
        anchors.bottomMargin: 150
    }

    //---------------------------------------------------------------

    Image {
        id: speedometerneedle
        width: 400
        source: "qrc:/cluster_hmi_img/speedometerneedle.png"
        anchors.horizontalCenter: speedometer.horizontalCenter
        anchors.verticalCenter: speedometer.verticalCenter
        fillMode: Image.PreserveAspectFit
        transformOrigin: Item.Center
        rotation: -182 // Vị trí bắt đầu
    }

    Image {
        id: tachometerneedle
        width: 400
        source: "qrc:/cluster_hmi_img/speedometerneedle.png"
        anchors.horizontalCenter: tachometer.horizontalCenter
        anchors.verticalCenter: tachometer.verticalCenter
        fillMode: Image.PreserveAspectFit
        transformOrigin: Item.Center
        rotation: -182 // Vị trí bắt đầu
    }

    Image {
        id: fuelmeterneedle
        width: 250
        source: "qrc:/cluster_hmi_img/speedometerneedle.png"
        anchors.right: background.right
        anchors.rightMargin: 45
        anchors.bottom: background.bottom
        anchors.bottomMargin: 50
        fillMode: Image.PreserveAspectFit
        transformOrigin: Item.Center
        rotation: 150 // Vị trí bắt đầu (đầy bình)
    }

    Image {
        id: enginetemperatureneedle
        width: 250
        source: "qrc:/cluster_hmi_img/speedometerneedle.png"
        anchors.left: background.left
        anchors.leftMargin: 40
        anchors.bottom: background.bottom
        anchors.bottomMargin: 25
        fillMode: Image.PreserveAspectFit
        transformOrigin: Item.Center
        rotation: -150 // Vị trí bắt đầu
    }

    // Animation khởi động - chỉ chạy 1 lần khi bắt đầu
    SequentialAnimation {
        id: startupAnimation
        running: true
        loops: 1

        ParallelAnimation {
            NumberAnimation {
                target: speedometerneedle
                property: "rotation"
                from: -182
                to: 120
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: tachometerneedle
                property: "rotation"
                from: -182
                to: 120
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: fuelmeterneedle
                property: "rotation"
                from: 150
                to: 40
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: enginetemperatureneedle
                property: "rotation"
                from: -150
                to: -20
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: speedometerneedle
                property: "rotation"
                from: 120
                to: -182
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: tachometerneedle
                property: "rotation"
                from: 120
                to: -182
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: fuelmeterneedle
                property: "rotation"
                from: 40
                to: 150
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: enginetemperatureneedle
                property: "rotation"
                from: -20
                to: -150
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }

        onFinished: {
            startupCompleted = true
            console.log("Startup animation completed")
        }
    }

    // Timer nhấp nháy cho đèn báo
    Timer {
        id: blinkTimer
        interval: 500
        running: wifiManager.btn === 1 || wifiManager.btn1 === 1
        repeat: true

        onTriggered: {
            if (wifiManager.btn === 1)
                arrow_left.opacity = arrow_left.opacity === 1 ? 0 : 1
            else
                arrow_left.opacity = 0

            if (wifiManager.btn1 === 1)
                arrow_right.opacity = arrow_right.opacity === 1 ? 0 : 1
            else
                arrow_right.opacity = 0
        }
    }

    // Hàm cập nhật kim nhiệt độ động cơ dựa trên tốc độ
    function updateEngineTemperatureNeedle(speed) {
        // Kim nhiệt độ động cơ tăng/giảm theo tốc độ
        // Tốc độ càng cao -> kim nhiệt độ càng cao
        var engineTempValue = Math.min(120, Math.max(0, speed * 0.6)); // Giới hạn 0-120°C

        // Cập nhật kim nhiệt độ (-150 đến -20 tương ứng 0-120°C)
        var tempRotation = -150 + (engineTempValue / 120 * 130);
        enginetemperatureneedle.rotation = tempRotation;
    }

    // Hàm cập nhật kim xăng dựa trên tốc độ
    function updateFuelConsumption(speed) {
        if (speed > 0) {
            // Khi có tốc độ, xăng giảm dần
            var fuelConsumption = speed * 0.001; // Tốc độ càng cao, xăng giảm càng nhanh
            currentFuel = Math.max(0, currentFuel - fuelConsumption);
        }

        // Cập nhật kim xăng (150 đến 40 tương ứng 100%-0%)
        var fuelRotation = 150 - (currentFuel / 100 * 110);
        fuelmeterneedle.rotation = fuelRotation;
    }

    // Kết nối với wifiManager
    Connections {
        target: wifiManager
        onDataChanged: {
            console.log("Data changed - btn:", wifiManager.btn, "btn1:", wifiManager.btn1, "btn2:", wifiManager.btn2, "p:", wifiManager.p, "temperature:", wifiManager.temperature)

            // Chỉ cập nhật kim sau khi animation khởi động kết thúc
            if (startupCompleted) {
                var speedValue = wifiManager.p;

                // BTN2 -> điều khiển kim
                if (wifiManager.btn2 === 1) {
                    // Chế độ RPM
                    currentRpm = Math.min(200, Math.max(0, speedValue));
                    tachometerneedle.rotation = -182 + (currentRpm / 200 * 302);
                } else {
                    // Chế độ Speed
                    currentSpeed = Math.min(200, Math.max(0, speedValue));
                    speedometerneedle.rotation = -182 + (currentSpeed / 200 * 302);

                    // Cập nhật kim nhiệt độ động cơ và xăng dựa trên tốc độ
                    updateEngineTemperatureNeedle(currentSpeed);
                    updateFuelConsumption(currentSpeed);
                }
            }

            // BTN / BTN1 -> nhấp nháy
            if (wifiManager.btn === 0) arrow_left.opacity = 0
            if (wifiManager.btn1 === 0) arrow_right.opacity = 0

            // Cập nhật nhiệt độ từ wifiManager (giữ nguyên như cũ)
            mytemperature.text = wifiManager.temperature.toFixed(1) + " °C"
        }
    }

    // Timer reset xăng về đầy bình (ví dụ mỗi 30 giây cho demo)
    Timer {
        id: fuelResetTimer
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            if (startupCompleted && currentFuel < 10) {
                currentFuel = 100;
                fuelmeterneedle.rotation = 150; // Về vị trí đầy bình
                console.log("Fuel reset to full");
            }
        }
    }
}
