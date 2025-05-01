// Xi nhan trái
const int xinhanTrai_Led = 4;
const int xinhanTrai_Button = 35;

// Xi nhan phải
const int xinhanPhai_Led = 18;
const int xinhanPhai_Button = 32;

// Đèn cos
const int denCos_Led = 15;
const int denCos_Button = 33;

// Đèn pha
const int denPha_Led = 13;
const int denPha_Button = 25;

// Hazard
const int hazard_Button = 34;  // THÊM nút hazard

// Biến điều khiển nhấp nháy xi nhan
bool blinkingLeft = false;
bool blinkingRight = false;
bool hazardActive = false;  // THÊM biến hazard
bool ledStateLeft = false;
bool ledStateRight = false;

unsigned long previousMillis = 0;
const long interval = 500;  // Thời gian nhấp nháy LED (ms)

void setup() {
  Serial.begin(115200);

  // Khởi tạo trạng thái LED (tắt hết)
  digitalWrite(xinhanTrai_Led, LOW);
  digitalWrite(xinhanPhai_Led, LOW);
  digitalWrite(denCos_Led, LOW);
  digitalWrite(denPha_Led, LOW);

  // Cấu hình các chân LED
  pinMode(xinhanTrai_Led, OUTPUT);
  pinMode(xinhanPhai_Led, OUTPUT);
  pinMode(denCos_Led, OUTPUT);
  pinMode(denPha_Led, OUTPUT);

  // Cấu hình các chân nút nhấn
  pinMode(xinhanTrai_Button, INPUT_PULLUP);
  pinMode(xinhanPhai_Button, INPUT_PULLUP);
  pinMode(denCos_Button, INPUT_PULLUP);
  pinMode(denPha_Button, INPUT_PULLUP);
  pinMode(hazard_Button, INPUT_PULLUP);

  // Reset tất cả trạng thái nhấp nháy
  blinkingLeft = false;
  blinkingRight = false;
  hazardActive = false;
  ledStateLeft = false;
  ledStateRight = false;

  // Reset timer
  previousMillis = millis();
}

void loop() {
  // Đọc trạng thái các nút
  bool leftBtnState = digitalRead(xinhanTrai_Button);
  bool rightBtnState = digitalRead(xinhanPhai_Button);
  bool cosBtnState = digitalRead(denCos_Button);
  bool phaBtnState = digitalRead(denPha_Button);
  bool hazardBtnState = digitalRead(hazard_Button);

  // --- XỬ LÝ NÚT HAZARD ---
  static bool lastHazardBtnState = HIGH;
  if (hazardBtnState != lastHazardBtnState) {
    delay(20);                       // chống dội nút
    if (hazardBtnState == LOW) {     // Nhấn nút
      hazardActive = !hazardActive;  // Đảo trạng thái hazard

      if (hazardActive) {
        Serial.println("HAZARD:ON");
      } else {
        Serial.println("HAZARD:OFF");
        // Khi tắt hazard, đèn trở về xi-nhan trái hoặc phải nếu còn bật
      }
    }
    lastHazardBtnState = hazardBtnState;
  }

  // --- XỬ LÝ NÚT XI NHAN TRÁI ---
  static bool lastLeftBtnState = HIGH;
  if (leftBtnState != lastLeftBtnState) {
    delay(20);                  // chống dội nút
    if (leftBtnState == LOW) {  // Nhấn nút
      if (!blinkingLeft) {
        blinkingLeft = true;
        blinkingRight = false;
        Serial.println("TURN_LEFT:ON");
        Serial.println("TURN_RIGHT:OFF");
      } else {
        blinkingLeft = false;
        Serial.println("TURN_LEFT:OFF");
      }
    }
    lastLeftBtnState = leftBtnState;
  }

  // --- XỬ LÝ NÚT XI NHAN PHẢI ---
  static bool lastRightBtnState = HIGH;
  if (rightBtnState != lastRightBtnState) {
    delay(20);                   // chống dội nút
    if (rightBtnState == LOW) {  // Nhấn nút
      if (!blinkingRight) {
        blinkingRight = true;
        blinkingLeft = false;
        Serial.println("TURN_RIGHT:ON");
        Serial.println("TURN_LEFT:OFF");
      } else {
        blinkingRight = false;
        Serial.println("TURN_RIGHT:OFF");
      }
    }
    lastRightBtnState = rightBtnState;
  }

  // --- XỬ LÝ NHÁY LED ---
  if (millis() - previousMillis >= interval) {
    previousMillis = millis();

    if (hazardActive) {
      // Hazard bật: nháy cả hai đèn
      ledStateLeft = !ledStateLeft;
      ledStateRight = ledStateLeft;  // Cùng trạng thái nháy
      digitalWrite(xinhanTrai_Led, ledStateLeft);
      digitalWrite(xinhanPhai_Led, ledStateRight);
    } else {
      // Hazard tắt: nháy bình thường từng bên
      if (blinkingLeft) {
        ledStateLeft = !ledStateLeft;
        digitalWrite(xinhanTrai_Led, ledStateLeft);
      } else {
        digitalWrite(xinhanTrai_Led, LOW);
      }

      if (blinkingRight) {
        ledStateRight = !ledStateRight;
        digitalWrite(xinhanPhai_Led, ledStateRight);
      } else {
        digitalWrite(xinhanPhai_Led, LOW);
      }
    }
  }

  // XỬ LÝ ĐÈN COS
  static bool lastCosBtnState = HIGH;
  static bool cosLedState = false;
  static bool cosWasOnBeforePha = false;

  if (cosBtnState != lastCosBtnState) {
    delay(20);  // chống dội nút
    if (cosBtnState == LOW) {
      cosLedState = !cosLedState;
      digitalWrite(denCos_Led, cosLedState);
      Serial.print("DEN_COS:");
      Serial.println(cosLedState ? "ON" : "OFF");
    }
    lastCosBtnState = cosBtnState;
  }


  // XỬ LÝ ĐÈN PHA
  static bool lastPhaBtnState = HIGH;
  static bool phaLedState = false;

  if (phaBtnState != lastPhaBtnState) {
    delay(20);  // chống dội nút
    if (phaBtnState == LOW) {
      phaLedState = !phaLedState;

      if (phaLedState) {
        // Nếu bật pha → lưu trạng thái cos rồi tắt cos
        cosWasOnBeforePha = cosLedState;
        digitalWrite(denCos_Led, LOW);
        cosLedState = false;

        digitalWrite(denPha_Led, HIGH);  // BẬT đèn pha
        Serial.println("DEN_PHA:ON");
      } else {
        // Nếu tắt pha → bật lại cos nếu trước đó đang bật
        digitalWrite(denPha_Led, LOW);  // TẮT đèn pha
        Serial.println("DEN_PHA:OFF");
        if (cosWasOnBeforePha) {
          digitalWrite(denCos_Led, HIGH);
          cosLedState = true;
          Serial.println("DEN_COS:ON");
        }
      }
    }
    lastPhaBtnState = phaBtnState;
  }
}