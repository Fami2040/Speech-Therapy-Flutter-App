import 'package:flutter/material.dart';
import 'package:speech_therapy/models/usage.dart';
import 'package:speech_therapy/utils/logging_util.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final LoggingUtil _loggingUtil = LoggingUtil();
  List<Usage> _usageData = [];
  String _mostUsedCategory = '';

  @override
  void initState() {
    super.initState();
    _fetchUsageData();
  }

  Future<void> _fetchUsageData() async {
    final data = await _loggingUtil.getUsageDataSortedByTimestamp();
    setState(() {
      _usageData = data;
      _mostUsedCategory = _calculateMostUsedCategory(data);
    });
  }

  String _calculateMostUsedCategory(List<Usage> data) {
    final categoryCount = <String, int>{};
    for (var usage in data) {
      categoryCount[usage.category] = (categoryCount[usage.category] ?? 0) + 1;
    }
    return categoryCount.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds} sec';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} min';
    } else {
      return '${duration.inHours} hr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usage Report',
          style: TextStyle(color: Colors.white), // Title text color
        ),
        backgroundColor: Colors.indigo, // Background color
        iconTheme: IconThemeData(color: Colors.white), // Back button color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Used Category: $_mostUsedCategory',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo, // Text color
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _usageData.length,
                itemBuilder: (context, index) {
                  final usage = _usageData[index];
                  return ListTile(
                    title: Text(
                      usage.category,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo, // Text color
                      ),
                    ),
                    subtitle: Text(
                      'Subcategory: ${usage.screenName}, Duration: ${_formatDuration(usage.duration)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700], // Text color
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
