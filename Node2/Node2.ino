/*
Pop-Up trên màn hình: "Nhiệt độ khoang xe cao! Bật điều hòa?" 

*/
#include "DHT.h"

#define DHTPIN 32      // Chân kết nối với DHT11
#define DHTTYPE DHT11  // Loại cảm biến

//Led cảnh báo cho khoang xe
const int khoangxeLed_vang = 33;  // Cảnh báo nhẹ (>=32°C)
const int khoangxeLed_do = 25;    // cảnh báo ở mức 35 - nguy hiểm

const int TEMP_THRESHOLD = 32;  // Cảnh báo
const int TEMP_THRESHOLD_WARNING = 35; // Nguy hiểm

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);  // UART để gửi dữ liệu sang STM32 hoặc PC

  // Khởi tạo trạng thái LED (tắt hết)
  digitalWrite(khoangxeLed_vang, LOW);
  digitalWrite(khoangxeLed_do, LOW);

  // Cấu hình các chân LED
  pinMode(khoangxeLed_vang, OUTPUT);
  pinMode(khoangxeLed_do, OUTPUT);

  dht.begin();
  delay(2000);
}

void loop() {
  float temp = dht.readTemperature();

  if (isnan(temp)) {
    Serial.println("ERROR_DHT11");
    delay(2000);
    return;
  }

  Serial.print("TEMP: ");
  Serial.println(temp);

  // Gửi cảnh báo nếu vượt ngưỡng
  if (temp > TEMP_THRESHOLD_WARNING){
    Serial.println("TEMP_CABIN:DANGEROUS");
    digitalWrite(khoangxeLed_do, HIGH);
    digitalWrite(khoangxeLed_vang, LOW);
  } else if (temp >= TEMP_THRESHOLD) {
    Serial.println("TEMP_CABIN:WARNING");
    digitalWrite(khoangxeLed_vang, HIGH);
    digitalWrite(khoangxeLed_do, LOW);
  } else {
    digitalWrite(khoangxeLed_vang, LOW);
    digitalWrite(khoangxeLed_do, LOW);
  }

  delay(2000);  // Đọc mỗi 2 giây
}
