import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeclimx/chatbot/model/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String CHAT_COLLECTION_REF = "chat";

class DatabaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _chatRef;

  // Assuming you have a function to get the current user's UUID
  String getCurrentUserUUID() {
    return _firebaseAuth.currentUser?.uid ??
        _firebaseAuth.currentUser?.email ??
        'default-fallback-value';
  }

  DatabaseService() {
    _chatRef = _firestore.collection(CHAT_COLLECTION_REF).withConverter<Chat>(
        fromFirestore: (snapshots, _) => Chat.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (chat, _) => chat.toJson());
  }

  Stream<DocumentSnapshot> getChat() {
    String uuid = getCurrentUserUUID();
    return _firestore.collection(CHAT_COLLECTION_REF).doc(uuid).snapshots();
  }

  Future<void> addChat(Chat chat) async {
    String uuid = getCurrentUserUUID();
    return _firestore
        .collection(CHAT_COLLECTION_REF)
        .doc(uuid)
        .set(chat.toJson());
  }

  Future<void> addChatMessage(Chat chat, String userId) async {
    print(chat);
    print(userId);
    await _firestore
        .collection(CHAT_COLLECTION_REF)
        .doc(userId)
        .collection("messages")
        .add({
      'sentMessage': chat.sentMessage,
      'receivedMessage': chat.receivedMessage,
      'sentTime': FieldValue
          .serverTimestamp(), // Automatically set the current server timestamp
      'receivedTime': FieldValue
          .serverTimestamp() // Automatically set the current server timestamp
    });
  }
}
