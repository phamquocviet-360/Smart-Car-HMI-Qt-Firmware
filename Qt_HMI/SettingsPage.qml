import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: settingsPage
    width: 1280
    height: 720

    // ===================== STATE =====================
    property string currentMode: "Day"
    property string currentLang: "English"   // mặc định

    // ===================== FUNCTION ĐỔI NGÔN NGỮ =====================
    function getText(key) {
        if (currentLang === "Việt Nam") {
            switch (key) {
            case "settings": return "Cài đặt"
            case "dayNight": return "Chế độ Ngày/Đêm"
            case "day": return "Ngày"
            case "night": return "Đêm"
            case "language": return "Ngôn Ngữ"
            default: return key
            }
        }
        // English default
        switch (key) {
        case "settings": return "Settings"
        case "dayNight": return "Day/Night Mode"
        case "day": return "Day"
        case "night": return "Night"
        case "language": return "Language"
        default: return key
        }
    }

    Image {
        anchors.fill: parent
        source: (settingsPage.currentMode === "Day")
                ? "qrc:/ivi_car/daycar.jpg"
                : "qrc:/ivi_car/nightcar.jpeg"
        fillMode: Image.PreserveAspectCrop
    }


    Text {
        text: getText("settings")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 36
        anchors.leftMargin: 72
        color: "white"
        font.pixelSize: 44
        font.bold: true
    }

    // ======================= TOP BOX =========================
    Rectangle {
        id: topBox
        width: parent.width - 360
        height: 220
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 110
        color: "#cfe6ff"
        radius: 28

        Text {
            text: getText("dayNight")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 34
            anchors.topMargin: 20
            color: "#0b0b0b"
            font.pixelSize: 30
            font.bold: true
        }

        Row {
            id: dayNightRow
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 75
            spacing: 120

            // ========= COMPONENT CARD ==========
            Component {
                id: modeCardComponent

                Item {
                    width: 180
                    height: 180

                    Image {
                        id: frame
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -25
                        anchors.horizontalCenterOffset: -40
                        width: 140
                        height: 140

                        source: (settingsPage.currentMode === realValue)
                                ? "qrc:/ivi_car/Rectangle 10.svg"
                                : "qrc:/ivi_car/Rectangle 11.svg"
                    }

                    Image {
                        anchors.centerIn: frame
                        anchors.verticalCenterOffset: -25
                        source: iconSource
                        width: 65; height: 65
                    }

                    Text {
                        text: settingsPage.getText(realValue.toLowerCase())
                        anchors.horizontalCenter: frame.horizontalCenter
                        anchors.bottom: frame.bottom
                        anchors.bottomMargin: 14
                        color: "#000"
                        font.pixelSize: 26
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            settingsPage.currentMode = realValue
                            console.log("Selected Mode:", realValue)
                        }
                    }
                }
            }

            Loader {
                sourceComponent: modeCardComponent
                property string iconSource: "qrc:/ivi_car/holidays-vacation-summer-sun-sunny-hot-svgrepo-com.svg"
                property string realValue: "Day"
            }

            Loader {
                sourceComponent: modeCardComponent
                property string iconSource: "qrc:/ivi_car/night-svgrepo-com.svg"
                property string realValue: "Night"
            }
        }
    }

    Rectangle { width: 1; height: 18; anchors.top: topBox.bottom; color: "transparent" }

    // ====================== BOTTOM BOX ========================
    Rectangle {
        id: bottomBox
        width: topBox.width
        height: 180
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: topBox.bottom
        anchors.topMargin: 28
        color: "#cfe6ff"
        radius: 28

        Text {
            text: getText("language")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 34
            anchors.topMargin: 18
            color: "#0b0b0b"
            font.pixelSize: 30
            font.bold: true
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 80
            anchors.verticalCenterOffset: 30

            // ======= COMPONENT LANGUAGE BUTTON ========
            Component {
                id: langButton

                Item {
                    width: 280; height: 80

                    Image {
                        anchors.fill: parent
                        source: (settingsPage.currentLang === langReal)
                                ? "qrc:/ivi_car/Rectangle 14.svg"
                                : "qrc:/ivi_car/Rectangle 13.svg"
                    }

                    Text {
                        text: langReal
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 28
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            settingsPage.currentLang = langReal
                            console.log("Choose:", langReal)
                        }
                    }
                }
            }

            Loader { sourceComponent: langButton; property string langReal: "English" }
            Loader { sourceComponent: langButton; property string langReal: "Việt Nam" }
        }
    }
}
