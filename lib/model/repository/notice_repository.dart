// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cuk/asset/data/notice.dart';
import 'package:cuk/model/repository/impl/parse_impl.dart';
import 'package:cuk/model/vo/notice_vo.dart';

class NoticeRepository extends ParseImpl {
  List<NoticeVO> flag = [];
  List<NoticeVO> list = [];

  Future<String> read(int index, String input, int page) async {
    var docs;
    try {
      docs = await super.get(
        'https://www.catholic.ac.kr/front/boardlist.do?bbsConfigFK=${19 + index}&cmsDirPkid=2053&cmsLocalPkid=${index + 1}&searchField=ALL&searchValue=$input&currentPage=$page&searchLowItem=ALL',
      );
    } catch (e) {
      return e.toString();
    }
    try {
      List all = await super.getNotice(docs);
      for (Map e in all) {
        if (e['flag']) {
          flag.add(
            NoticeVO(
              type: Notice.category[index],
              title: e['title'],
              author: e['author'],
              datetime: e['datetime'],
              url: e['url'],
            ),
          );
        } else {
          list.add(
            NoticeVO(
              type: Notice.category[index],
              title: e['title'],
              author: e['author'],
              datetime: e['datetime'],
              url: e['url'],
            ),
          );
        }
      }
    } catch (e) {
      return e.toString();
    }

    return 'success';
  }
}
