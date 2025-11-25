import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: clusterhmi
    width: 1712
    height: 633

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
        anchors.verticalCenter: background.verticalCenter
        width: 400
        height: 200
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: arrow_left
        source: "qrc:/cluster_hmi_img/icon/arrow_left.png"
        anchors.left: background.left
        anchors.leftMargin: 500
        anchors.top: background.top
        anchors.topMargin: 45
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: arrow_right
        source: "qrc:/cluster_hmi_img/icon/arrow_right.png"
        anchors.right: background.right
        anchors.rightMargin: 500
        anchors.top: background.top
        anchors.topMargin: 45
        fillMode: Image.PreserveAspectFit
    }

    RowLayout {
        id: warningIconsRow
        anchors.horizontalCenter: background.horizontalCenter
        anchors.bottom: background.bottom
        anchors.bottomMargin: 25
        spacing: 40

        Image {
            source: "qrc:/cluster_hmi_img/icon/oil_pressure_warning.png"
            width: 55; height: 55
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/cluster_hmi_img/icon/battery_charge_warning.png"
            width: 55; height: 55
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/cluster_hmi_img/icon/tire_pressure_warning.png"
            width: 55; height: 55
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/cluster_hmi_img/icon/headlight_low_beam.png"
            width: 55; height: 55
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/cluster_hmi_img/icon/general_warning.png"
            width: 55; height: 55
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/cluster_hmi_img/icon/check_engine.png"
            width: 55; height: 55
            fillMode: Image.PreserveAspectFit
        }
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
            source: "qrc:/cluster_hmi_img/icon/network_connection.png"
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            id: mynetworkconnectiontext
            text: "NAV"
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
        text: "24 °C"
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
    }

    Image {
        id: tachometerneedle
        width: 400
        source: "qrc:/cluster_hmi_img/speedometerneedle.png"
        anchors.horizontalCenter: tachometer.horizontalCenter
        anchors.verticalCenter: tachometer.verticalCenter
        fillMode: Image.PreserveAspectFit
        transformOrigin: Item.Center
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
    }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        ParallelAnimation {
            NumberAnimation {
                target: speedometerneedle
                property: "rotation"
                from: -182
                to: 120
                duration: 4000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: tachometerneedle
                property: "rotation"
                from: -182
                to: 120
                duration: 4000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: fuelmeterneedle
                property: "rotation"
                from: 150
                to: 40
                duration: 4000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: enginetemperatureneedle
                property: "rotation"
                from: -150
                to: -20
                duration: 4000
                easing.type: Easing.InOutQuad
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: speedometerneedle
                property: "rotation"
                from: 120
                to: -182
                duration: 4000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: tachometerneedle
                property: "rotation"
                from: 120
                to: -182
                duration: 4000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: fuelmeterneedle
                property: "rotation"
                from: 40
                to: 150
                duration: 4000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: enginetemperatureneedle
                property: "rotation"
                from: -20
                to: -150
                duration: 4000
                easing.type: Easing.InOutQuad
            }
        }
    }

//---------------------------------------------------------------

}
