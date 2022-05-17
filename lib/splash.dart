import 'dart:async';

import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _authController = Get.find<AuthController>();
  final _userController = Get.put(UserController());
  late Future init;

  @override
  void initState() {
    super.initState();
    init = initCuk();
  }

  Future initCuk() async {
    Timer(const Duration(seconds: 1), () async {
      switch (_authController.status) {
        case Auth.signIn:
          await _authController.signOut();
          break;
        case Auth.signOut:
          Get.offAllNamed(Service.SIGN_IN_ROUTE);
          break;
        case Auth.emailVerified:
          await _userController.readUserInfoInDB();
          break;
        case Auth.isAnonymous:
          Get.offAllNamed(Service.HOME_ROUTE);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: init,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Center(
                child: Image.asset(
                  'lib/asset/images/splash.jpg',
                  height: 130.h,
                  width: 300.w,
                ),
              ),
            );
          },
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
