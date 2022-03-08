# Chat App Midterm
## Humaira Ridi
### Mobile App Development - Spring 22

Using React and Firebase, I created a chat app that allows users to chat with others using their Google login. When running this app on your IDE, you must first run the command following line: npm install firebase react-firebase-hooks. I imported the required Firebase SDKs used in my App.js file such as firestore and auth. 

I used the hook, “useAuthState()”, to verify if a user is logged in or not. If the user returned by the hook is null/not defined, the user will be shown a login screen that allows for a Google sign in. This screen is established in the SignIn() function. This function listens to an onClick event that uses the provider GoogleAuthProvider to create a google login.
When a user logs in using a Google account, they are redirected to the chat screen where they can chat with other users. The ChatRoom() function references a Firestore  collection that stores ongoing messages sent by the user into that collection. This function uses the “useCollectionData()” hook and a query to listen to updates in the database. The form input used in this function references a form value and listens to the onChange event that will then set that change to the form value. This value will then be sent to the firestore collection as a message. This is shown in the sendMessage event handler which uses await to create a document in the firestore.
