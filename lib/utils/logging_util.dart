
import 'package:speech_therapy/models/usage.dart';
import 'package:speech_therapy/models/usage_repository.dart';

class LoggingUtil {
  final UsageRepository _repository = UsageRepository();

  void logScreenUsage(String screenName, Duration duration, String category) {
    _repository.logUsage(screenName, duration, category);
  }

  Future<List<Usage>> getUsageData() async {
    return await _repository.getUsageData();
  }

  // Inside LoggingUtil class

Future<List<Usage>> getUsageDataSortedByTimestamp() async {
  // Assuming getUsageData() returns a list of Usage objects
  List<Usage> usageData = await getUsageData();
  
  // Sort the usage data list by timestamp in descending order
  usageData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  
  return usageData;
}

}
