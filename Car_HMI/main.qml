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
            property int currentAngle: 150

            Image{
                id: r34
                source: "qrc:/img/nissan_skyline_gt-r_18337-removebg-preview.png"
                width: 725
                height: 339
                //anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.centerIn: parent
                //anchors.topMargin: 200
            }


            //Mặt đồng hồ trái
            Speedometer {
                id: speedometerLeft
                width: 470
                height: 470
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 150

                meterImage: "qrc:/img/speedImg.png"
                indicatorImage: "qrc:/img/Indicator.png"
                angle: 148
            }

            //Button tăng tốc độ đồng hồ trái
            Rectangle{
                id: speedUpButton
                x: 275
                y: 800
                width: 120
                height: 50
                color: mouseAreaSpeedUp.containsPress ? "#4CAF50" : "#8BC34A"
                radius: 5
                border.color: "#388E3C"
                border.width: 2

                Text {
                    text: "Tăng tốc độ"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                }

                MouseArea {
                    id: mouseAreaSpeedUp
                    anchors.fill: parent
                    onClicked: {
                        var newAngle = speedometerLeft.angle + 10;
                        speedometerLeft.angle = Math.min(newAngle, 390);
                    }
                }
            }

            Rectangle {
                id: speedDownButton
                x: 425
                y: 800
                width: 120
                height: 50
                color: mouseAreaSpeedDown.containsPress ? "#F44336" : "#FF5722"
                radius: 5
                border.color: "#D32F2F"
                border.width: 2

                Text {
                    text: "Giảm tốc độ"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                }

                MouseArea {
                    id: mouseAreaSpeedDown
                    anchors.fill: parent
                    onClicked: {
                        var newAngle = speedometerLeft.angle - 10;
                        speedometerLeft.angle = Math.max(newAngle, 148);
                    }
                }
            }

            //Cảnh báo khi vượt quá tốc độ
            Image{
                id: speedWarningIcon
                source: {
                    if (speedometerLeft.angle >= 148 && speedometerLeft.angle <= 230)
                        return "qrc:/icons/warning_faded.svg";
                    else if (speedometerLeft.angle >= 230 && speedometerLeft.angle <= 330)
                        return "qrc:/icons/warning_orange.svg";
                    else if (speedometerLeft.angle >= 330)
                        return "qrc:/icons/warning_red.svg";
                    else
                        return;
                }
                width: 60
                height: 60
                // anchors.top: topbarID.top
                // anchors.topMargin: 20
                // anchors.horizontalCenter: topbarID.horizontalCenter
                y: 265
                anchors.right: background.right
                anchors.rightMargin: 160
                smooth: true
                fillMode: Image.PreserveAspectFit
            }


            //Mặt đồng hồ phải
            Speedometer {
                id: speedometerRight
                width: 470
                height: 470
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 150

                meterImage: "qrc:/img/tachoImg.png"
                indicatorImage: "qrc:/img/Indicator.png"
                angle: 150
            }

            //Button tăng vòng tour máy
            Rectangle{
                id: speedUpButton2
                x: 1375
                y: 800
                width: 120
                height: 50
                color: mouseAreaSpeedUp2.containsPress ? "#4CAF50" : "#8BC34A"
                radius: 5
                border.color: "#388E3C"
                border.width: 2

                Text {
                    text: "Tăng tốc độ"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                }

                MouseArea {
                    id: mouseAreaSpeedUp2
                    anchors.fill: parent
                    onClicked: {
                        var newAngle = speedometerRight.angle + 10;
                        speedometerRight.angle = Math.min(newAngle, 390);
                    }
                }
            }

            Rectangle {
                id: speedDownButton2
                x: 1525
                y: 800
                width: 120
                height: 50
                color: mouseAreaSpeedDown2.containsPress ? "#F44336" : "#FF5722"
                radius: 5
                border.color: "#D32F2F"
                border.width: 2

                Text {
                    text: "Giảm tốc độ"
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                }

                MouseArea {
                    id: mouseAreaSpeedDown2
                    anchors.fill: parent
                    onClicked: {
                        var newAngle = speedometerRight.angle - 10;
                        speedometerRight.angle = Math.max(newAngle, 148);
                    }
                }
            }

            //top  bar
            Speedometer{
                id: topbarID
                width: 650
                height: 80
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 195
                meterImage: "qrc:/img/bottom.png"
                transform: Scale {
                    xScale: 1
                    yScale: -1
                }
            }

            //logo
            FunctionIcon{
                id: iconLogo
                width: 80
                height: 80
                anchors.top: parent.top
                anchors.horizontalCenter: topbarID.horizontalCenter
                anchors.topMargin: 95
                iconImageOff: "qrc:/icons/logo.svg"
            }

            //xi nhan trái
            FunctionIcon{
                id: turnLeftIcon
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30

                iconImageOff: "qrc:/icons/icons-left/icon-park-solid_left-two.svg"
                iconImageOn: "qrc:/icons/icons-left-checked/icon-park-solid_right-two.svg"
                checked: false

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        turnLeftIcon.checked = !turnLeftIcon.checked

                        if (turnLeftIcon.checked){
                            console.log("Xi nhan trái bật");
                            turnLeftIcon.checked = true
                            turnLeftIcon.blinking = true
                            turnRightIcon.checked = false
                            turnRightIcon.blinking = false
                            serialManager.sendData("TURN_LEFT:ON")
                        } else {
                            console.log("Xi nhan trái tắt");
                            turnLeftIcon.checked = false
                            turnLeftIcon.blinking = false
                            turnRightIcon.checked = false
                            turnRightIcon.blinking = false
                            serialManager.sendData("TURN_LEFT:OFF")
                        }
                    }
                }
            }

            //xi nhan phải
            FunctionIcon{
                id: turnRightIcon
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 30

                iconImageOff: "qrc:/icons/icons-right/icon-park-solid_right-two.svg"
                iconImageOn: "qrc:/icons/icons-right-checked/icon-park-solid_right-two.svg"
                checked: false

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        turnRightIcon.checked = !turnRightIcon.checked

                        if (turnRightIcon.checked){
                            console.log("Xi nhan phải bật");
                            turnRightIcon.checked = true
                            turnRightIcon.blinking = true
                            turnLeftIcon.checked = false
                            turnLeftIcon.blinking = false
                            serialManager.sendData("TURN_RIGHT:ON")
                        } else {
                            console.log("Xi nhan phải tắt");
                            turnRightIcon.checked = false
                            turnRightIcon.blinking = false
                            serialManager.sendData("TURN_RIGHT:OFF")
                        }
                    }
                }
            }

            //đèn cos
            FunctionIcon{
                id: iconLightCosIcon
                x: 75
                y: 375
                width: 50
                height: 50
                opacity: 0.9

                iconImageOff: "qrc:/icons/icons-left/light_cos.svg"
                iconImageOn: "qrc:/icons/icons-left-checked/light_cos_checked.svg"
                checked: false

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        iconLightCosIcon.checked = !iconLightCosIcon.checked

                        if (iconLightCosIcon.checked){
                            console.log("Đèn cos bật");
                            iconLightCosIcon.checked = true
                            serialManager.sendData("DEN_COS:ON")
                        } else {
                            console.log("Đèn cos tắt");
                            iconLightCosIcon.checked = false
                            serialManager.sendData("DEN_COS:OFF")
                        }
                    }
                }
            }

            //đèn pha
            FunctionIcon{
                id: iconLightPhaIcon
                x: 145
                y: 305
                width: 50
                height: 50
                opacity: 0.9

                iconImageOff: "qrc:/icons/icons-left/light_high.svg"
                iconImageOn: "qrc:/icons/icons-left-checked/mdi_car-light-high-checked.svg"
                checked: false

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        iconLightPhaIcon.checked = !iconLightPhaIcon.checked

                        if (iconLightPhaIcon.checked){
                            console.log("Đèn pha bật");
                            iconLightPhaIcon.checked = true
                            serialManager.sendData("DEN_PHA:ON")
                        } else {
                            console.log("Đèn pha tắt");
                            iconLightPhaIcon.checked = false
                            serialManager.sendData("DEN_PHA:OFF")
                        }
                    }
                }
            }

            //đèn hazard
            FunctionIcon{
                id: iconHazardIcon
                x: 205
                y: 235
                width: 50
                height: 50
                opacity: 0.9

                iconImageOff: "qrc:/icons/icons-left/hazard_light.svg"
                iconImageOn: "qrc:/icons/icons-left-checked/hazard_light_checked.png"
                checked: false

                property bool wasLeftBlinkingBeforeHazard: false
                property bool wasRightBlinkingBeforeHazard: false

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        iconHazardIcon.checked = !iconHazardIcon.checked

                        if (iconHazardIcon.checked){
                            console.log("Hazard bật");
                            hazardBlinkTimer.start()

                            iconHazardIcon.wasLeftBlinkingBeforeHazard = turnLeftIcon.blinking
                            iconHazardIcon.wasRightBlinkingBeforeHazard = turnRightIcon.blinking

                            //serialManager.sendData("HAZARD:ON")
                            if (iconHazardIcon.wasLeftBlinkingBeforeHazard){
                                serialManager.sendData("TURN_LEFT:OFF")
                                turnLeftIcon.blinking = false
                                turnLeftIcon.checked = false
                                blinkTimerLeft.stop()
                            }
                            if (iconHazardIcon.wasRightBlinkingBeforeHazard){
                                serialManager.sendData("TURN_RIGHT:OFF")
                                turnRightIcon.blinking = false
                                turnRightIcon.checked = false
                                blinkTimerRight.stop()
                            }
                            serialManager.sendData("HAZARD:ON")
                        } else {
                            console.log("Hazard tắt");
                            hazardBlinkTimer.stop()
                            serialManager.sendData("HAZARD:OFF")
                            blinkTimerLeft.stop()
                            blinkTimerRight.stop()
                            turnRightIcon.blinking = false
                            turnRightIcon.checked = false
                            turnLeftIcon.blinking = false
                            turnLeftIcon.checked = false

                            if (iconHazardIcon.wasLeftBlinkingBeforeHazard) {
                                turnLeftIcon.blinking = true
                                turnLeftIcon.checked = true
                                blinkTimerLeft.start()
                                serialManager.sendData("TURN_LEFT:ON")
                            } if (iconHazardIcon.wasRightBlinkingBeforeHazard) {
                                turnRightIcon.blinking = true
                                turnRightIcon.checked = true
                                blinkTimerRight.start()
                                serialManager.sendData("TURN_RIGHT:ON")
                            }

                            iconHazardIcon.wasLeftBlinkingBeforeHazard = false
                            iconHazardIcon.wasRightBlinkingBeforeHazard = false
                        }
                    }
                }
            }

            //nhiệt độ nước mát
            TempIcon {
                id: oilTempIcon
                width: 45
                height: 45
                opacity: 0.9
                //x: 1020
                y: 110
                anchors.right: topbarID.right
                anchors.rightMargin: 200

                //status: "DANGEROUS"
                normalSource: "qrc:/icons/icons-right/temp_oil.svg"
                warningSource: "qrc:/icons/icons-right-checked/temp_oil_warning.svg"
                dangerousSource: "qrc:/icons/icons-right-checked/temp_oil_danger.svg"
            }

            //Nhiệt độ khoang lái
            TempIcon {
                id: cabinTempIcon
                width: 45
                height: 45
                opacity: 0.9
                //x: 1020
                y: 110
                anchors.left: topbarID.left
                anchors.leftMargin: 100

                status: "DANGEROUS"
                normalSource: "qrc:/icons/icons-right/temp_cabin.svg"
                warningSource: "qrc:/icons/icons-right-checked/temp_cabin_warning.svg"
                dangerousSource: "qrc:/icons/icons-right-checked/temp_cabin_danger.svg"

                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
            }

            //đèn báo nguồn điện
            FunctionIcon{
                id: batteryIcon
                // x: 145
                anchors.right: background.right
                anchors.rightMargin: 105
                y: 375
                width: 50
                height: 50
                opacity: 0.9

                iconImageOff: "qrc:/icons/icons-right/mdi_car-battery.svg"
                iconImageOn: "qrc:/icons/icons-right-checked/mdi_car-battery.svg"
                checked: false
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
        target: serialManager

        function onSignalChanged(message) {
            console.log("NHẬN SIGNAL RAW:", JSON.stringify(message));

            const cleanMsg = message.trim();
            console.log("SAU TRIM:", JSON.stringify(cleanMsg));


            if (cleanMsg.startsWith("TEMP: ")) {
                const tempValue = parseFloat(cleanMsg.substring(6)); // Bỏ qua "TEMP: "
                if (!isNaN(tempValue)) {
                    console.log("Nhận nhiệt độ số:", tempValue);
                    cabinTempIcon.temperature = tempValue;

                    // Tự động cập nhật trạng thái dựa trên nhiệt độ
                    if (tempValue >= 45) {
                        cabinTempIcon.status = "DANGEROUS";
                    } else if (tempValue >= 35) {
                        cabinTempIcon.status = "WARNING";
                    } else {
                        cabinTempIcon.status = "NORMAL";
                    }
                }
                return;
            }

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

            case "DEN_COS":
                if (status === "ON") {
                    console.log("Đèn cos bật");
                    iconLightCosIcon.checked = true;
                } else {
                    console.log("Đèn cos tắt");
                    iconLightCosIcon.checked = false;
                }
            break;

            case "DEN_PHA":
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
                    turnRightIcon.blinking = true;
                    turnRightIcon.checked = true;
                    turnLeftIcon.blinking = true;
                    turnLeftIcon.checked = true;
                } else {
                    console.log("Đèn hazard tắt");
                    turnRightIcon.blinking = false;
                    turnRightIcon.checked = false;
                    turnLeftIcon.blinking = false;
                    turnLeftIcon.checked = false;
                }
            break;

            case "TEMP_OIL":


            break;

            case "TEMP_CABIN":
                cabinTempIcon.status = status;
                console.log("Cập nhật trạng thái từ TEMP_CABIN:", status);

                if (status === "WARNING") {
                    console.log("Cảnh báo: Nhiệt độ khoang xe cao!");
                } else if (status === "DANGEROUS") {
                    console.log("CẢNH BÁO NGUY HIỂM: Nhiệt độ khoang xe quá cao!");
                } else {
                    console.log("Nhiệt độ khoang xe bình thường.");
                }
                break;


            default:
                console.log("Thiết bị không hợp lệ:", device);
                break;
            }
        }
    }
}
