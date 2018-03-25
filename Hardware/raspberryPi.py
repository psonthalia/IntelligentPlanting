import paho.mqtt.client as mqttClient
import time
from firebase import firebase

def on_connect(client, userdata, flags, rc):
    
    if rc == 0:
        
        print("Connected to broker")
        
        global Connected                #Use global variable
        Connected = True                #Signal connection

    else:
        
        print("Connection failed")

def on_message(client, userdata, message):
    print "Message received: "  + message.payload
    firebase = firebase.FirebaseApplication('https://intelligent-planting-5f489.firebaseio.com', None)
    result = firebase.get('/Moisture', None)
    index = 0
    firebase.post('/SID', {index: message.payload})
    index = index + 1
#    print result


Connected = False   #global variable for the state of the connection

broker_address= "m12.cloudmqtt.com"  #Broker address
port = 19471                         #Broker port
user = "titfboib"                    #Connection username
password = "PX9XmPFN0TbL"            #Connection password

client = mqttClient.Client("Python")               #create new instance
client.username_pw_set(user, password=password)    #set username and password
client.on_connect= on_connect                      #attach function to callback
client.on_message= on_message                      #attach function to callback

client.connect(broker_address, port=port)          #connect to broker

client.loop_start()        #start the loop

while Connected != True:    #Wait for connection
    time.sleep(0.1)

client.subscribe("esp/test")

try:
    while True:
        time.sleep(1)

except KeyboardInterrupt:
    print "exiting"
    client.disconnect()
    client.loop_stop()
