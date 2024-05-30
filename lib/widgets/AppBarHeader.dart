import 'dart:ui';

import 'package:flutter/material.dart';

PreferredSizeWidget AppBarHeader() {
  return AppBar(
    title: const Text('동물 랜덤채팅 애플리케이션',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xff008000),
  );
}
