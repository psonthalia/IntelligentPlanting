#include <PubSubClient.h>
#include <ESP8266WiFi.h> // Enables the ESP8266 to connect to the local network (via WiFi)

 
const char* ssid = "Los Altos Hacks Hackathon";
const char* password =  "ReachNewHeights";
const char* mqttServer = "m12.cloudmqtt.com";
const int mqttPort = 19471;
const char* mqttUser = "titfboib";
const char* mqttPassword = "PX9XmPFN0TbL";
const char* mqtt_server = "192.168.2.2";

int val = 0;
 
WiFiClient espClient;
PubSubClient client(mqttServer, 19471, espClient);
 
void setup() {
 
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
 
  Serial.println("Connected to the WiFi network");
  Serial.println(WiFi.localIP());

//  Serial.println(espClient.get("http://www.arduino.cc/asciilogo.txt"));
 
  client.setServer(mqttServer, mqttPort);
 
  while (!client.connected()) {
    Serial.println("Connecting to MQTT...");
 
    if (client.connect("ESP32Client", mqttUser, mqttPassword)) {
 
      Serial.println("connected");
 
    } else {
 
      Serial.print("failed with state ");
      Serial.print(client.state());
      delay(2000);
 
    }
  }
 
 
}
 
void loop() {
  
//  if(abs(analogRead(A0) - val) > 10) {
    val = analogRead(A0);
    
    String str;
    str=String(val);
    char charBuf[50];
    str.toCharArray(charBuf, 50);
    
    client.publish("esp/test", charBuf);
//  }
  Serial.println(analogRead(A0));
  client.loop();
  delay(10000);
}
