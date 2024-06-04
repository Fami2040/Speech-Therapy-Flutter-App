import 'package:flutter/material.dart';
import 'package:speech_therapy/models/usage.dart';
import 'package:speech_therapy/utils/logging_util.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final LoggingUtil _loggingUtil = LoggingUtil();
  List<Usage> _usageData = [];
  Map<String, int> _categoryUsageCount = {};
  List<String> _allCategories = [
    'Reference Categories',
    'Speechs Categories',
    'Material Categories',
    'Food Categories',
    'Feeling Categories',
    'Family Categories',
    'Color Categories',
    'Clothing Categories',
    'Body Part Categories',
    'Animal Categories',
    'Action Categories',
    'Numbers Categories',
    'Alphabets Categories'

    // Add more categories as needed
  ];

  @override
  void initState() {
    super.initState();
    _fetchUsageData();
  }

  Future<void> _fetchUsageData() async {
    try {
      final data = await _loggingUtil.getUsageData();
      setState(() {
        _usageData = data;
        _calculateCategoryUsageCount();
      });
    } catch (e) {
      print('Failed to fetch usage data: $e');
    }
  }

  void _calculateCategoryUsageCount() {
    _categoryUsageCount.clear();
    for (var usage in _usageData) {
      _categoryUsageCount[usage.category] =
          (_categoryUsageCount[usage.category] ?? 0) + 1;
    }
  }

  List<String> _getLowUsageCategories() {
    // Identify categories with low usage based on usage count
    List<String> lowUsageCategories = [];
    _categoryUsageCount.forEach((category, count) {
      if (count < 5) {
        lowUsageCategories.add(category);
      }
    });
    // Include categories that have not been used by the user
    for (var category in _allCategories) {
      if (!_categoryUsageCount.containsKey(category)) {
        lowUsageCategories.add(category);
      }
    }
    return lowUsageCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: TextStyle(color: Colors.white), // Title text color
        ),
        backgroundColor: Colors.indigo, // Background color
        iconTheme: IconThemeData(color: Colors.white), // Back button color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildFeedback(),
      ),
    );
  }

  Widget _buildFeedback() {
    final lowUsageCategories = _getLowUsageCategories();

    if (lowUsageCategories.isEmpty) {
      return Center(
        child: Text(
          'Great job! Keep up the good work.',
          style: TextStyle(fontSize: 20, color: Colors.indigo), // Text style
        ),
      );
    } else {
      return ListView(
        children: [
          Text(
            'መሻሻል የሚያስፈልጋቸው ቦታዎች:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo, // Text color
              fontSize: 20, // Font size
            ),
          ),
          for (var category in lowUsageCategories)
            ListTile(
              title: Text(
                'ውስጥ የበለጠ ያስሱ $category',
                style:
                    TextStyle(fontSize: 18, color: Colors.indigo), // Text style
              ),
              subtitle: Text(
                'በተያያዙ እንቅስቃሴዎች ላይ ተጨማሪ ጊዜ ለማሳለፍ ይሞክሩ $category',
                style: TextStyle(color: Colors.grey[700]), // Text style
              ),
            ),
        ],
      );
    }
  }
}
