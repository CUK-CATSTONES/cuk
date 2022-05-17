// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Service {
  static String SPLASH_ROUTE = '/';
  static String HOME_ROUTE = '/home';
  static String SIGN_IN_ROUTE = '/sign-in';
  static String SIGN_UP_ROUTE = '/sign-up';
  static String PW_RESET_ROUTE = '/sign/pw';
  static String SCHLINK_ROUTE = '/schlink';
  static String NOTICE_ROUTE = '/notice';
  static String NOTICE_PIN_ROUTE = '/notice/pin';
  static String TAG_NOTI_ROUTE = '/notice/tag';
  static String EDIT_SLOT_ROUTE = '/slot/edit';
  static String SETTING_ROUTE = '/setting';
  static String PUSH_NOTI_ROUTE = '/push-noti';
  static String EDIT_INFO_ROUTE = '/edit-info';
  static String WITHDRAW_ROUTE = '/withdraw';
  static String WEB_LAUNCH_ROUTE = '/web-launch/:param';

  static List list = [
    {
      'title': '링크 모아보기',
      'icon': Icons.link,
      'color': const Color.fromARGB(255, 53, 180, 81),
      'route': SCHLINK_ROUTE,
    },
    {
      'title': '공지사항',
      'icon': CupertinoIcons.bell,
      'color': const Color.fromARGB(255, 180, 161, 53),
      'route': NOTICE_ROUTE,
    },
    {
      'title': '태그 알림',
      'icon': CupertinoIcons.tag,
      'color': const Color.fromARGB(255, 53, 76, 180),
      'route': TAG_NOTI_ROUTE,
    },
  ];
}
