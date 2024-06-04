class Usage {
  final String screenName;
  final Duration duration;
  final String category;
  final DateTime timestamp;

  Usage(this.screenName, this.duration, this.category, this.timestamp);

  Usage.fromMap(Map<String, dynamic> map)
      : screenName = map['screenName'],
        duration = Duration(seconds: map['duration']),
        category = map['category'],
        timestamp = DateTime.parse(map['timestamp']);
}
