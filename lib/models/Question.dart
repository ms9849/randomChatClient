import 'package:flutter/material.dart';

class Question extends ChangeNotifier {
  List<int> _responses = [];
  List<int> get responses => _responses;

  void setResponse(int index, int response) {
    if(_responses.length >= 3) _responses = []; //초기화
    _responses.add(response);
    notifyListeners();
  }
}