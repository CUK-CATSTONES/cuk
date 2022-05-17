import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotiView extends StatefulWidget {
  const PushNotiView({Key? key}) : super(key: key);

  @override
  State<PushNotiView> createState() => _PushNotiViewState();
}

class _PushNotiViewState extends State<PushNotiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
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
      body: Container(),
    );
  }
}
