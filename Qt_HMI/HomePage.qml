import QtQuick 2.15
import QtQuick.Controls 2.15
Item {
   id: homePage
   anchors.fill: parent
   // ================= BACKGROUND ==================
   Image {
       anchors.fill: parent
       source: "qrc:/ivi_car/anhnen.png"
       fillMode: Image.PreserveAspectCrop
   }
   // ============== TOP RIGHT ICONS ==================
   Row {
       spacing: 20
       anchors.top: parent.top
       anchors.right: parent.right
       anchors.topMargin: 25
       anchors.rightMargin: 40
       Image {
           width: 28
           height: 28
           source: wifiManager.isConnected
                   ? "qrc:/ivi_car/wifi-svgrepo-com 2.svg"
                   : "qrc:/ivi_car/wiffinot.png"
       }
       Image { source: "qrc:/ivi_car/mute-svgrepo-com 1.svg"; width: 26; height: 26 }
       Text {
           text: "10:08"
           color: "white"
           font.pixelSize: 26
       }
   }
   // ============== MUSIC COVER ==================
   Rectangle {
       id: musicCover
       width: 230
       height: 230
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.top: parent.top
       anchors.topMargin: 120
       radius: 20
       color: "transparent"
       clip: true
       Image {
           anchors.fill: parent
           fillMode: Image.PreserveAspectCrop
           source: "qrc:/ivi_car/download.png"
       }
   }
   // ============== MUSIC CONTROL ==================
   Row {
       spacing: 80
       anchors.top: musicCover.bottom
       anchors.topMargin: 50
       anchors.horizontalCenter: parent.horizontalCenter
       Image { width: 55; height: 55; source: "qrc:/ivi_car/angles-left-svgrepo-com.svg" }
       Image { width: 65; height: 65; source: "qrc:/ivi_car/play-svgrepo-com.svg" }
       Image { width: 55; height: 55; source: "qrc:/ivi_car/angles-left-svgrepo-com.svg"; mirror: true }
   }
   // ============= APP ICONS BOTTOM ==================
   Row {
       spacing: 60
       anchors.bottom: parent.bottom
       anchors.bottomMargin: 45
       anchors.horizontalCenter: parent.horizontalCenter
       Column {
           spacing: 5
           Image { source: "qrc:/ivi_car/media-color-2-music-album-svgrepo-com.svg"; width: 70; height: 70 }
           Text { text: "Music"; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
       }
       Column {
           spacing: 5
           Image { source: "qrc:/ivi_car/maps-gps-svgrepo-com.svg"; width: 70; height: 70 }
           Text { text: "Maps"; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
       }
       Column {
           spacing: 5
           Image { source: "qrc:/ivi_car/bluetooth-square-svgrepo-com 1.svg"; width: 70; height: 70 }
           Text { text: "Bluetooth"; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
       }
       Column {
           spacing: 5
           Image { source: "qrc:/ivi_car/chrome-color-svgrepo-com.svg"; width: 70; height: 70 }
           Text { text: "Browser"; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
       }
       Column {
           spacing: 5
           Image { source: "qrc:/ivi_car/phone-calling.svg"; width: 70; height: 70 }
           Text { text: "Phone"; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
       }
       Column {
           spacing: 5
           Image { source: "qrc:/ivi_car/youtube-color-svgrepo-com.svg"; width: 70; height: 70 }
           Text { text: "YouTube"; color: "white"; anchors.horizontalCenter: parent.horizontalCenter }
       }
   }
}
