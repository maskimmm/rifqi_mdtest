To use own database, register the mobile app to the firebase project and dont forget to put GoogleService-info.plist into the root file of xcodeproj


To run Unit Test, install Firebase emulator Suite: https://firebase.google.com/docs/emulator-suite

Make sure to check on the Authentication and on the Cloud Firestore


For Firestore Rules:
```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write, create;
    }
    match /Users/{userId} {
    allow write, create, update, delete: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```


Tested on iPhone 15 Pro Simulator (iOS 17.5)
