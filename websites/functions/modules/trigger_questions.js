const functions = require('firebase-functions');

const admin = require('firebase-admin');
const fireStore = admin.firestore();

const questionRef = fireStore.collection('questions');

exports.questionAdd = functions.firestore
.document('questions/{questionId}')
.onCreate((snapshot, context) => {
  const data = snapshot.data();
  console.log("---------------- chat received ----------------", data);
});


// manageData/counterのquestionIdを設定すると数字をquestionのidxに設定する
exports.incrementQuestionId = functions.firestore
.document('manageData/counter')
.onWrite((change, context) => {
  const document = change.after.exists ? change.after.data() : null;
  const oldDocument = change.before.exists ? change.before.data() : null;
  console.log("oldDocument, document", oldDocument, document);

  if(document === null) return;
  if(oldDocument !== null && oldDocument.questionId === document.questionId) return;

  const questionId = document.questionId;
  const questions = document.questions;

  questionRef.doc(questionId).update({idx: questions});

});
