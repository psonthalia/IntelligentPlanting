# IntelligentPlanting - 1st Place at Los Altos Hacks
#### The smart way to plant your plants at home

Built by: Howard Wang, Paran Sonthalia, David Sillman, and Gabriel Hull

# Inspiration
We are ardent supporters of the movement to help stall global warming. To help make this dream practical, we have developed a multi-faceted network of devices known as RoBotany to equip consumers with the ability to farm and grow flowering plants in their backyard with ease and convenient control/tracking systems. By using RoBotany, almost anyone can help do their part in reducing climate change by making the world just a little bit greener.

# What it does
RoBotany is composed of two architectural realms - that of the hardware(the RoBotanist) and the software/web(RoBotany database). The RoBotanist is left in the soil at the root of the plant to measure and track moisture and notify the user's smartphone when watering is required. Much of the analytical heavy lifting is done by the database, which stores over 1,500 different American plants and their regions of fertility around the U.S., which offers the user suggestions for what plants may be optimal for their climate and locale. The user can view statistics about their plant in the last 30 days by visiting the RoBotany web app and entering in their RoBotanist's Serial Identifier(SID), which is located on the bottom of the RoBotanist.

# How we built it
It starts with the moisture sensor which we built by hand. We have 2 probes that are connected to a voltage divider and we measure the resistance in the soil. Based on the resistance in the soil, we can tell how moist the soil is. This data is then transmitted to a nodeMCU which reads the data and then uploads the data to a mosquitto server. This data is read by the raspberry pi which then uploads it to Firebase. The data from Firebase is read by the web app and the iOS app.

The web app uses the google charts api to take the data from Firebase and show it when you log in. We also used a QR code generator to create the QR code for a custom plant.

The iOS App reads from firebase and sends a push notification if the moisture level goes too low. The iOS app also gets your current location and suggests plants that you can grow. Then it uses ARKit to find the brightness outside. Then it used the Google Vision API to check up on your plant’s status.

# Challenges we ran into
Keeping our energy was perhaps the toughest challenge of developing RoBotany. The entire team sacrificed their sleep for completing the necessary components for RoBotany to function. In addition, designing our own moisture sensor(because we did not have one at our disposal) was a challenge to calibrate and build.

# Accomplishments that we're proud of
We are proud of our hardware and its connection to web via the viewable statistics on the RoBotany web app. The UI for the web app, as well, is excellently materially designed by hand. In general, it was quite the IoT engineering feat to put all of the moving parts of RoBotany together, despite our sleep deprivation.

# What we learned
We learned a great deal about organizing communication between devices to build a responsive and cohesive meta-system built to complete a complex task.

# What's next for RoBotany
RoBotany can best be improved by refining the intelligence of our Augmented Reality feature, which is used to determine the health and lighting conditions for a given plant. In addition, we would like to provide better and more diverse statistics about the user's plant's growth in the web app. Finally, we plan to design a smaller, solar-powered PCB chip that would replace our modest prototype for the RoBotanist and a sleek/ergonomic outer casing for that PCB.

# VMware Presentation
The Robotany team was invited to present as part of the opening ceremony of VMware's Borathon, a hackathon attended by VP's and engineers alike. There, we presented our project to VMware and heard feedback from their employees.
Check out VMware's blog at: https://octo.vmware.com/our-first-themed-borathon-on-sustainability/

# Built With
`raspberry-pi`, `nodemcu`, `breadboard`, `solar`, `zurb-foundation`, `xcode`, `arkit`, `firebase`, `mqtt`, `google-cloud-vision`, `jquery`, `google-chart`

# Try it out
[ro-botany.github.io](https://ro-botany.github.io)
