import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:codename/Model/Review.dart';

class ReviewsProvider{
  static const String _COLLECTION_NAME = "reviews";
  static CollectionReference collection = Firestore.instance.collection(_COLLECTION_NAME);

  static Future<Review> addReview(String questionId, int stars, String comment) async {
    collection.document(questionId).documentID;

  }
  static Future<Review> getReview(String questionId) async {
    DocumentSnapshot snapshot = await collection.document(questionId).get();
    if(!snapshot.exists){
      await collection.document(questionId).setData({
        'stars': 0,
        'comment':[],
      });
    }else{
      print(snapshot.data);
      List<Comment> comments = (snapshot.data['comment'] as List).map((comment){
        return Comment(
          comment: comment['comment'],
          star: comment['star'],
        );
      }).toList();
      return Review(
        questionId: questionId,
        stars: snapshot.data['stars'],
        comments: comments,
      );
    }
  }
  static Future<void> addComment(String questionId, Comment comment){
    return collection.document(questionId).updateData({
      'comment': FieldValue.arrayUnion([comment.toMap()]),
    });
  }
}


