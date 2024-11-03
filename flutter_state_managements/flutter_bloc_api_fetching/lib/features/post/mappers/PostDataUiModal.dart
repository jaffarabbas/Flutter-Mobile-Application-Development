class PostDataUiModal {
  final String userId;
  final String id;
  final String title;
  final String body;

  PostDataUiModal({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor to create a Post instance from JSON
  factory PostDataUiModal.fromJson(Map<String, dynamic> json) {
    return PostDataUiModal(
      userId: json['userId'].toString(),
      id: json['id'].toString(),
      title: json['title'].toString(),
      body: json['body'].toString(),
    );
  }

  // Method to convert a Post instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
