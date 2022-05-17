import 'dart:developer';

import 'package:cuk/asset/data/status.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PwResetView extends StatefulWidget {
  const PwResetView({Key? key}) : super(key: key);

  @override
  State<PwResetView> createState() => _PwResetViewState();
}

class _PwResetViewState extends State<PwResetView> {
  final _authController = Get.find<AuthController>();
  final _signUpController = Get.put(SignUpController());
  TextEditingController id = TextEditingController();
  bool _isIDValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 초기화'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
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
                            '비밀번호 초기화를 위해 아이디를 입력하세요.',
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
                    const Spacer(flex: 1),
                    ElevatedButton(
                      onPressed: () async {
                        if (_isIDValidated) {
                          await _authController
                              .resetPW(id.text + '@catholic.ac.kr');
                        } else {
                          log('잘못된 요청');
                        }
                      },
                      child: const Text('비밀번호 초기화'),
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
