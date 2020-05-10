import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:codename/Model/Review.dart';

class ReviewsProvider{
  static const String _COLLECTION_NAME = "reviews";
  static const String _COMMENT_COLLECTION_NAME = "comments";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);

  static Future<Review> getReview(String questionId) async {
    DocumentSnapshot snapshot = await collection.document(questionId).get();
    if(!snapshot.exists){
      await collection.document(questionId).setData({'comment': true});
      return Review(
        questionId: questionId,
        stars: 0,
        comments: List<Comment>(),
      );
    }else{
      QuerySnapshot commentsQuery = await collection.document(questionId).collection(_COMMENT_COLLECTION_NAME).orderBy("createdAt", descending: true).limit(5).getDocuments();
      return Review(
        questionId: questionId,
        stars: snapshot.data['stars'],
        comments: commentsQuery.documents.map((document){
          return Comment.fromMap(document.data);
        }).toList(),
      );
    }
  }
  static Future<void> addComment(String questionId, Comment comment){
    print(questionId);
    Map<String, dynamic> data = comment.toMap();
    data['createdAt'] = FieldValue.serverTimestamp();
    return collection.document(questionId)
      .collection(_COMMENT_COLLECTION_NAME)
      .add(data);
  }
}


