import 'package:cuk/asset/data/schinfo.dart';
import 'package:cuk/asset/data/status.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController rePw = TextEditingController();
  TextEditingController name = TextEditingController();

  final _signUpController = Get.put(SignUpController());
  final _authController = Get.put(AuthController());
  String defaultMajor = SchInfo.major[0];
  String defaultBranch = SchInfo.branch[0];

  @override
  Widget build(BuildContext context) {
    bool _isPwVisible = true;
    bool _isRePwVisible = true;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('회원가입'),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
            padding: const EdgeInsets.all(0.0),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            BoardComponent(
              title: '아이디 입력',
              subTitle:
                  'CUKCAT은 가톨릭대학교 웹메일을 아이디로 사용합니다.\n현재 사용중인 가톨릭대학교 웹메일을 입력해주세요:)',
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 20),
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
                              _signUpController.isIDValidated = false;
                              if (val == null || val.isEmpty) {
                                return '이메일을 입력하세요.';
                              } else {
                                switch (_signUpController.validateID(val)) {
                                  case Validate.containSpecialChar:
                                    return '@ 이후로는 입력하실 필요없어요.';
                                  case Validate.pass:
                                    _signUpController.id =
                                        val + '@catholic.ac.kr';
                                    _signUpController.isIDValidated = true;
                                    return null;
                                  default:
                                    return '잘못된 입력입니다.';
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
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 233, 239, 255),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            if (_signUpController.isIDValidated) {
                              await _signUpController.fetchID();
                            }
                          },
                          child: const Text('아이디 중복 확인'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BoardComponent(
              title: '비밀번호 입력',
              subTitle:
                  '로그인 시 사용할 계정의 비밀번호를 입력해주세요.\n비밀번호는 6자리 이상, 영문 및 숫자 필수 포함이여야 합니다.',
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                child: TextFormField(
                  controller: pw,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    _signUpController.pw = '';
                    if (val == null || val.isEmpty) {
                      return '비밀번호를 입력하세요.';
                    } else {
                      switch (_signUpController.validatePW(val)) {
                        case Validate.containSpace:
                          return '띄어쓰기는 포함할 수 없습니다.';
                        case Validate.minLength:
                          return '6자리 이상이여야 합니다.';
                        case Validate.maxLength:
                          return '15자리 이하이여야 합니다.';
                        case Validate.notContainNumber:
                          return '숫자를 포함해야 합니다.';
                        case Validate.containSpecialChar:
                          return '특수문자는 포함할 수 없습니다.';
                        case Validate.pass:
                          _signUpController.pw = val;
                          return null;
                        default:
                          return '알 수 없는 에러, 관리자에게 문의하세요.';
                      }
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isPwVisible,
                  decoration: InputDecoration(
                    focusColor: const Color.fromARGB(255, 105, 132, 197),
                    filled: false,
                    labelText: 'PW',
                    hintText: '비밀번호 입력',
                    border: const UnderlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _isPwVisible = false;
                        });
                      },
                      onLongPressUp: () {
                        setState(() {
                          _isPwVisible = true;
                        });
                      },
                      child: Icon(
                        _isPwVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color.fromARGB(255, 175, 175, 175),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BoardComponent(
              title: '비밀번호 재입력',
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                child: TextFormField(
                  controller: rePw,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    _signUpController.isPWValidated = false;
                    if (val == null || val.isEmpty) {
                      return '비밀번호를 입력하세요.';
                    } else {
                      switch (_signUpController.comparePW(val)) {
                        case Validate.notMatchPW:
                          return '비밀번호가 일치하지 않습니다.';
                        case Validate.pass:
                          _signUpController.isPWValidated = true;
                          return null;
                        case Validate.error:
                        default:
                          return '알 수 없는 에러, 관리자에게 문의하세요.';
                      }
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusColor: const Color.fromARGB(255, 105, 132, 197),
                    filled: false,
                    labelText: 'PW',
                    hintText: '비밀번호 입력',
                    border: const UnderlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRePwVisible = !_isRePwVisible;
                        });
                      },
                      child: Icon(
                        _isRePwVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 175, 175, 175),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BoardComponent(
              title: '닉네임 입력',
              subTitle:
                  'CUKCAT에서 사용할 이름을 입력해주세요.\n닉네임은 2 ~ 6 글자이여야 하며, 한글, 영어, 숫자만 사용가능합니다.',
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                child: TextFormField(
                  controller: name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  validator: (val) {
                    _signUpController.name = '';
                    _signUpController.isNameValidated = false;
                    if (val == null || val.isEmpty) {
                      return '닉네임을 입력하세요.';
                    } else {
                      switch (_signUpController.validateName(val)) {
                        case Validate.containSpace:
                          return '띄어쓰기는 포함할 수 없습니다.';
                        case Validate.minLength:
                          return '2글자 이상이여야 합니다.';
                        case Validate.maxLength:
                          return '6글자 이하이여야 합니다.';
                        case Validate.uncompliteWord:
                          return '형식에 맞지 않는 닉네임입니다.';
                        case Validate.pass:
                          _signUpController.name = val;
                          _signUpController.isNameValidated = true;
                          return null;
                        default:
                          return '알 수 없는 에러, 관리자에게 문의하세요.';
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    filled: false,
                    labelText: '닉네임 입력',
                    hintText: 'ex) 푸드파이터',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 20.h,
              color: const Color.fromARGB(255, 233, 239, 255),
            ),
            BoardComponent(
              title: '교정 입력',
              subTitle: '(Optional)재학중인 교정을 선택하세요.\n선택하지 않을 시, 미기입으로 선택됩니다.',
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                child: DropdownButton<String>(
                  value: defaultBranch,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  elevation: 16,
                  style: Theme.of(context).textTheme.headline5,
                  underline: Container(
                    height: 1,
                    color: Colors.black26,
                  ),
                  onChanged: (String? newValue) {
                    _signUpController.branch = newValue!;
                    setState(() {
                      defaultBranch = newValue.toString();
                    });
                  },
                  items: SchInfo.branch
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            BoardComponent(
              title: '학과 선택',
              subTitle: '(Optional)본인의 학과를 선택하세요.\n선택하지 않을 시, 미기입으로 선택됩니다.',
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
                child: DropdownButton<String>(
                  value: defaultMajor,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  elevation: 16,
                  style: Theme.of(context).textTheme.headline5,
                  underline: Container(
                    height: 1,
                    color: Colors.black26,
                  ),
                  onChanged: (String? newValue) {
                    _signUpController.major = newValue!;
                    setState(() {
                      defaultMajor = newValue.toString();
                    });
                  },
                  items: SchInfo.major
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0),
              child: ElevatedButton(
                child: const Text('회원가입'),
                onPressed: () async {
                  if (_signUpController.isIDFetched) {
                    if (_signUpController.isIDValidated &&
                        _signUpController.isPWValidated &&
                        _signUpController.isNameValidated) {
                      Map<String, dynamic> map = {
                        'id': _signUpController.id,
                        'pw': _signUpController.pw,
                        'name': _signUpController.name,
                        'branch': _signUpController.branch,
                        'major': _signUpController.major,
                      };
                      await _authController.signUp(map);
                    } else {
                      Get.snackbar('알 수 없는 에러', '앱 종료후 다시 시도해주세요.');
                    }
                  } else {
                    Get.snackbar('중복확인 미실시', '아이디 중복확인 버튼을 눌러주세요.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
