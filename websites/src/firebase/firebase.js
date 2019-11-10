import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

const config = {
  apiKey: "AIzaSyBELC_Y6B0DaIMI9Y_y2tQviqmLB99XhQw",
  authDomain: "word-association-8764f.firebaseapp.com",
  databaseURL: "https://word-association-8764f.firebaseio.com",
  projectId: "word-association-8764f",
  storageBucket: "word-association-8764f.appspot.com",
  messagingSenderId: "183582132651",
  appId: "1:183582132651:web:2d9ba469ec4639e4c9eaee",
  measurementId: "G-DY1JGK5L2Y"
}

firebase.initializeApp(config);

export default firebase