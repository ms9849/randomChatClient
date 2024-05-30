import 'package:flutter/material.dart';

Widget AlertRoomQuit(context, socket) {
  return AlertDialog(
    title: const Text('경고'),
    content: const Text('정말 채팅방을 퇴장하시겠습니까?'),
    actions: <Widget>[
      TextButton(
        child: const Text('확인'),
        onPressed: () {
            socket.emit('roomQuit');
            socket.close();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
      ),
      TextButton(
        child: const Text('취소'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}