class NoticeVO {
  int? id;
  late String type;
  late String title;
  late String author;
  late String datetime;
  late String url;

  NoticeVO({
    this.id,
    required this.type,
    required this.title,
    required this.author,
    required this.datetime,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? -1,
      'type': type,
      'title': title,
      'author': author,
      'datetime': datetime,
      'url': url,
    };
  }

  @override
  String toString() {
    return '{id:$id ,type:$type, title:$title, author:$author, datetime:$datetime, url:$url}';
  }
}
