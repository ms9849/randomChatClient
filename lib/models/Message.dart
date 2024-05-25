/*
  {
  message: data,
  sender: socket.id,
  nickname: socket.nickname,
  }
*/

class Message {
  String message;
  String sender;
  String nickname; // sender nickname
  String animal; // class 였다면..

  Message({required this.message, required this.sender, required this.nickname, required this.animal});

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      message: jsonData['message'],
      sender: jsonData['sender'],
      nickname: jsonData['nickname'],
      animal: jsonData['animal'],
    );
  }
}