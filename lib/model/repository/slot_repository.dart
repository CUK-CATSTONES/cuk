import 'package:cuk/model/repository/impl/sqflite_impl.dart';
import 'package:cuk/model/vo/schlink_vo.dart';

class SlotRepository with SqfliteImpl {
  static String table = 'slots';
  List<SchLinkVO> slot = [];

  Future<String> readAll() async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      List<Map> list = await super.read('SELECT * FROM slots');
      slot = List.generate(
        list.length,
        (index) => SchLinkVO(
          title: list[index]['title'],
          description: list[index]['description'],
          icon: list[index]['icon'],
          color: list[index]['color'],
          url: list[index]['url'],
        ),
      );
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  Future<String> deleteAll() async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }
    try {
      await super.delete('DELETE FROM slots', []);
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  // Future<String> delete() async {
  //   //
  // }

  Future<String> insertAll(List list) async {
    try {
      await super.setDB();
    } catch (e) {
      return e.toString();
    }

    try {
      await deleteAll();
    } catch (e) {
      return e.toString();
    }

    try {
      for (SchLinkVO element in list) {
        Map<String, dynamic> maps = element.toMap();
        await super.insert(
          'INSERT INTO slots(title, description, icon, color, url) VALUES(?, ?, ?, ?, ?)',
          [
            maps['title'],
            maps['description'],
            maps['icon'],
            maps['color'],
            maps['url'],
          ],
        );
      }
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }
}
