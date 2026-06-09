import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    width: 1280
    height: 720
    visible: true
    color: "#1d1d1d"

    property bool splashDone: false

    Loader {
        id: pageLoader
        anchors.fill: parent
        anchors.leftMargin: splashDone ? 110 : 0
        source: "SplashScreen.qml"

        // NHẬN TÍN HIỆU SPLASH KẾT THÚC
        onLoaded: {
            if (item && item.finished) {
                item.finished.connect(function() {
                    splashDone = true
                    pageLoader.source = "HomePage.qml"
                })
            }
        }
    }

    // Sidebar
    Rectangle {
        id: leftBar
        visible: splashDone
        width: 110
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "transparent"

        Image {
            anchors.fill: parent
            source: "qrc:/ivi_car/Rectangle 1.png"
            fillMode: Image.PreserveAspectFit
        }

        Column {
            anchors.fill: parent

            Item {
                width: parent.width
                height: parent.height / 3

                Image {
                    anchors.centerIn: parent
                    width: 55
                    height: 55
                    source: "qrc:/ivi_car/website-home-page-svgrepo-com.svg"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: pageLoader.source = "HomePage.qml"
                }
                Image {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 4
                    source: "qrc:/ivi_car/Rectangle 2.png"
                }
            }

            Item {
                width: parent.width
                height: parent.height / 3

                Image {
                    anchors.centerIn: parent
                    width: 55
                    height: 55
                    source: "qrc:/ivi_car/holidays-vacation-summer-sun-sunny-hot-svgrepo-com.svg"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: pageLoader.source = "SettingsPage.qml"
                }
                Image {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 4
                    source: "qrc:/ivi_car/Rectangle 2.png"
                }
            }

            Item {
                width: parent.width
                height: parent.height / 3

                Image {
                    anchors.centerIn: parent
                    width: 55
                    height: 55
                    source: "qrc:/ivi_car/wifi-svgrepo-com.svg"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: pageLoader.source = "WifiPage.qml"
                }
            }
        }
    }
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
}
