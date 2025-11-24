import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1712
    height: 633
    visible: true
    title: qsTr("ClusterHMI")
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height

    ClusterHMI {  // Nhúng component
        anchors.fill: parent
       }
}
