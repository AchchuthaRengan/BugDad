# BugDad - A New Social Network For Coders.
<body style="background-color:grey;">
<img src = "https://github.com/AchchuthaRengan/BugDad/blob/master/one.png" width = "150">
<img src="https://github.com/AchchuthaRengan/BugDad/blob/master/GIFS/bugdadnew.gif" align = "right" width="250" alt = "Dart">
<h2>A working project written in Flutter using Firestore.</h2>

# L a n g u a g e :
<img src="https://github.com/AchchuthaRengan/BugDad/blob/master/dart.png" align = "center" width="150" alt = "Dart">
<p>Dart is a client-optimized language for fast apps on any platform.</p>
   
# F r a m e w o r k :
<img src="https://github.com/AchchuthaRengan/BugDad/blob/master/flutter-lockup-c13da9c9303e26b8d5fc208d2a1fa20c1ef47eb021ecadf27046dea04c0cebf6.png"  width="150" alt = "Flutter">
<p>Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android, from a single codebase.</p>
   
 # F e a t u r e s :
  <p>⭐ Custom photo feed based on who you follow (using firebase cloud functions).</p>
  <p>⭐ Post photo posts from camera or gallery.</p>
  <p>⭐ Like posts.</p>
  <p>⭐ Comment on posts.</p><p>* View all comments on a post.</p>
  <p>⭐ Search for users.</p>
  <p>⭐ Profile Pages.</p>
  <p>⭐ Follow / Unfollow Users.</p>
  <p>⭐ Add your own bio.</p>
  <p>⭐ Activity Feed showing recent likes / comments of your posts + new followers.</p>
  <p>⭐ Notification for likes.</p>
  <p>⭐ Delete Posts.</p>
  <p>⭐ Animations (heart when liking image).</p>
   
 # S c r e e n s :
   <p>
   <img src="https://github.com/AchchuthaRengan/BugDad/blob/master/GIFS/Intro.gif" alt="Intro"      width="250">
   <img src="https://github.com/AchchuthaRengan/BugDad/blob/master/GIFS/SignUp.gif" alt="SignUp"    width="250">
   <img src="https://github.com/AchchuthaRengan/BugDad/blob/master/GIFS/Welcome.gif" alt="Welcome"  width="250">
   <img src="https://github.com/AchchuthaRengan/BugDad/blob/master/GIFS/Home.gif" alt="Home"        width="250">
   <img src="https://github.com/AchchuthaRengan/BugDad/blob/master/GIFS/Editprofile.gif" alt="Edit" width="250">
   </p>
   
 # D e p e n d e n c i e s :
 
 
   ⭐ [Flutter](https://flutter.dev/) <br/>
   ⭐ [Firestore](https://github.com/flutter/plugins/tree/master/packages/cloud_firestore) <br/>
   ⭐ [Image Picker](https://github.com/flutter/plugins/tree/master/packages/image_picker) <br/>
   ⭐ [Google Sign In](https://github.com/flutter/plugins/tree/master/packages/google_sign_in) <br/>
   ⭐ [Firebase Auth](https://github.com/flutter/plugins/tree/master/packages/firebase_auth) <br/>
   ⭐ [UUID](https://github.com/Daegalus/dart-uuid) <br/>
   ⭐ [Dart Image](https://github.com/brendan-duncan/image) <br/>
   ⭐ [Path Provider](https://github.com/flutter/plugins/tree/master/packages/path_provider) <br/>
   ⭐ [Font Awesome](https://github.com/brianegan/font_awesome_flutter) <br/>
   ⭐ [Dart HTTP](https://github.com/dart-lang/http) <br/>
   ⭐ [Dart Async](https://github.com/dart-lang/async) <br/>
   ⭐ [Flutter Shared Preferences]() <br/>
   ⭐ [Cached Network Image](https://github.com/renefloor/flutter_cached_network_image) <br/>
   
   
## Want to do the same..?

## Let's Get Started..!.

## F L U T T E R

#### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

#### 2. Clone the repoisitory

```sh
$ git clone https://github.com/AchchuthaRengan/BugDad.git
$ cd BugDad/
```

#### 3. F I R E B A S E 

1. You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Google" and enable it

3. Create Cloud Functions (to make the Feed work)
* Create a new firebase project with `firebase init`
* Copy this project's `functions/lib/index.js` to your firebase project's `functions/index.js`
* Push the function `getFeed` with `firebase deploy --only functions`  In the output, you'll see the getFeed URL, copy that.
* Replace the url in the `_getFeed` function in `feed.dart` with your cloud function url from the previous step.

_You may need to create the neccessary index by running `firebase functions:log` and then clicking the link_

_**If you are getting no errors, but an empty feed** You must post photos or follow users with posts as the getFeed function only returns your own posts & posts from people you follow._

4. Enable the Firebase Database
* Go to the Firebase Console
* Click "Database" in the left-hand menu
* Click the Cloudstore "Create Database" button
* Select "Start in test mode" and "Enable"

5. (skip if not running on Android)

* Create an app within your Firebase instance for Android, with package name com.yourcompany.news
* Run the following command to get your SHA-1 key:

```
keytool -exportcert -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
```

* In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking "Add Fingerprint".
* Follow instructions to download google-services.json
* place `google-services.json` into `/android/app/`.

6. (skip if not running on iOS)

* Create an app within your Firebase instance for iOS, with your app package name
* Follow instructions to download GoogleService-Info.plist
* Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
* Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist

Double check install instructions for both
   - Google Auth Plugin
     - https://pub.dartlang.org/packages/firebase_auth
   - Firestore Plugin
     -  https://pub.dartlang.org/packages/cloud_firestore
   
 
   

   
   
