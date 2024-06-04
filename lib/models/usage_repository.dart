import 'package:speech_therapy/database/database_helper.dart';

import 'usage.dart';

class UsageRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> logUsage(String screenName, Duration duration, String category) async {
    await _databaseHelper.insertUsage(screenName, duration, category);
  }

  Future<List<Usage>> getUsageData() async {
    final data = await _databaseHelper.getUsageData();
    return data.map((e) => Usage.fromMap(e)).toList();
  }
}
