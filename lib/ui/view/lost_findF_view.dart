import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/lostfind.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/ui/view/lost_findL_view.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/lost_find_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LostFindFView extends StatefulWidget {
  const LostFindFView({Key? key}) : super(key: key);

  @override
  _LostFindFViewState createState() => _LostFindFViewState();
}

class _LostFindFViewState extends State<LostFindFView> {
  final _lostFindController = Get.put(LostFindController());
  final _authController = Get.find<AuthController>();
  final List<bool> isSelected = [false, true];
  final List<String> category = ['유실물', '내가 찾는 물건'];
  int target = 0;
  bool isExpanded = true;
  late Future search;
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    search = _lostFindController.search(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('유실물 찾기'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _lostFindController.input.clear();
          _lostFindController.reset();
          await _lostFindController.search(target);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              toolbarHeight: 70.h,
              title: Container(
                height: 70.h,
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: TextFormField(
                    controller: _lostFindController.input,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onEditingComplete: () async {
                      _lostFindController.reset();
                      await _lostFindController.search(target);
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      // hintText: 'search',
                    ),
                  ),
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              toolbarHeight: 55.h,
              title: Container(
                width: double.infinity,
                height: 55.h,
                color: const Color.fromARGB(255, 233, 239, 255),
                child: Center(
                  child: Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 35,
                    child: ToggleButtons(
                      borderColor: const Color.fromARGB(0, 255, 255, 255),
                      constraints:
                          BoxConstraints.tight(const Size(355 / 2, 35)),
                      color: const Color.fromARGB(75, 47, 84, 170),
                      selectedColor: const Color.fromARGB(255, 255, 255, 255),
                      selectedBorderColor:
                          const Color.fromARGB(255, 47, 84, 170),
                      fillColor: const Color.fromARGB(255, 47, 84, 170),
                      splashColor: const Color.fromARGB(255, 47, 84, 170),
                      hoverColor: const Color.fromARGB(255, 47, 84, 170),
                      borderRadius: BorderRadius.circular(4.0),
                      isSelected: isSelected,
                      onPressed: (index) async {
                        if (!isSelected[index]) {
                          setState(() {
                            isSelected[target] = !isSelected[target];
                            isSelected[index] = !isSelected[index];
                            target = index;
                            if (target == 1) {
                              Get.to(LostFindLView(),
                                  transition: Transition.noTransition);
                              // Get.offNamed('/lost-findF');
                            } else {
                              Get.offNamed('/lost-find');
                            }
                            isExpanded = true;
                          });
                        }
                        _lostFindController.input.clear();
                        _lostFindController.reset();
                        await _lostFindController.search(target);
                      },
                      children: [
                        Text(LostFind.category[0]),
                        Text(LostFind.category[1]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              titleSpacing: 0.0,
              toolbarHeight: 115.h,
              expandedHeight: 115.h,
              title: Container(
                width: double.infinity,
                height: 115.h,
                color: const Color.fromARGB(255, 233, 239, 255),
                child: BoardComponent(
                  title: '나의 태그',
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Color.fromRGBO(192, 209, 255, 1.0),
                          minimumSize: Size(52, 30),
                          maximumSize: Size(52, 30),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/lost-find/cukcat');
                          // print('전체');
                        },
                        child: Text('전체'),
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      Container(
                        child: Text(
                          '태그를 등록하고 알림을 받아보세요:)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(138, 138, 138, 1.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(75, 30),
                          maximumSize: Size(75, 30),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/lost-find/tag');
                        },
                        child: Text('태그 관리'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ExpansionPanelList(
                  elevation: 0.0,
                  animationDuration: const Duration(milliseconds: 700),
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      this.isExpanded = !this.isExpanded;
                    });
                  },
                ),
                BoardComponent(
                  title: '검색결과',
                  paddingR: 0.0,
                  paddingL: 0.0,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: Obx(
                    () => Column(
                      children: [
                        for (var e in _lostFindController.maps['lostfind'])
                          Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  WebController.toWebView(e);
                                },
                                title: Text(
                                  e.title,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                subtitle: Text(
                                  '${e.author}에서 ${e.datetime}에 작성',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        Center(
                          child: _authController.status == Auth.isAnonymous
                              ? TextButton(
                                  onPressed: () =>
                                      Get.toNamed(Service.SIGN_IN_ROUTE),
                                  child: const Text('로그인하여 모든 유실물 찾기 글 보기'),
                                )
                              : _lostFindController.state
                                  ? TextButton.icon(
                                      icon: const Icon(Icons.add),
                                      label: const Text('더 불러오기'),
                                      onPressed: () async {
                                        _lostFindController.state = false;
                                        setState(() {});
                                        await _lostFindController
                                            .search(target);
                                      },
                                    )
                                  : const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}