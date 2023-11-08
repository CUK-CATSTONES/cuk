// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cuk/asset/data/lostfind.dart';
import 'package:cuk/model/repository/impl/parse_impl.dart';
import 'package:cuk/model/vo/lost_find_vo.dart';

class LostFindRepository extends ParseImpl {
  List<LostFindVO> flag = [];
  List<LostFindVO> list = [];

  Future<String> read(int index, String input, int page) async {
    var docs;
    try {
      docs = await super.get(
        // 링크 체크
        'https://www.catholic.ac.kr/front/boardlist.do?bbsConfigFK=${19 + index}&cmsDirPkid=2053&cmsLocalPkid=${index + 1}&searchField=ALL&searchValue=$input&currentPage=$page&searchLowItem=ALL',
      );
    } catch (e) {
      return e.toString();
    }
    try {
      List all = await super.getLostFind(docs);
      for (Map e in all) {
        if (e['flag']) {
          flag.add(
            LostFindVO(
              type: LostFind.category[index],
              title: e['title'],
              author: e['author'],
              datetime: e['datetime'],
              image: e['image'],
            ),
          );
        } else {
          list.add(
            LostFindVO(
              type: LostFind.category[index],
              title: e['title'],
              author: e['author'],
              datetime: e['datetime'],
              image: e['image'],
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
