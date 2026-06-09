import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.VirtualKeyboard 2.1

Item {
    id: wifiPage
    width: 1280
    height: 720
    property string connectedSSID: "" // SSID đang kết nối
    property bool hasConnection: false // Kiểm tra đã có kết nối chưa

    Image {
        anchors.fill: parent
        source: "qrc:/ivi_car/anhnen.png"
        fillMode: Image.PreserveAspectCrop
    }

    Text {
        text: "Available Networks"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 80
        anchors.topMargin: 40
        color: "white"
        font.pixelSize: 44
        font.bold: true
    }

    // Hiển thị WiFi đang kết nối
    Rectangle {
        id: connectedWifiDisplay
        width: 1050
        height: 120
        radius: 35
        anchors.top: parent.top
        anchors.topMargin: 120
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        visible: connectedSSID !== "" && hasConnection

        Image {
            anchors.fill: parent
            source: "qrc:/ivi_car/Rectangle 4.svg"
            fillMode: Image.PreserveAspectFit
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 35
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Image {
                source: "qrc:/ivi_car/ticktick.svg"
                width: 40; height: 40
                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                Text {
                    text: "Connected to:"
                    color: "#0b2b70"
                    font.pixelSize: 22
                }

                Text {
                    text: connectedSSID
                    color: "#0b2b70"
                    font.pixelSize: 34
                    font.bold: true
                }
            }
        }

        Rectangle {
            width: 140
            height: 45
            radius: 22
            color: "#ff3b30"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter

            Row {
                anchors.centerIn: parent
                spacing: 8
                Text {
                    text: "Disconnect"
                    font.pixelSize: 22
                    font.bold: true
                    color: "white"
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: wifiManager.disconnectWifi()
            }
        }
    }

    Row {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 80
        anchors.topMargin: 35
        spacing: 15
        Text {
            text: "Show WiFi"
            color: "white"
            font.pixelSize: 24
            anchors.verticalCenter: parent.verticalCenter
        }
        Switch {
            id: wifiToggle
            checked: true
            onCheckedChanged: wifiFlickable.visible = checked
            indicator: Rectangle {
                implicitWidth: 90
                implicitHeight: 44
                radius: 30
                color: wifiToggle.checked ? "white" : "#444"
                Rectangle {
                    width: 38
                    height: 38
                    radius: 19
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: wifiToggle.checked ? undefined : parent.left
                    anchors.right: wifiToggle.checked ? parent.right : undefined
                    anchors.margins: 3
                    color: wifiToggle.checked ? "#1a73e8" : "white"
                }
            }
        }
    }

    // =============================
    // LIST WIFI
    // =============================
    Flickable {
        id: wifiFlickable
        anchors.top: connectedSSID !== "" && hasConnection ? connectedWifiDisplay.bottom : parent.top
        anchors.topMargin: connectedSSID !== "" && hasConnection ? 20 : 120
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentWidth: wifiColumn.width
        contentHeight: wifiColumn.height
        clip: true
        visible: wifiToggle.checked

        Column {
            id: wifiColumn
            width: parent.width
            spacing: 22

            Repeater {
                model: wifiList
                Rectangle {
                    width: 1050
                    height: connectedSSID === name ? 150 : 110
                    radius: 35
                    color: "transparent"
                    Image {
                        anchors.fill: parent
                        source: "qrc:/ivi_car/Rectangle 4.svg"
                        fillMode: Image.PreserveAspectFit
                    }
                    Column {
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: -2
                        Row { // ✅ DÒNG CHỨA TÊN WIFI + ICON LOCK
                            spacing: 6
                            Text {
                                text: name
                                color: "#0b2b70"
                                font.pixelSize: 34
                                font.bold: true
                            }
                            Image {
                                source: "qrc:/ivi_car/lock-svgrepo-com (1).svg"
                                width: 20
                                height: 20
                                anchors.verticalCenter: parent.verticalCenter
                                // ✅ CHỈ HIỆN khi có mật khẩu & chưa kết nối
                                visible: locked && connectedSSID !== name
                            }
                        }
                        Text {
                            text: "Signal " + signal
                            color: "#0b2b70"
                            font.pixelSize: 22
                        }
                    }
                    Image {
                        source: "qrc:/ivi_car/ticktick.svg"
                        visible: connectedSSID === name
                        width: 40; height: 40
                        anchors.right: parent.right
                        anchors.rightMargin: 160
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 8
                    }
                    Rectangle {
                        visible: connectedSSID === name
                        width: 140
                        height: 45
                        radius: 22
                        color: "#ff3b30"
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 8
                        Row {
                            anchors.centerIn: parent
                            spacing: 8
                            Text {
                                text: "Disconnect"
                                font.pixelSize: 22
                                font.bold: true
                                color: "white"
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: wifiManager.disconnectWifi()
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        enabled: connectedSSID !== name
                        onClicked: {
                            selectedSSID.text = name
                            passInput.text = ""
                            passwordPopup.open()
                        }
                    }
                }
            }
        }
    }

    // ----------------------------------
    // POPUP PASSWORD
    Popup {
        id: passwordPopup
        modal: true
        width: 500
        height: 350
        // Căn giữa ngang, lên sát trên
        x: (wifiPage.width - width) / 2
        y: 0 // sát đỉnh màn hình
        background: Rectangle { color: "#1e1e1e"; radius: 20 }
        onOpened: {
            passInput.forceActiveFocus()
            Qt.inputMethod.visible = true
        }
        onClosed: {
            Qt.inputMethod.visible = false
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20 // khoảng cách nhỏ để không chạm sát viền
            spacing: 20
            Text { id: selectedSSID; color: "white"; font.pixelSize: 26 }
            TextField {
                id: passInput
                width: 380
                height: 50
                echoMode: TextInput.Password
                placeholderText: "Password..."
                background: Rectangle { color: "#333"; radius: 12 }
            }
            Button {
                text: "Connect"
                width: 200
                height: 50
                onClicked: {
                    wifiManager.connectWifi(selectedSSID.text, passInput.text)
                    passwordPopup.close()
                }
            }
        }
    }

    // =============================
    // WIFI EVENTS
    // =============================
    ListModel { id: wifiList }

    Connections {
        target: wifiManager
        onWifiScanned: {
            // Nếu đã có kết nối, không cần thêm vào danh sách
            if (hasConnection && connectedSSID !== "") return;

            var found = -1
            for (var i = 0; i < wifiList.count; i++)
                if (wifiList.get(i).name === ssid)
                    found = i
            if (found === -1)
                wifiList.append({"name": ssid, "signal": signal+"", "locked": locked})
            else
                wifiList.setProperty(found, "signal", signal+"")
        }
    }

    Connections {
        target: wifiManager
        onWifiConnected: {
            if (success) {
                connectedSSID = ssid
                hasConnection = true
                wifiList.clear() // Xóa danh sách khi đã kết nối
                toast.text = "Connected to " + ssid
            } else {
                toast.text = "Connect failed!"
            }
            toast.open()
        }
    }

    Connections {
        target: wifiManager
        onWifiDisconnected: {
            connectedSSID = ""
            hasConnection = false
            // Khi ngắt kết nối, load lại danh sách WiFi
            wifiManager.requestScan()
            toast.text = "Disconnected"
            toast.open()
        }
    }

    // Kết nối để kiểm tra trạng thái WiFi khi khởi động
    Connections {
        target: wifiManager
        onCurrentConnectionChanged: {
            connectedSSID = ssid
            hasConnection = ssid !== ""
            if (hasConnection) {
                wifiList.clear() // Xóa danh sách nếu đã có kết nối
            } else {
                wifiManager.requestScan() // Quét WiFi nếu chưa có kết nối
            }
        }
    }

    Popup {
        id: toast
        width: 400
        height: 100
        y: parent.height - 150
        x: (parent.width - width) / 2
        background: Rectangle { color: "#333"; radius: 20 }
        Text {
            id: toastText
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 24
        }
        property alias text: toastText.text
        Timer { id: timer; interval: 2500; onTriggered: toast.close() }
        onOpened: timer.start()
    }

    // =============================
    // BÀN PHÍM ẢO
    // =============================
    InputPanel {
        id: virtualKeyboard
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: Qt.inputMethod.visible
        z: 999
    }

    Component.onCompleted: {
        Qt.inputMethod.visible = false
        // Kiểm tra trạng thái kết nối hiện tại khi khởi động
        wifiManager.checkCurrentConnection()

        // Chỉ quét WiFi nếu chưa có kết nối
        if (!hasConnection || connectedSSID === "") {
            wifiManager.requestScan()
        }
    }
}
