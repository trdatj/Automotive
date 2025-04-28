import QtQuick 2.15

Item {
    id: speedometer
    width: 500
    height: 500

    property string meterImage: "" //url đến ảnh mặt đồng hồ
    property string indicatorImage: "" //url đến ảnh kim
    property int angle: 150 // góc xoay kim

    //Mặt đồng hồ
    Image {
        id: meterImageID
        source: speedometer.meterImage
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
    }

    //Kim đồng hồ
    Image {
        id: indicatorID
        source: speedometer.indicatorImage
        width: 182
        height: 20
        anchors.centerIn: parent

        transform: Rotation {
            id: rotationTransform
            origin.x: indicatorID.width * 0.29  // hoặc 0.15 tùy vị trí gốc kim
            origin.y: indicatorID.height / 2 + 10
            angle: speedometer.angle
        }
    }
}
