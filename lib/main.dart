import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screen/AnimalChatApp.dart';
import '../models/Question.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (conext) => Question(),
      child: const MaterialApp(
          home: AnimalChatApp()
      ),
    ),
  );
}