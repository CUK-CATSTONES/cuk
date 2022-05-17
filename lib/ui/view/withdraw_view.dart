import 'dart:developer';

import 'package:cuk/asset/data/status.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WithdrawView extends StatefulWidget {
  const WithdrawView({Key? key}) : super(key: key);

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView> {
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
        title: const Text('회원 탈퇴'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
            padding: const EdgeInsets.all(0.0),
          )
        ],
      ),
      body: Center(
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 60.h,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 233, 239, 255),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            '회원탈퇴를 위해 아이디와 비밀번호를 입력해주세요.',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
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
                                  switch (_signUpController.validateID(val)) {
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
                      padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 20),
                      child: TextFormField(
                        controller: pw,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          focusColor: const Color.fromARGB(255, 105, 132, 197),
                          filled: false,
                          labelText: 'PW',
                          hintText: '비밀번호 입력',
                          border: const UnderlineInputBorder(),
                          suffixIcon: GestureDetector(
                            onLongPress: () {
                              setState(() {
                                _isVisible = false;
                              });
                            },
                            onLongPressUp: () {
                              setState(() {
                                _isVisible = true;
                              });
                            },
                            child: Icon(
                              _isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 175, 175, 175),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    ElevatedButton(
                      onPressed: () async {
                        if (_isIDValidated && _isPWValidated) {
                          await _authController.withdraw(
                            id: id.text + '@catholic.ac.kr',
                            pw: pw.text,
                          );
                        } else {
                          log('잘못된 요청');
                        }
                      },
                      child: const Text('탈퇴하기'),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
