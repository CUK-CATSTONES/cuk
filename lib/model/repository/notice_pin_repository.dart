import 'package:cuk/model/repository/impl/sqflite_impl.dart';
import 'package:cuk/model/vo/notice_vo.dart';

class NoticePinRepository extends SqfliteImpl {
  List<NoticeVO> pin = [];

  Future readAll() async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      List<Map> list = await super.read('SELECT * FROM notices');
      if (list.isNotEmpty) {
        pin = List.generate(
          list.length,
          (index) => NoticeVO(
            id: list[index]['id'],
            type: list[index]['type'],
            title: list[index]['title'],
            author: list[index]['author'],
            datetime: list[index]['datetime'],
            url: list[index]['url'],
          ),
        );
      }
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  //notices(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, title TEXT, author TEXT, datetime TEXT, url TEXT)'
  Future insertOne(NoticeVO notice) async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      Map map = notice.toMap();
      await super.insert(
        'INSERT INTO notices(type, title, author, datetime, url) VALUES(?, ?, ?, ?, ?)',
        [
          map['type'],
          map['title'],
          map['author'],
          map['datetime'],
          map['url'],
        ],
      );
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  Future deleteArgs(List list) async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      for (NoticeVO notice in list) {
        await super.delete('DELETE FROM notices WHERE id = ?', [notice.id]);
      }
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  Future deleteOne(NoticeVO notice) async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      await super.delete('DELETE FROM notices WHERE id = ?', [notice.id]);
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  Future deleteAll() async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      await super.delete('DELETE FROM notices', []);
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }
}
