import QtQuick 2.15

Rectangle {
    id: root
    width: 1280
    height: 720
    color: "black"

    signal finished()   // báo hiệu hết splash

    Image {
        id: logo
        anchors.centerIn: parent
        source: "qrc:/ivi_car/LogoIntro.png"
        opacity: 0
        width: parent.width * 0.3
        fillMode: Image.PreserveAspectFit

        SequentialAnimation on opacity {
            NumberAnimation { to: 1; duration: 1500 }
            PauseAnimation { duration: 1000 }
            NumberAnimation { to: 0; duration: 1200 }

            onStopped: root.finished()
        }
    }
}
