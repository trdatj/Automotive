import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 1920
    height: 980
    visible: true
    title: qsTr("Nhom 1")

    Item{
        id: content
        width: 1920
        height: 980

        anchors.centerIn: parent
        scale: Math.min(root.width / 1920, root.height / 980) // scale toàn bộ nội dung

        Image {
            id: background
            source: "qrc:/img/Panel.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit

            //Mặt đồng hồ trái
            Speedometer {
                width: 470
                height: 470
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 110

                meterImage: "qrc:/img/speedImg.png"
                indicatorImage: "qrc:/img/Indicator.png"
                angle: 147
            }

            //Mặt đồng hồ phải
            Speedometer {
                width: 470
                height: 470
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 110

                meterImage: "qrc:/img/tachoImg.png"
                indicatorImage: "qrc:/img/Indicator.png"
                angle: 150
            }

            //top  bar
            Speedometer{
                width: 595
                height: 80
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 95
                meterImage: "qrc:/img/Top Bar.png"
            }



            //xi nhan trái
            FunctionIcon{
                id: turnLeftIcon
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30

                //iconImage: "qrc:/icons/icons-left/icon-park-solid_left-two.svg"
                iconImageOff: "qrc:/icons/icons-left/icon-park-solid_left-two.svg"
                iconImageOn: "qrc:/icons/icons-left-checked/icon-park-solid_right-two.svg"
                checked: false
            }

            //xi nhan phải
            FunctionIcon{
                id: turnRightIcon
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 30

                //iconImage: "qrc:/icons/icons-right/icon-park-solid_right-two.svg"
                iconImageOff: "qrc:/icons/icons-right/icon-park-solid_right-two.svg"
                iconImageOn: "qrc:/icons/icons-right-checked/icon-park-solid_right-two.svg"
                checked: false
            }

            //đèn cos
            FunctionIcon{
                id: iconLightCosIcon
                x: 730
                y: 113
                width: 40
                height: 40
                opacity: 0.9
                //iconImage: "qrc:/icons/icons-right/mdi_car-light-high.svg"
                iconImageOff: "qrc:/icons/icons-right/Low_beam_headlights_white.svg"
                iconImageOn: "qrc:/icons/icons-right-checked/mdi_car-light-dimmed-checked.svg"
                checked: false
            }

            //đèn pha
            FunctionIcon{
                id: iconLightPhaIcon
                x: 800
                y: 110
                width: 45
                height: 45
                opacity: 0.9
                //iconImage: "qrc:/icons/icons-right/mdi_car-light-high.svg"
                iconImageOff: "qrc:/icons/icons-right/mdi_car-light-high.svg"
                iconImageOn: "qrc:/icons/icons-right-checked/mdi_car-light-high-checked.svg"
                checked: false
            }

            //đèn hazard
            FunctionIcon{
                id: iconHazardIcon
                x: 850
                y: 110
                width: 45
                height: 45
                opacity: 0.9
                //iconImage: "qrc:/icons/icons-right/mdi_car-light-high.svg"
                iconImageOff: "qrc:/icons/icons-right/hazard-lights.svg"
                iconImageOn: "qrc:/icons/icons-right-checked/output-onlinepngtools.png"
                checked: false

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        iconHazardIcon.checked = !iconHazardIcon.checked

                        if (iconHazardIcon.checked){
                            console.log("Hazard bật");
                            hazardBlinkTimer.start()

                            // Khi bật Hazard, tắt luôn các chế độ xi nhan trái/phải đang chạy riêng lẻ
                            turnLeftIcon.blinking = false
                            turnRightIcon.blinking = false
                            blinkTimerLeft.stop()
                            blinkTimerRight.stop()
                        } else {
                            console.log("Hazard tắt");
                            hazardBlinkTimer.stop()
                            turnLeftIcon.checked = false
                            turnRightIcon.checked = false
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: blinkTimerLeft
        interval: turnLeftIcon.blinkInterval
        running: turnLeftIcon.blinking
        repeat: true
        onTriggered: turnLeftIcon.checked = !turnLeftIcon.checked
    }

    Timer {
        id: blinkTimerRight
        interval: turnRightIcon.blinkInterval
        running: turnRightIcon.blinking
        repeat: true
        onTriggered: turnRightIcon.checked = !turnRightIcon.checked
    }

    Timer {
        id: hazardBlinkTimer
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            turnLeftIcon.checked = !turnLeftIcon.checked
            turnRightIcon.checked = !turnRightIcon.checked
        }
    }


    Connections {
        target: serialReader

        function onSignalChanged(message) {
            console.log("NHẬN SIGNAL RAW:", JSON.stringify(message));

            const cleanMsg = message.trim();
            console.log("SAU TRIM:", JSON.stringify(cleanMsg));

            // Tách dữ liệu
            const parts = cleanMsg.split(":");
            if (parts.length !== 2) {
                console.log("MESSAGE KHÔNG HỢP LỆ:", cleanMsg);
                return;
            }

            const device = parts[0];
            const status = parts[1];

            // Nếu Hazard đang bật thì bỏ qua xi nhan trái/phải
            if (iconHazardIcon.checked && (device === "TURN_LEFT" || device === "TURN_RIGHT")){
                console.log("BỎ QUA xi nhan riêng vì Hazard đang bật");
                return;
            }

            switch (device) {
            case "TURN_LEFT":
                if (status === "ON") {
                    console.log("Xi nhan trái bật");
                    turnLeftIcon.blinking = true;
                    turnLeftIcon.checked = true;
                } else {
                    console.log("Xi nhan trái tắt");
                    turnLeftIcon.blinking = false;
                    turnLeftIcon.checked = false;
                }
                break;

            case "TURN_RIGHT":
                if (status === "ON") {
                    console.log("Xi nhan phải bật");
                    turnRightIcon.blinking = true;
                    turnRightIcon.checked = true;
                } else {
                    console.log("Xi nhan phải tắt");
                    turnRightIcon.blinking = false;
                    turnRightIcon.checked = false;
                }
                break;

            case "COS":
                if (status === "ON") {
                    console.log("Đèn cos bật");
                    iconLightCosIcon.checked = true;
                } else {
                    console.log("Đèn cos tắt");
                    iconLightCosIcon.checked = false;
                }
                break;

            case "PHA":
                if (status === "ON") {
                    console.log("Đèn pha bật");
                    iconLightPhaIcon.checked = true;
                } else {
                    console.log("Đèn pha tắt");
                    iconLightPhaIcon.checked = false;
                }
                break;
            case "HAZARD":
                if (status === "ON"){
                    console.log("Đèn hazard bật");
                    iconHazardIcon.checked = true;
                } else {
                    console.log("Đèn hazard tắt");
                    iconHazardIcon.checked = false;
                }

            default:
                console.log("Thiết bị không hợp lệ:", device);
                break;
            }
        }
    }



}
