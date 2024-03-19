import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz.dart';

class FirebaseService {
  // 스트림 메서드는 Firestore의 'videos' 컬렉션의 실시간 스냅샷을 제공
  // 이 스트림은 호출하는 위젯에 비디오 데이터의 변화가 있을 때마다 업데이트를 전송
  static Stream<QuerySnapshot> streamVideos() {
    return FirebaseFirestore.instance.collection('videos').snapshots();
  }

  // loadQuizzes 메서드는 주어진 비디오 문서 ID에 해당하는 퀴즈들을 불러옴
  // 각 퀴즈 문서는 Quiz.fromMap 팩토리 생성자를 사용하여 Quiz 객체로 변환
  // 이 메서드는 비동기적으로 퀴즈 데이터를 가져오며, 완료되면 퀴즈 목록을 반환
  Future<List<Quiz>> loadQuizzes(String videoDocId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .where('video_id', isEqualTo: videoDocId)
        .get();

    return querySnapshot.docs
        .map((doc) => Quiz.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
