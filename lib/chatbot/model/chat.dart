import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String sentMessage;
  String receivedMessage;
  Timestamp sentTime;
  Timestamp receivedTime;

  Chat(
      {required this.sentMessage,
      required this.receivedMessage,
      required this.sentTime,
      required this.receivedTime});

  Chat.fromJson(Map<String, Object?> json)
      : this(
            sentMessage: json['sentMessage']! as String,
            receivedMessage: json['ReceivedMessage']! as String,
            sentTime: json['sentTime']! as Timestamp,
            receivedTime: json['receivedTime']! as Timestamp);

  Chat copyWith(
      {String? sentMessage,
      String? receivedMessage,
      Timestamp? sentTime,
      Timestamp? receivedTime}) {
    return Chat(
        sentMessage: sentMessage ?? this.sentMessage,
        receivedMessage: receivedMessage ?? this.receivedMessage,
        sentTime: sentTime ?? this.sentTime,
        receivedTime: receivedTime ?? this.receivedTime);
  }

  Map<String, Object?> toJson() {
    return {
      "sentMessage": sentMessage,
      "receivedMessage": receivedMessage,
      "sentTime": sentTime,
      "receivedTime": receivedTime
    };
  }
}
