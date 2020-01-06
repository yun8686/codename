import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:codename/Model/Question.dart';

class QuestionsProvider{
  static const String _COLLECTION_NAME = "questions";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);
  static CollectionReference manageDataCollection = Firestore.instance.collection("manageData");

  static Future<Question> getRandomQuestion() async {
    DocumentSnapshot snapshot = await manageDataCollection.document("counter").get();
    int idx = new Random().nextInt(snapshot.data["questions"] as int);
    QuerySnapshot querySnapshot = await collection
        .where("idx", isGreaterThanOrEqualTo: idx)
        .orderBy("idx", descending: false)
        .limit(1).getDocuments();

    return Question(
      documentId: querySnapshot.documents[0].documentID,
      title: querySnapshot.documents[0].data["title"],
      selections:(querySnapshot.documents[0].data["selections"] as List)
          .map((data)=>Selection(data["name"], data["answer"])).toList(),
    );
  }

  static Future<Question> putQuestion(Question question) async {
    if(question.documentId == null){
      WriteBatch batch = Firestore.instance.batch();
      DocumentReference questionRef = collection.document();
      String questionId = questionRef.documentID;
      batch.setData(questionRef, question.toMap());
      batch.updateData(manageDataCollection.document("counter"), {
        "questions": FieldValue.increment(1),
        "questionId": questionId,
      });
      await batch.commit();
      question.documentId = questionId;
    }
    return question;
  }
}


