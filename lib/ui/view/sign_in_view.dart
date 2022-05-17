import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/sign_up_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _authController = Get.find<AuthController>();
  final _signUpController = Get.put(SignUpController());
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  bool _isVisible = true;
  bool _isIDValidated = false;
  bool _isPWValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 로그인'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Visibility(
            visible: _authController.status == Auth.isAnonymous,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close),
              color: Colors.black,
              padding: const EdgeInsets.all(0.0),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 1),
                        Text(
                          '로그인이 안된다면 아래의 로그인 주의사항을 클릭해주세요.',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            right: 15,
                            left: 15,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 233, 239, 255),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          height: 550.h,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '로그인 주의사항',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2,
                                                  ),
                                                  IconButton(
                                                    onPressed: () => Get.back(),
                                                    icon:
                                                        const Icon(Icons.close),
                                                  )
                                                ],
                                              ),
                                              Expanded(
                                                child: ListView(
                                                  children: [
                                                    Text.rich(
                                                      const TextSpan(
                                                        text: '•',
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                ' CUKCAT의 로그인 정보는 ',
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '가톨릭대 웹메일 정보와는 별개',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          100,
                                                                          75,
                                                                          117,
                                                                          232),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '입니다.',
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' CUKCAT을 이용하실려면 따로 회원가입해주셔야 합니다.\n',
                                                          ),
                                                        ],
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4,
                                                    ),
                                                    Text.rich(
                                                      const TextSpan(
                                                        text: '•',
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '이전 버전의 CUKCAT에서 회원가입한 정보가 있다면, 해당 id, pw로 로그인 해주세요\n',
                                                          ),
                                                        ],
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4,
                                                    ),
                                                    Text.rich(
                                                      const TextSpan(
                                                        text: '•',
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'pw의 경우 영문과 숫자만 허용',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          100,
                                                                          190,
                                                                          61,
                                                                          237),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                ' 됩니다. 이전 버전 사용자분들은 ',
                                                          ),
                                                          TextSpan(
                                                            text: '비밀번호 찾기',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          100,
                                                                          175,
                                                                          214,
                                                                          85),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '를 통해 비밀번호를 초기화한 뒤 로그인해주세요.\n',
                                                          ),
                                                        ],
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4,
                                                    ),
                                                    Text.rich(
                                                      const TextSpan(
                                                        text: '•',
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                ' 회원가입후 인증메일을 요청했지만 ',
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '메일이 도착하지 않은 경우,',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          100,
                                                                          66,
                                                                          183,
                                                                          84),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '회원가입을 진행한 계정으로 다시 로그인해주시면 인증메일을 다시 발송할 수 있는 창이 표시됩니다.\n',
                                                          ),
                                                        ],
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4,
                                                    ),
                                                    Text.rich(
                                                      const TextSpan(
                                                        text: '•',
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                ' 그 외 문제가 발생한다면,',
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '앱을 완전히 종료 후 다시 시작',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          100,
                                                                          202,
                                                                          180,
                                                                          36),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '해주시면 감사드리겠습니다.',
                                                          ),
                                                        ],
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4,
                                                    ),
                                                    SizedBox(height: 30.h),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        8.0,
                                                      ),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                          255,
                                                          233,
                                                          239,
                                                          255,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            10,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            '위 과정으로도 해결할 수 없다면\n왼쪽의 \'문의하기\'버튼을 클릭해주세요.',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                WebController
                                                                    .toLaunch(
                                                              'https://docs.google.com/forms/d/e/1FAIpQLSdeQvXRHbMwPR49yqb15NpI-r9pIKHnSo6Uaw61QfD4IAI38w/viewform?usp=sf_link',
                                                            ),
                                                            child: const Text(
                                                                '문의하기'),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        isScrollControlled: true,
                                      );
                                    },
                                    child: const Text('로그인 주의사항'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 2),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: id,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (val) {
                                    _isIDValidated = false;
                                    if (val == null || val.isEmpty) {
                                      return '이메일을 입력하세요.';
                                    } else {
                                      switch (
                                          _signUpController.validateID(val)) {
                                        case Validate.containSpecialChar:
                                          return '@ 이후로는 입력하실 필요없어요.';
                                        case Validate.pass:
                                          _isIDValidated = true;
                                          return null;
                                        default:
                                          return null;
                                      }
                                    }
                                  },
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    filled: false,
                                    labelText: 'ID',
                                    hintText: '웹메일 입력',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '@catholic.ac.kr',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, top: 20),
                          child: TextFormField(
                            controller: pw,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (val) {
                              _isPWValidated = false;
                              if (val == null || val.isEmpty) {
                                return '비밀번호를 입력하세요.';
                              } else {
                                switch (_signUpController.validatePW(val)) {
                                  case Validate.pass:
                                    _isPWValidated = true;
                                    return null;
                                  default:
                                    return null;
                                }
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isVisible,
                            decoration: InputDecoration(
                              focusColor:
                                  const Color.fromARGB(255, 105, 132, 197),
                              filled: false,
                              labelText: 'PW',
                              hintText: '비밀번호 입력',
                              border: const UnderlineInputBorder(),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                                child: Icon(
                                  _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      const Color.fromARGB(255, 175, 175, 175),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 2),
                        ElevatedButton(
                          onPressed: () async {
                            if (_isIDValidated && _isPWValidated) {
                              await _authController.signIn(
                                  id.text + '@catholic.ac.kr', pw.text);
                            } else {
                              Get.snackbar(
                                  '잘못된 요청', '로그인 주의사항을 확인하고 다시 로그인해주세요.');
                            }
                          },
                          child: const Text('로그인'),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Service.PW_RESET_ROUTE),
                          child: Text(
                            '비밀번호 찾기',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Visibility(
                          visible: _authController.status != Auth.isAnonymous,
                          child: TextButton(
                            onPressed: () async {
                              await _authController.signInAnonymously();
                            },
                            child: Text(
                              '로그인 없이 사용하기',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          icon: const Icon(Icons.mail),
                          onPressed: () => WebController.toLaunch(
                            'https://mail.catholic.ac.kr/',
                          ),
                          label: const Text(
                            '가톨릭대 웹메일 바로가기',
                          ),
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.w),
                  child: TextButton(
                    onPressed: () => Get.toNamed(Service.SIGN_UP_ROUTE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'CUKCAT 계정이 없으신가요?',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const Text('회원가입'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
