import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/font.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/splash.dart';
import 'package:cuk/ui/view/edit_info_view.dart';
import 'package:cuk/ui/view/home_view.dart';
import 'package:cuk/ui/view/notice_pin_view.dart';
import 'package:cuk/ui/view/notice_view.dart';
import 'package:cuk/ui/view/push_noti_view.dart';
import 'package:cuk/ui/view/pw_reset_view.dart';
import 'package:cuk/ui/view/schlink_view.dart';
import 'package:cuk/ui/view/setting_view.dart';
import 'package:cuk/ui/view/sign_in_view.dart';
import 'package:cuk/ui/view/sign_up_view.dart';
import 'package:cuk/ui/view/edit_slot_view.dart';
import 'package:cuk/ui/view/tag_noti_view.dart';
import 'package:cuk/ui/view/web_frame_view.dart';
import 'package:cuk/ui/view/withdraw_view.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final _authController = Get.put(AuthController());

  FirebaseAuth auth = FirebaseAuth.instance;

  auth.authStateChanges().listen((User? user) async {
    Auth _status;
    if (user == null) {
      // 로그아웃
      _status = Auth.signOut;
    } else {
      if (user.isAnonymous) {
        // 익명 로그인
        _status = Auth.isAnonymous;
      } else {
        if (!user.emailVerified) {
          // 인증되지 않은 로그인
          _status = Auth.signIn;
        } else {
          // 인증된 로그인
          _status = Auth.emailVerified;
        }
      }
    }
    await _authController.setStatus(_status);
  });
  runApp(const Cuk());
}

class Cuk extends StatelessWidget {
  const Cuk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CUKCAT',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 47, 84, 170),
          scaffoldBackgroundColor: const Color.fromARGB(255, 233, 239, 255),
          fontFamily: Font.Pretendard.name,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 22.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.EliceDigitalBaeum.name,
              fontWeight: FontWeight.w900,
            ),
            headline2: TextStyle(
              fontSize: 18.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.EliceDigitalBaeum.name,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 18.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              fontSize: 17.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.normal,
            ),
            headline5: TextStyle(
              fontSize: 13.5.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.normal,
            ),
            headline6: TextStyle(
              fontSize: 13.sp,
              color: const Color.fromARGB(255, 145, 145, 145),
              fontWeight: FontWeight.normal,
            ),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color.fromARGB(255, 47, 84, 170),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            iconColor: Color.fromARGB(255, 47, 84, 170),
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 105, 132, 197),
            ),
            fillColor: Color.fromARGB(255, 233, 239, 255),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                width: 0.0,
                style: BorderStyle.none,
              ),
            ),
            focusColor: Color.fromARGB(255, 255, 255, 255),
            contentPadding: EdgeInsets.only(left: 20, right: 20),
          ),
          appBarTheme: AppBarTheme(
            color: const Color.fromARGB(255, 255, 255, 255),
            elevation: 0.0,
            centerTitle: false,
            titleTextStyle: TextStyle(
              fontSize: 22.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.EliceDigitalBaeum.name,
              fontWeight: FontWeight.w900,
            ),
            actionsIconTheme: IconThemeData(
              color: const Color.fromARGB(255, 47, 84, 170),
              size: 25.sp,
            ),
          ),
          iconTheme: IconThemeData(
            color: const Color.fromARGB(255, 0, 0, 0),
            size: 20.sp,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              fixedSize: Size(255.w, 30.h),
              primary: const Color.fromARGB(255, 47, 84, 170),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.sp),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              fixedSize: Size(255.w, 30.h),
              primary: const Color.fromARGB(255, 47, 84, 170),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.sp),
                ),
              ),
            ),
          ),
          snackBarTheme: const SnackBarThemeData(
            contentTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            actionTextColor: Color.fromARGB(255, 0, 0, 0),
            disabledActionTextColor: Color.fromARGB(255, 0, 0, 0),
          ),
          bottomSheetTheme: BottomSheetThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              ),
            ),
          ),
          cardTheme: const CardTheme(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(11.0),
              ),
            ),
            elevation: 5.0,
            shadowColor: Color.fromARGB(255, 233, 239, 255),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 47, 84, 170),
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        initialRoute: Service.SPLASH_ROUTE,
        getPages: [
          GetPage(
            name: Service.SPLASH_ROUTE,
            page: () => const Splash(),
          ),
          GetPage(
            name: Service.HOME_ROUTE,
            page: () => const HomeView(),
          ),
          GetPage(
            name: Service.SIGN_IN_ROUTE,
            page: () => const SignInView(),
          ),
          GetPage(
            name: Service.SIGN_UP_ROUTE,
            page: () => const SignUpView(),
          ),
          GetPage(
            name: Service.SCHLINK_ROUTE,
            page: () => SchLinkView(),
          ),
          GetPage(
            name: Service.NOTICE_ROUTE,
            page: () => const NoticeView(),
          ),
          GetPage(
            name: Service.NOTICE_PIN_ROUTE,
            page: () => const NoticePinView(),
          ),
          GetPage(
            name: Service.EDIT_SLOT_ROUTE,
            page: () => const EditSlotView(),
          ),
          GetPage(
            name: Service.PW_RESET_ROUTE,
            page: () => const PwResetView(),
          ),
          GetPage(
            name: Service.SETTING_ROUTE,
            page: () => SettingView(),
          ),
          GetPage(
            name: Service.PUSH_NOTI_ROUTE,
            page: () => const PushNotiView(),
          ),
          GetPage(
            name: Service.WEB_LAUNCH_ROUTE,
            page: () => const WebFrameView(),
          ),
          GetPage(
            name: Service.EDIT_INFO_ROUTE,
            page: () => const EditInfoView(),
          ),
          GetPage(
            name: Service.WITHDRAW_ROUTE,
            page: () => const WithdrawView(),
          ),
          GetPage(
            name: Service.TAG_NOTI_ROUTE,
            page: () => const TagNotiView(),
          ),
        ],
      ),
    );
  }
}
