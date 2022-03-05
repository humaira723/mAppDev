import './App.css';

import firebase from 'firebase/compat/app';

import 'firebase/compat/firestore';
import 'firebase/compat/auth';

import { useAuthState } from 'react-firebase-hooks/auth';
import { useCollectionData } from 'react-firebase-hooks/firestore';
import { useState } from 'react';
import { async } from '@firebase/util';

firebase.initializeApp({
  apiKey: "AIzaSyBAryxV_JzFrBxseYRu-CVGJunvqPL5Xm8",
  authDomain: "midterm-chat-app-c90d1.firebaseapp.com",
  projectId: "midterm-chat-app-c90d1",
  storageBucket: "midterm-chat-app-c90d1.appspot.com",
  messagingSenderId: "752804824070",
  appId: "1:752804824070:web:7a4c8447a9c7ef8bd9af87"
})

const auth = firebase.auth();
const firestore = firebase.firestore();

function App() {

  // useAuthState to see if user is logged in
  // when signed in, returns user object, otherwise: null
  const [user] = useAuthState(auth);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Chat App</h1>
        <SignOut />
      </header>
      <section>
       {/* if user exists, display ChatRoom, otherwise: display SignIn */}
        {user ? <ChatRoom/> : <SignIn/>}
      </section>
    </div>
  );
}

function SignIn() {
  // insantiate a provider with google so user can sign in w a google popup
  const handleGoogleSignIn = () => {
    const provider = new firebase.auth.GoogleAuthProvider();
    auth.signInWithPopup(provider);
  }
  
  return(
    <button className="sign-in" onClick={handleGoogleSignIn}>Sign In with Google</button>
  )
}

function SignOut() {
  return auth.currentUser && (
    <button onClick={() => auth.signOut()}>Sign Out</button>
  )
}

function ChatRoom() {
  // references to collection database
  const messagesRef = firestore.collection('messages');
  const query = messagesRef.orderBy('createdAt').limit(25);

  // listens to updates to messages data
  // returns chat message object
  const [messages] = useCollectionData(query, { idField: 'id' });

  const [formValue, setFormValue] = useState('');

  const sendMessage = async(e) => {

    // prevents refreshing page after submission
    e.preventDefault();

    const { uid, photoURL } = auth.currentUser;

    await messagesRef.add({
      text: formValue,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
      uid,
      photoURL
    });
    setFormValue('');
  }

  return (
    <>
      <div>
        {messages && messages.map(chat => <ChatMessage key={chat.id} message={chat}/>)}
      </div>

      <form onSubmit={sendMessage}>
        <input value={formValue} onChange={(e) => setFormValue(e.target.value)} />
        <button type="submit">Send</button>
      </form>
    </>
  )
}

function ChatMessage(props) {
  const { text, uid, photoURL } = props.message;
  const messageClass = uid === auth.currentUser.uid ? 'sent' : 'received';

  return (
    <div className={`message ${messageClass}`}>
      <img src={"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"}/>
      <p>{text}</p>
    </div>
  )
}
export default App;
