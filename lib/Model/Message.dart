import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String message;
  final String receiverID;
  final String senderEmail;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.message,
    required this.receiverID,
    required this.senderEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'message': message,
      'receiverID': receiverID,
      'senderEmail': senderEmail,
      'timestamp': timestamp,
    };
  }
}
