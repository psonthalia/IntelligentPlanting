# IntelligentPlanting - 1st Place at Los Altos Hacks
###### The smart way to plant your plants at home


# Inspiration
We are ardent supporters of the movement to help stall global warming. To help make this dream practical, we have developed a multi-faceted network of devices known as RoBotany to equip consumers with the ability to farm and grow flowering plants in their backyard with ease and convenient control/tracking systems. By using RoBotany, almost anyone can help do their part in reducing climate change by making the world just a little bit greener.

# What it does
RoBotany is composed of two architectural realms - that of the hardware(the RoBotanist) and the software/web(RoBotany database). The RoBotanist is left in the soil at the root of the plant to measure and track moisture and notify the user's smartphone when watering is required. Much of the analytical heavy lifting is done by the database, which stores over 1,500 different American plants and their regions of fertility around the U.S., which offers the user suggestions for what plants may be optimal for their climate and locale. The user can view statistics about their plant in the last 30 days by visiting the RoBotany web app and entering in their RoBotanist's Serial Identifier(SID), which is located on the bottom of the RoBotanist.

# How we built it
By combining aforementioned APIs and utilities. (sorry, I'm really tired; this would be a long section).

# Challenges we ran into
Keeping our energy was perhaps the toughest challenge of developing RoBotany. The entire team sacrificed their sleep for completing the necessary components for RoBotany to function. In addition, designing our own moisture sensor(because we did not have one at our disposal) was a challenge to calibrate and build.

# Accomplishments that we're proud of
We are proud of our hardware and its connection to web via the viewable statistics on the RoBotany web app. The UI for the web app, as well, is excellently materially designed by hand. In general, it was quite the IoT engineering feat to put all of the moving parts of RoBotany together, despite our sleep deprivation.

# What we learned
We learned a great deal about organizing communication between devices to build a responsive and cohesive meta-system built to complete a complex task.

# What's next for RoBotany
RoBotany can best be improved by refining the intelligence of our Augmented Reality feature, which is used to determine the health and lighting conditions for a given plant. In addition, we would like to provide better and more diverse statistics about the user's plant's growth in the web app. Finally, we plan to design a smaller, solar-powered PCB chip that would replace our modest prototype for the RoBotanist and a sleek/ergonomic outer casing for that PCB.

# Built With
`raspberry-pi`, `nodemcu`, `breadboard`, `solar`, `zurb-foundation`, `xcode`, `arkit`, `firebase`, `mqtt`, `google-cloud-vision`, `jquery`, `google-chart`

# Try it out
ro-botany.github.io
