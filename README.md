# What is DIGIQ

digiQ is an android mobile app + web app that makes queue management super easy. Let's deep dive into it's features.

1) As a creator of the queue:

- You have full access to the working of the queue.
- Our service will generate a QR code once you create a queue. The QR code or the queue id can be shared with everyone.
- You get the details of all the queues you have created; you can deactivate a queue, activate a queue, delete a queue, and move the queue ahead.

2) As a member of the queue:

- You can join any queue available from the app or you can enter the queue ID or scan the QR code from the scanner embedded in our android app.
- The app informs you about your position in the queue as well as the expected waiting time for the queue. You may decide to leave the queue if you wish to.

# How we built it
- We used Flutter to build the mobile app and ReactJS for the web version of the app.
- The backend was done using Flask and is hosted on the Microsoft Azure web service.
- Heroku is being used to host the main website.
- CosmosDB is being used as the database.
- Figma was used for wireframing and designing both the website as well as the app.
- We have also integrated Twilio to notify users when they are close to the front of the queue [Since we have a free account on Twilio, it is functional for a single mobile number only]

# How to run the mobile app?
- Download Flutter and Dart on your OS. Install the required extensions.
- Clone this project and run the following commands.
- Flutter clean
- Flutter pub get
- Flutter build apk --release.
