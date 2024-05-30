import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ChatRoomScreen.dart';
import '../models/Question.dart';
import '../widgets/AppBarHeader.dart';
import '../utils/setAnimal.dart';
import '../utils/getAnimalName.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  LobbyScreenState createState() => LobbyScreenState();
}

class LobbyScreenState extends State<LobbyScreen> {
  String serverIP = 'http://34.125.192.212:3000';
  bool isMatching = false;
  List<String> animal = ["dog", "cat","bird", "fish"];

  Widget build(BuildContext context) {
    TextEditingController nicknameController = TextEditingController();
    final IO.Socket socket = IO.io(serverIP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': false
    });
    final questions = Provider.of<Question>(context).responses;
    final usersAnimal = animal[setAnimal(questions)];
    final animalName = getAnimalName(usersAnimal);

    void matchQuit() {
      socket.emit('matchQuit');
      Fluttertoast.showToast(
        msg: "매칭을 취소했습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 20.0
      );
      socket.close();
      setState(() {
        isMatching = false;
      });
    }

    void matchStart() {
      // 이 부분에 애니메이션 구현
      String usersNickname = nicknameController.text.trim();
      if (usersNickname == "") {
        Fluttertoast.showToast(
            msg: "닉네임을 빈칸으로 지정할 수 없습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 20.0
        );
        return;
      }

      Fluttertoast.showToast(
        msg: "매칭을 시작합니다...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 20.0
      );

      socket.connect(); // 서버 연결
      socket.emit('matchStart');
      setState(() {
        isMatching = true;
      });
      socket.on('matchFound', (_) => {
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomScreen(socket, usersAnimal, usersNickname))),
          }
      });
    }

    return Scaffold(
      appBar: AppBarHeader(),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(10.0),
              child: const Text("프로필 이미지가 설정되었습니다!\n\n당신과 어울리는 동물은\n",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)
              )
          ),
          /*
          * 동물 아이콘 출력 파트. 3항 연산자로 알맞은 동물을 출력하게 한다.
          * */
          usersAnimal == animal[0]
              ? const FaIcon(FontAwesomeIcons.dog, size: 80)
              : usersAnimal == animal[1]
                  ? const FaIcon(FontAwesomeIcons.cat, size: 80)
                  : usersAnimal == animal[2]
                      ? const FaIcon(FontAwesomeIcons.kiwiBird, size: 80)
                      : const FaIcon(FontAwesomeIcons.fish, size: 80),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text("$animalName\n",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                enabled: !isMatching,
                controller: nicknameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: !isMatching ? "닉네임을 입력하세요" : "매칭 중...",
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff008000)),
                  ),
                ),
              )
          ),
          Visibility(
              visible: !isMatching,
              child: ElevatedButton(
                  onPressed: () {
                    matchStart();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff008000)),
                  child: const Text("매칭 시작",
                      style: TextStyle(fontSize: 19, color: Colors.white))
              )
          ),
          Visibility(
              visible: isMatching,
              child: ElevatedButton(
                  onPressed: matchQuit,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF8A80)),
                  child: const Text("매칭 취소",
                      style: TextStyle(fontSize: 19, color: Colors.white))
              )
          )
        ],
      ),
    );
  }
}
