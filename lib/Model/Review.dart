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
  Comment.fromMap(Map<String, dynamic> data){
    this.comment = data["comment"];
    this.star = data["star"];
  }
  Map<String,dynamic> toMap(){
    return {
      "comment": comment,
      "star": star,
    };
  }
}
