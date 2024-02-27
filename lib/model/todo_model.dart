import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  TodoModel({
    required this.id,
    required this.senderMail,
    required this.title,
    required this.description,
    required this.status,
    required this.receiverMail,
  });

  String id;
  String senderMail;
  String title;
  String description;
  bool status;
  String receiverMail;

  factory TodoModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return TodoModel(
      id: json.id,
      senderMail: json['sender_mail'],
      title: json['title'],
      description: json['description'],
      status: json['status'] == 1 ? true : false,
      receiverMail: json['receiver_mail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderMail': senderMail,
      'title': title,
      'description': description,
      'status': status,
      'receiverMail': receiverMail,
    };
  }
}
