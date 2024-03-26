import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:codeclimx/common/widget/custom_bottom_navbar.dart';
import 'package:codeclimx/videos/curriculum/lecture_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  static const String routeName = 'videoSearch';
  static const String routeURL = '/videoSearch';

  const SearchResultsScreen({super.key});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final List<VideoItem> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false; // Add this line

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchSearchResults(String query) async {
    setState(() {
      _isLoading = true; // Start loading
    });
    var url = Uri.parse('http://121.141.139.43:9900/docsearch?text=$query');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      List<VideoItem> results = [];
      for (var item in jsonData) {
        results.add(VideoItem(
          item['second'].toInt(),
          item['url'],
          item['videoName'],
          item['text'],
        ));
      }
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(results);
        _isLoading = false; // Stop loading
      });
    } else {
      print('Failed to load search results');
      setState(() {
        _isLoading = false; // Stop loading even on failure
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Search Lecture Moment'),
                content: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Moment what you want',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _fetchSearchResults(_searchController.text);
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Show loading indicator
            : ListView.separated(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return ListTile(
                    leading: const Icon(Icons.video_library),
                    title: Text(
                      item.videoName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item.text),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LectureScreen(
                            item.url, item.videoName, item.second, item.text),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 1),
    );
  }
}

class VideoItem {
  final int second;
  final String url;
  final String videoName;
  final String text;

  VideoItem(this.second, this.url, this.videoName, this.text);
}
