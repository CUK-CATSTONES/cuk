class UserVO {
  String id = '-';
  String uid = '-';
  String name = '-';
  String? major = '미기입';
  String? branch = '미기입';

  UserVO({
    required this.id,
    required this.uid,
    required this.name,
    this.major,
    this.branch,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'major': major,
      'branch': branch,
    };
  }

  UserVO.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    uid = map['uid'];
    name = map['name'];
    major = map['major'];
    branch = map['branch'];
  }

  @override
  String toString() {
    return '{id:$id, name:$name, uid:$uid, major:$major, branch:$branch}';
  }
}
