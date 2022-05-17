import 'package:carousel_slider/carousel_slider.dart';
import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/notice.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/ui/widget/flatile_lg_widget.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/notice_controller.dart';
import 'package:cuk/view_model/controller/notice_pin_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoticeView extends StatefulWidget {
  const NoticeView({Key? key}) : super(key: key);

  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  final _noticeController = Get.put(NoticeController());
  final _noticePinController = Get.find<NoticePinController>();
  final _authController = Get.find<AuthController>();
  final List<bool> isSelected = [true, false, false, false];
  final List<String> category = ['일반', '학사', '장학', '취ㆍ창업'];
  int target = 0;
  bool isExpanded = true;
  late Future search;
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    search = _noticeController.search(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
            color: Colors.black,
            padding: const EdgeInsets.all(0.0),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _noticeController.input.clear();
          _noticeController.reset();
          await _noticeController.search(target);
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
                    controller: _noticeController.input,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onEditingComplete: () async {
                      _noticeController.reset();
                      await _noticeController.search(target);
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'search',
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
                          BoxConstraints.tight(const Size(355 / 4, 35)),
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
                            isExpanded = true;
                          });
                        }
                        _noticeController.input.clear();
                        _noticeController.reset();
                        await _noticeController.search(target);
                      },
                      children: [
                        Text(Notice.category[0]),
                        Text(Notice.category[1]),
                        Text(Notice.category[2]),
                        Text(Notice.category[3]),
                      ],
                    ),
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
                  children: [
                    ExpansionPanel(
                      isExpanded: isExpanded,
                      canTapOnHeader: true,
                      backgroundColor: const Color.fromARGB(255, 233, 239, 255),
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Text(
                                "중요 공지",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                          ],
                        );
                      },
                      body: Obx(
                        () => CarouselSlider(
                          options: CarouselOptions(
                            height: _noticeController.flags.length > 1
                                ? 135.h
                                : 0.h,
                            viewportFraction: 1.0,
                            autoPlay: _noticeController.flags.length > 1,
                            autoPlayInterval: const Duration(seconds: 4),
                          ),
                          items: _noticeController.flags.map((e) {
                            return FlatileWidget_lg(
                              marginB: 15.h,
                              marginL: 10.w,
                              marginR: 10.w,
                              title: e.title,
                              valueL: e.author,
                              valueM: e.datetime,
                              valueR: e.type,
                              elevation: 0.0,
                              leading: Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 253, 255, 238),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Icon(
                                  Icons.notification_important,
                                  color: const Color.fromARGB(255, 249, 194, 0),
                                  size: 30.sp,
                                ),
                              ),
                              onTap: () => WebController.toWebView(e),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                BoardComponent(
                  title: '검색결과',
                  paddingR: 0.0,
                  paddingL: 0.0,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: Obx(
                    () => Column(
                      children: [
                        for (var e in _noticeController.maps['notice'])
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
                                  '${e.author} | ${e.datetime} | ${e.type}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      SizedBox(
                                        height: 220.h,
                                        child: BoardComponent(
                                          title: 'More',
                                          backgroundColor: Colors.white,
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () {
                                                      _noticePinController
                                                          .insertOne(e);
                                                      Get.back();
                                                    },
                                                    icon: const Icon(Icons.add),
                                                    label: const Text('PIN 추가'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      fixedSize:
                                                          const Size.fromWidth(
                                                        double.maxFinite,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: _authController
                                                            .status ==
                                                        Auth.isAnonymous,
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50.h,
                                                      color:
                                                          const Color.fromARGB(
                                                              160, 0, 0, 0),
                                                      child: Center(
                                                        child: Text(
                                                          '로그인 후 이용할 수 있습니다.',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              OutlinedButton.icon(
                                                onPressed: () {
                                                  WebController.toLaunch(e.url);
                                                  Get.back();
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                    width: 1.5,
                                                    color: Color.fromARGB(
                                                        255, 47, 84, 170),
                                                  ),
                                                  fixedSize:
                                                      const Size.fromWidth(
                                                    double.maxFinite,
                                                  ),
                                                ),
                                                icon: const Icon(Icons.link),
                                                label: const Text('인터넷 앱으로 보기'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.more_horiz),
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
                                  child: const Text('로그인하여 모든 공지사항 보기'),
                                )
                              : _noticeController.state
                                  ? TextButton.icon(
                                      icon: const Icon(Icons.add),
                                      label: const Text('더 불러오기'),
                                      onPressed: () async {
                                        _noticeController.state = false;
                                        setState(() {});
                                        await _noticeController.search(target);
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
