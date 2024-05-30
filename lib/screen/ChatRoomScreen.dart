import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/Message.dart';
import '../widgets/AlertRoomQuit.dart';
import '../utils/getIcon.dart';

class ChatRoomScreen extends StatefulWidget {
  final IO.Socket socket;
  final String usersAnimal;
  final String usersNickname;

  const ChatRoomScreen(this.socket, this.usersAnimal, this.usersNickname,
      {super.key});

  @override
  ChatRoomScreenState createState() => ChatRoomScreenState();
}

class ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> messages = [];

  @override
  void initState() {
    widget.socket.on('message', (jsonData) {
      // 데이터 수신
      if (!mounted) return;
      Message msg = Message.fromJson(jsonData);
      setState(() {
        messages.add(msg);
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });

    widget.socket.on('partnerRoomQuit', (_) {
      // 상대방 퇴장
      if (!mounted) return;
      Message msg = Message(
          message: "상대방이 퇴장했습니다.",
          sender: "system",
          nickname: "system",
          animal: "");
      setState(() {
        messages.add(msg);
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });

    Message msg = Message(
        message: "매칭이 완료되었습니다.\n즐거운 대화 되세요!",
        sender: "system",
        nickname: "system",
        animal: "");
    setState(() {
      messages.add(msg);
    });

    super.initState();
  }

  void sendMessage() {
    // 데이터 송신
    Map<String, dynamic> msg = {
      'message': messageController.text.trim(),
      'nickname': widget.usersNickname,
      'animal': widget.usersAnimal,
    };
    if (msg["message"] == "") return;
    jsonEncode(msg);
    messageController.text = "";
    widget.socket.emit('messageSend', msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동물 랜덤채팅 애플리케이션'),
        leading: BackButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertRoomQuit(context, widget.socket);
              },
            );
          },
        ),
        backgroundColor: const Color(0xff008000),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              if(messages[index].sender == widget.socket.id) { // 사용자 자신이 보낸 메세지
                return ListTile(
                    title: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          constraints: const BoxConstraints(maxWidth: 320),
                          decoration: BoxDecoration(
                            color: const Color(0xffA0D468),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(messages[index].message,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 17)),
                        )
                    )
                );
              }
              else if(messages[index].sender == "system") { // 시스템이 보낸 메세지
                return ListTile(
                  title: Text(messages[index].message,
                      textAlign: TextAlign.center),
                );
              }
              else { // 상대방이 보낸 메세지
                return ListTile(
                    titleAlignment: ListTileTitleAlignment.top,
                    horizontalTitleGap: 10,
                    leading: CircleAvatar(
                        backgroundColor: const Color(0xffB8CCA3),
                        child: getIcon(messages[index].animal)),
                    title: Text(" ${messages[index].nickname}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 14)),
                    subtitle: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          padding:
                          const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          constraints:
                          const BoxConstraints(maxWidth: 320),
                          decoration: BoxDecoration(
                            color: const Color(0xffe9ecef),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(messages[index].message,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 17))),
                    )
                );
              }
            },
          )),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: '메세지를 입력하세요',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff008000)),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
