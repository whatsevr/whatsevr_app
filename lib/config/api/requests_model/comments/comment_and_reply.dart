class CommentAndReplyRequest {
  final String? commentText;
  final String? replyText;
  final String? userUid;
  final String? videoPostUid;
  final String? flickPostUid;
  final String? memoryUid;
  final String? offerPostUid;
  final String? photoPostUid;
  final String? pdfUid;
  final String? commentUid;
//
  const CommentAndReplyRequest({
    this.commentText,
    this.replyText,
    this.videoPostUid,
    this.flickPostUid,
    this.memoryUid,
    this.offerPostUid,
    this.photoPostUid,
    this.pdfUid,
    this.commentUid,
    this.userUid,
  });

  Map<String, dynamic> toJson() => {
        'comment_text': commentText,
        'reply_text': replyText,
        'user_uid': userUid,
        'video_post_uid': videoPostUid,
        'flick_post_uid': flickPostUid,
        'memory_uid': memoryUid,
        'offer_post_uid': offerPostUid,
        'photo_post_uid': photoPostUid,
        'pdf_uid': pdfUid,
        'comment_uid': commentUid,
      };

  factory CommentAndReplyRequest.fromJson(Map<String, dynamic> json) =>
      CommentAndReplyRequest(
        commentText: json['comment_text'],
        replyText: json['reply_text'],
        userUid: json['user_uid'],
        videoPostUid: json['video_post_uid'],
        flickPostUid: json['flick_post_uid'],
        memoryUid: json['memory_uid'],
        offerPostUid: json['offer_post_uid'],
        photoPostUid: json['photo_post_uid'],
        pdfUid: json['pdf_uid'],
        commentUid: json['comment_uid'],
      );
}
