# jenkins-image-nodejs-android
CI image for full-stack szenario: Android-App Nodejs Backend Angular 4 Frontend (without android sdk &amp; emulator)

# Description


This images is based on the recent jenkins/jenkins:lts docker image and extended for a full-stack szenario:
Android-App
Nodejs Backend
Angular 4 Frontend

Following extensions have been made:

- nvm v0.33.6
- node 8.9.1
- npm version shipped with node
- heroku-cli
- nano
- libxss1 libgconf-2-4 (needed for Chromium/Chrome tests)
- gradle 4.3.1 (for the Android app)
- all repository sources have been updates (apt-get update, install, autoclean)

Note: The android sdk and android emulator are not part of this image, so they can be maintained seperately.
The recommended way is to use this image in combination with an android-emulator images and mount the sdk of the emulator image.
Same count's for databases.
