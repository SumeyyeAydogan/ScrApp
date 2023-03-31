
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <SD.h>


#define FIREBASE_HOST "scrap-app-9769b-default-rtdb.europe-west1.firebasedatabase.app/"
#define FIREBASE_AUTH "MjsCNBx8GqD9dROAifrruYWMrMu1IIqBOmHsrTXD"
#define WIFI_SSID "Your Wifi SSID"
#define WIFI_PASSWORD "Your Wifi Password"


FirebaseData mydatabase;


//PINS
#define potpin A0
int value = 0;



void setup() {
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());


  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);


  Firebase.reconnectWiFi(true);
  pinMode(D2, OUTPUT);
  digitalWrite(D2, LOW);
  Serial.println("Pot Value:");


}

void loop() {

  value = analogRead(potpin);
  float voltage = (100 / 1024.00) * value;
  int paperBoxLoadRate = round(voltage);
  Serial.println(paperBoxLoadRate);
  delay(100000);


  if (Firebase.setInt(mydatabase, "/allboxes/box00002/boxes/Paper Box", paperBoxLoadRate))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

  delay(100000);

  if (Firebase.setInt(mydatabase, "/allboxes/box00002/boxes/Glass Box", 25))
  {
    Serial.println("Connection Succseed");

  }

  else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }



  delay(100000);

  if (Firebase.setInt(mydatabase, "/allboxes/box00002/boxes/Plastic Box", 18))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

  delay(100000);


  if (Firebase.setInt(mydatabase, "/allboxes/box00002/boxes/Metal Box", 78))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

  delay(100000);

  if (Firebase.setInt(mydatabase, "/allboxes/box00002/boxes/Oil Box", 65))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

  delay(100000);


  if (Firebase.setInt(mydatabase, "/allboxes/box00002/boxes/Electronic Box", 95))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

  delay(100000);

  if (Firebase.setString(mydatabase, "/allboxes/box00002/info/Province", "Etimesgut"))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

  delay(100000);

  if (Firebase.setString(mydatabase, "/allboxes/box00002/info/Id", "00002"))
  {
    Serial.println("Connection Succseed");

  } else {
    Serial.print("Couldn't sent");
    Serial.println(mydatabase.errorReason());
  }

}
