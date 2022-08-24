import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';

import 'appbar.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
              final asd = Get.find<FluttermojiController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "avatar"),
      body: Container(
        color: Colors.black38,
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FluttermojiCircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 60,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
              child: FluttermojiCustomizer(
                scaffoldWidth: min(600, size.width * 0.85),
                autosave: false,
                theme: FluttermojiThemeData(
                    boxDecoration:
                        const BoxDecoration(boxShadow: [BoxShadow()])),
              ),
            ),
            FluttermojiSaveWidget(
              theme: FluttermojiThemeData(
                  iconColor: const Color.fromARGB(255, 0, 0, 0)),
            )
          ],
        ),
      ),
    );
  }
}
