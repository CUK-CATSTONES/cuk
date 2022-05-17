import 'package:cuk/asset/data/service.dart';
import 'package:cuk/model/vo/notice_vo.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebController {
  static late NoticeVO noticeVO;
  static final WebController _instance = WebController._internal();

  static Future<void> toLaunch(String url) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'Could not launch $url';
  }

  static Future<void> toWebView(dynamic object) async {
    switch (object.runtimeType) {
      case NoticeVO:
        noticeVO = object as NoticeVO;
        Get.toNamed(
          Service.WEB_LAUNCH_ROUTE,
          arguments: object.url,
        );
        break;
    }
  }

  factory WebController() {
    return _instance;
  }

  WebController._internal();
}
