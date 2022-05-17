import 'package:cuk/model/interface/parse_interface.dart';
import 'package:html/dom.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class ParseImpl implements ParseInterface {
  @override
  Future get(String uri) async {
    var url = Uri.parse(uri);
    var response = await http.Client().get(url);
    var docs = parser.parse(response.body);
    return docs;
  }

  Future getCount(Document docs) async {
    docs.getElementsByClassName('cnt');
  }

  Future getNotice(Document docs) async {
    List<Map> maps = [];

    List li = docs
        .getElementsByClassName('rbbs_list_normal_sec')
        .first
        .getElementsByTagName('li');
    for (Element e in li) {
      List info = e
          .getElementsByClassName('info_line')
          .first
          .getElementsByTagName('div');
      int authorIndex = (info.length < 4) ? 0 : 1;
      int datetimeIndex = (info.length < 4) ? 1 : 2;

      String? title = e
          .getElementsByClassName('text')[0]
          .firstChild!
          .text
          .toString()
          .replaceAll('\n', '')
          .replaceAll('\t', '');

      String? url = 'https://www.catholic.ac.kr' +
          e.getElementsByTagName('a')[0].attributes['href'].toString();

      String? author = (info[authorIndex] as Element)
          .text
          .replaceAll('\n', '')
          .replaceAll('\t', '')
          .replaceRange(0, 6, '');

      String? datetime = (info[datetimeIndex] as Element)
          .text
          .replaceAll('\n', '')
          .replaceAll('\t', '')
          .replaceRange(0, 6, '');

      bool? flag = e.getElementsByClassName('flag top').isNotEmpty;

      maps.add({
        'title': title,
        'author': author,
        'datetime': datetime,
        'url': url,
        'flag': flag,
      });
    }
    return maps;
  }
}
