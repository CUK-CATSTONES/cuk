import 'package:carousel_slider/carousel_slider.dart';
import 'package:cuk/asset/data/auth.dart';
import 'package:cuk/asset/data/service.dart';
import 'package:cuk/ui/component/board_component.dart';
import 'package:cuk/ui/widget/edge_button_widget.dart';
import 'package:cuk/ui/widget/flatile_lg_widget.dart';
import 'package:cuk/ui/widget/icon_tile_widget.dart';
import 'package:cuk/ui/widget/flatile_md_widget.dart';
import 'package:cuk/view_model/controller/auth_controller.dart';
import 'package:cuk/view_model/controller/notice_pin_controller.dart';
import 'package:cuk/view_model/controller/slot_controller.dart';
import 'package:cuk/view_model/controller/user_controller.dart';
import 'package:cuk/view_model/controller/web_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future _initSlot;
  late Future _initPin;
  final _slotController = Get.put(SlotController());
  final _noticePinController = Get.put(NoticePinController());
  final _userController = Get.put(UserController());
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _initSlot = _slotController.readSlot();
    _initPin = _noticePinController.readAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CUKCAT',
          style: TextStyle(color: Color.fromARGB(255, 47, 84, 170)),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Service.PUSH_NOTI_ROUTE),
            icon: const Icon(CupertinoIcons.bell_fill),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 130.h,
            titleSpacing: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              background: _authController.status == Auth.emailVerified
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 15.w),
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 233, 239, 255),
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Icon(
                            Icons.person,
                            color: const Color.fromARGB(255, 47, 84, 170),
                            size: 40.sp,
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userController.user!.name,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              _userController.user!.branch.toString(),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              _userController.user!.major.toString(),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                        const Spacer(flex: 1),
                        EdgeButtonWidget(
                          onTap: () => Get.toNamed(Service.SETTING_ROUTE),
                          icon: Icons.settings,
                          iconColor: const Color.fromARGB(255, 47, 84, 170),
                        ),
                        SizedBox(width: 15.w),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 15.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '익명 계정입니다.',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              '\n로그인하여 CukCat에서\n제공하는 서비스를 사용해보세요:)',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                        const Spacer(flex: 1),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: 90.w),
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(
                              Service.SIGN_IN_ROUTE,
                            ),
                            child: const Text('바로가기'),
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                      ],
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              BoardComponent(
                title: 'Services',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTileWidget(
                      title: Service.list[0]['title'],
                      icon: Service.list[0]['icon'],
                      iconColor: Service.list[0]['color'],
                      onTap: () => Get.toNamed(Service.list[0]['route']),
                    ),
                    IconTileWidget(
                      title: Service.list[1]['title'],
                      icon: Service.list[1]['icon'],
                      iconColor: Service.list[1]['color'],
                      onTap: () => Get.toNamed(Service.list[1]['route']),
                    ),
                    IconTileWidget(
                      title: Service.list[2]['title'],
                      icon: Service.list[2]['icon'],
                      iconColor: Service.list[2]['color'],
                      onTap: () => Get.toNamed(Service.list[2]['route']),
                    ),
                    IconTileWidget(
                      icon: Icons.more_horiz,
                      color: const Color.fromARGB(255, 201, 214, 241),
                      iconColor: const Color.fromARGB(255, 233, 239, 255),
                      onTap: () => null,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  BoardComponent(
                    title: '공지사항 PIN',
                    edge: InkWell(
                      onTap: () => Get.offAllNamed(Service.NOTICE_PIN_ROUTE),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Color.fromARGB(255, 104, 128, 182),
                      ),
                    ),
                    paddingR: 0.0,
                    paddingL: 0.0,
                    child: FutureBuilder(
                      future: _initPin,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            return Obx(
                              () => CarouselSlider(
                                options: CarouselOptions(
                                  height: _noticePinController.list.isEmpty
                                      ? 50.h
                                      : 120.h,
                                  viewportFraction: 1.0,
                                  autoPlay:
                                      _noticePinController.list.length > 1,
                                  autoPlayInterval: const Duration(seconds: 5),
                                ),
                                items: _noticePinController.list.isEmpty
                                    ? [
                                        InkWell(
                                          onTap: () =>
                                              Get.toNamed(Service.NOTICE_ROUTE),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 10.0.w,
                                              right: 10.0.w,
                                            ),
                                            width: double.infinity,
                                            child: const Center(
                                              child: Icon(
                                                Icons.add_circle_rounded,
                                                color: Color.fromARGB(
                                                    255, 118, 135, 197),
                                              ),
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 201, 214, 241),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]
                                    : _noticePinController.list.map((notice) {
                                        return FlatileWidget_lg(
                                          marginL: 10.w,
                                          marginR: 10.w,
                                          onTap: () =>
                                              WebController.toWebView(notice),
                                          title: notice.title,
                                          valueL: notice.author,
                                          valueM: notice.datetime,
                                          valueR: notice.type,
                                          elevation: 0.0,
                                          leading: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 253, 255, 238),
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                            ),
                                            child: Icon(
                                              Icons.widgets,
                                              color: const Color.fromARGB(
                                                  255, 249, 194, 0),
                                              size: 30.sp,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: _authController.status == Auth.isAnonymous,
                    child: Container(
                      width: double.infinity,
                      height: 180.h,
                      color: const Color.fromARGB(160, 0, 0, 0),
                      child: Center(
                        child: Text(
                          '로그인 후 이용할 수 있습니다.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BoardComponent(
                title: '바로가기',
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: _initSlot,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            if (_slotController.slot.isEmpty) {
                              return Container(
                                height: 150.h,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 233, 239, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sp)),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '등록된 링크가 없어요',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    Align(
                                      child: ElevatedButton(
                                        onPressed: () => Get.offAllNamed(
                                          Service.SCHLINK_ROUTE,
                                        ),
                                        child: const Text('교내 링크 보러가기'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Obx(
                                  () => Column(
                                    children: _slotController.slot
                                        .map(
                                          (element) => FlatileWidget_md(
                                            title: element.title,
                                            subtitle: element.description,
                                            icon: IconData(
                                              element.icon,
                                              fontFamily: 'MaterialIcons',
                                            ),
                                            iconColor: Color(element.color),
                                            onTap: () {
                                              WebController.toLaunch(
                                                element.url,
                                              );
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Align(
                                  child: ElevatedButton(
                                    onPressed: () => Get.toNamed(
                                      Service.EDIT_SLOT_ROUTE,
                                    ),
                                    child: const Text('수정하기'),
                                  ),
                                ),
                              ],
                            );
                        }
                      },
                    ),
                    SizedBox(height: 130.h)
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
