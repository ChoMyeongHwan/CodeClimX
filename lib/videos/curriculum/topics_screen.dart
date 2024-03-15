import 'package:codeclimx/videos/curriculum/lecture_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  final String title;
  final String summary;
  final String startTime;
  final String videoUrl;
  final int second;

  Section(
      {required this.title,
      required this.summary,
      required this.startTime,
      required this.videoUrl,
      required this.second});
}

class TopicsScreen extends StatefulWidget {
  final String videoId;

  const TopicsScreen({super.key, required this.videoId});

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  late Future<List<Section>> sectionsFuture;

  @override
  void initState() {
    super.initState();
    sectionsFuture = fetchSections();
  }

  Future<List<Section>> fetchSections() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot sectionSnapshot = await firestore
          .collection('videos')
          .doc(widget.videoId)
          .collection('sections')
          .orderBy('timestamp')
          .get();

      List<Section> sections = sectionSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return Section(
          title: data['id'] ?? 'No Title',
          summary: data['section_desc'] ?? 'No Summary',
          startTime: data['timestamp'] ?? '00:00:00',
          videoUrl: data['url'] ?? '',
          second: data['second'] ?? 0,
        );
      }).toList();

      return sections;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to fetch sections');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sections Detail'),
      ),
      body: FutureBuilder<List<Section>>(
        future: sectionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sections found'));
          }
          final sections = snapshot.data!;
          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(sections[index].title),
                  subtitle: Text(sections[index].summary),
                  trailing: Text(sections[index].startTime),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            //LectureScreen(url: sections[index].videoUrl),
                            LectureScreen(sections[index].videoUrl,
                                sections[index].title, sections[index].second),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
