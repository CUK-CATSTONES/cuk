class SchLinkVO {
  late String title;
  late String description;
  late int icon;
  late int color;
  late String url;

  SchLinkVO({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon,
      'color': color,
      'url': url,
      'description': description,
    };
  }

  @override
  String toString() {
    return '{title:$title, icon:$icon, color:$color, url:$url, description:$description}';
  }
}
