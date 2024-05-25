import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgProvider;
import '../widgets/AppBarHeader.dart';
import 'QuestionScreen.dart';

class AnimalChatApp extends StatelessWidget {
  const AnimalChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(),
      body: Align(
        alignment: Alignment.center,
        child:
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:30,bottom:30),
                width: 380,
                height: 380,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: svgProvider.Svg('images/bg.svg'),
                    fit: BoxFit.fitHeight
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:20, right:20),
                child: const Column(
                  children: [
                    Text(
                        "단국대학교 2024년 1학기 모바일플랫폼 기말 평가 프로젝트입니다.\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        )
                    ),
                    Text(
                        "간단한 몇가지 질문들을 통해 사용자와 어울리는 동물 프로필을 배정받고, 원하는 닉네임을 사용하여 무작위 상대와 채팅이 가능합니다.\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        )
                    ),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top:50),
                width: 380,
                child: ElevatedButton(
                  onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen()))},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff008000)
                  ),
                  child: const Text("시작",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white
                    )
                  )
               ),
              )
            ])
        )
      );
  }
}