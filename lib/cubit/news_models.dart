class Articles {
  String? author;
  String? title;
  String? description;


  Articles.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
  }
}
