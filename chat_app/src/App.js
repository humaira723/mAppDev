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
        <h1>ChatApp</h1>
        <form className='rank'>
          <input type="number" name="rating" min="0" max="5"/>
          <input type="submit" value="Rank"/>
        </form>
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
  const handleGoogleLogin = () => {
    const provider = new firebase.auth.GoogleAuthProvider();
    auth.signInWithPopup(provider);
  }
  
  return(
    <div>
      <h2>Welcome to ChatApp!</h2>
      <h4>Please sign in below.</h4>
      <button className="sign-in" onClick={handleGoogleLogin}>Google Login</button>
    </div>
  )
}

function SignOut() {
  return auth.currentUser && (
    <button onClick={() => auth.signOut()}>Log Out</button>
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

      <form className='message_form' onSubmit={sendMessage}>
        <input placeholder='Message...' value={formValue} onChange={(e) => setFormValue(e.target.value)} />
        <button className="send" type="submit">Send</button>
      </form>
    </>
  )
}

function ChatMessage(props) {
  const { text, uid } = props.message;
  const messageClass = uid === auth.currentUser.uid ? 'sent' : 'received';

  return (
    <div className={`message ${messageClass}`}>
      <img src={"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"}/>
      <p>{text}</p>
    </div>
  )
}
export default App;
