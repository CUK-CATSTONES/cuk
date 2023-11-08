class LostFindVO {
  int? id;
  late String type;
  late String title;
  late String author;
  late String datetime;
  late String image;

  LostFindVO({
    this.id,
    required this.type,
    required this.title,
    required this.author,
    required this.datetime,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? -1,
      'type': type,
      'title': title,
      'author': author,
      'datetime': datetime,
      'image': image,
    };
  }

  @override
  String toString() {
    return '{id:$id ,type:$type, title:$title, author:$author, datetime:$datetime, image:$image}';
  }
}
