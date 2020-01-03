class Review{
  String questionId;
  int stars;
  List<Comment> comments;
  Review({this.questionId, this.stars, this.comments});
}

class Comment{
  String comment;
  int star;
  Comment({this.comment, this.star});
  Map toMap(){
    return {
      "comment": comment,
      "star": star,
    };
  }
}
