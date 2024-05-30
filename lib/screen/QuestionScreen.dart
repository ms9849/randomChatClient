import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './LobbyScreen.dart';
import '../models/Question.dart';
import '../widgets/AppBarHeader.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/question1',
      routes: {
        '/question1': (context) =>
            QuestionList(question: '누군가와 금방 친해질 수 있나요?', index: 1),
        '/question2': (context) =>
            QuestionList(question: '넓고 얕은 인간 관계를 선호하나요?', index: 2),
        '/question3': (context) =>
            QuestionList(question: '여행하는 것을 좋아하세요?', index: 3),
      },
    );
  }
}

class QuestionList extends StatelessWidget {
  final String question;
  final int index;

  QuestionList({super.key, required this.question, required this.index});

  @override
  Widget build(BuildContext context) {
    final questionModel = Provider.of<Question>(context);

    void nextQuestion(int num) {
      questionModel.setResponse(index, num);
      if (index < 3) {
        Navigator.pushNamed(context, '/question${index + 1}');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LobbyScreen()),
        );
      }
    }

    return Scaffold(
      appBar: AppBarHeader(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: const EdgeInsets.only(bottom: 60),
                    constraints: const BoxConstraints(
                      minWidth: 500,
                      minHeight: 200,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffe8edf7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(children: [
                      Text(
                        "질문 $index.\n",
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        question,
                        style: const TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ])
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 380,
                      child: ElevatedButton(
                          onPressed: () => {nextQuestion(0)},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff008000)),
                          child: const Text("네",
                              style: TextStyle(
                                  fontSize: 19, color: Colors.white)
                          )
                      ),
                    ),
                    SizedBox(
                      width: 380,
                      child: ElevatedButton(
                          onPressed: () => {nextQuestion(1)},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff008000)),
                          child: const Text("아니오",
                              style: TextStyle(
                                  fontSize: 19, color: Colors.white)
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
